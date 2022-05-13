import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/logic/file_logic.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/user.dart';
import 'package:common/model/state/chat_state.dart';
import 'package:common/repository/chat_repository.dart';
import 'package:common/repository/interface/chat_interface.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:path_provider/path_provider.dart';

final chatLogic = StateNotifierProvider<ChatLogic, ChatState>((ref) => ChatLogic(ref.read));

class ChatLogic extends BaseLogic<ChatState> {
  ChatLogic(Reader read) : super(read, const ChatState());

  bool oneTimeRun = false;

  IChatRepository get repo => read(chatRepo);

  User get user => read(authenticationLogic).currentUser;

  ConnectivityResult connectivity = ConnectivityResult.none;

  @override
  Future<StreamSubscription<ConnectivityResult>> initialize({bool initialize = false}) async {
    if (initialize) {
      await read(authenticationLogic.notifier).initialize();
    }
    return Connectivity().onConnectivityChanged.listen((_connectivity) {
      connectivity = _connectivity;
      if (_connectivity != ConnectivityResult.none) {
        updateMessageSaw();
        updateMessage();
        updateFile(state.chats);
      }
    });
  }

  Future<StreamSubscription<List<Chat>>> getMessage() async {
    return repo.getMessages(user.id).listen((event) async {
      if (event.isEmpty) {
        DefaultCacheManager().emptyCache();
      }
      state = state.copyWith(chats: event);
      if (connectivity != ConnectivityResult.none) {
        updateMessageSaw();
        updateMessage();
      }
    });
  }

  Future<void> getBadge() async {
    repo.getBadsge(user.id).listen((event) {
      state = state.copyWith(badgeCount: event);
    });
  }

  void updateFile(List<Chat> chats) async {
    if (!oneTimeRun) {
      final uploadList =
          state.chats.where((element) => element.isUpload == false && (element.file['url'] as String).isNotEmpty).toList();
      for (var item in uploadList) {
        final name = item.id.split('-').last;
        final type = item.file['type'] ?? "";
        final file = File(item.file['url'] ?? "");
        read(fileLogic(item.id).notifier).uploadFile(name, file, type);
      }
      oneTimeRun = true;
    }
  }

  Future<StreamSubscription<bool>> getTyping() async {
    return repo.getTyping(user.id).listen((event) async {
      state = state.copyWith(isTyping: event);
    });
  }

  Future<void> sendMessage(String message) async {
    final request = Chat(dateSent: DateTime.now(), message: message, sender: user.id);
    await repo.sendMessage(request.toJson(), user.id);
    await sendPushNoti(message);
  }

  Future<void> sendPushNoti(String message) async {
    final token = read(profileLogic).profile.fcmToken;
    await repo.sendPushNoti(token, user.notificationId, user.name, message);
  }

  Future<void> deleteLike(String messageId) async {
    await repo.deleteLike(user.id, messageId);
  }

  Future<void> updateLike(String messageId, String like) async {
    await repo.updateLike(user.id, messageId, like);
    read(chatLogic.notifier).sendPushNoti("${user.name} kedvelte az egyik üzenetét");
  }

  Future<void> updateMessage() async {
    await repo.updateMessage(user.id);
  }

  Future<void> updateMessageSaw() async {
    await repo.updateMessageSaw(user.id);
  }

  Future<void> typingStatus(bool typing) async {
    await repo.typingStatus(user.id, 1, typing);
  }
}
