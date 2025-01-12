import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:common/helper/exception.dart';
import 'dart:io';
import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/logic/file_logic.dart';
import 'package:common/logic/loader_logic.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/user.dart';
import 'package:common/model/state/chat_state.dart';
import 'package:common/repository/chat_repository.dart';
import 'package:common/repository/interface/chat_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final chatLogic = StateNotifierProvider<ChatLogic, ChatState>((ref) => ChatLogic(ref.read));

class ChatLogic extends BaseLogic<ChatState> {
  ChatLogic(Reader read) : super(read, const ChatState());

  bool oneTimeRun = false;

  IChatRepository get repo => read(chatRepo);

  User get user => read(authenticationLogic).currentUser;

  ConnectivityResult connectivity = ConnectivityResult.none;

  AudioPlayer? player;
  Timer? timer;

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

  Future<StreamSubscription<List<Chat>>?> getMessage() async {
    StreamSubscription<List<Chat>>? streamSubscription;
    try {
      streamSubscription = repo.getMessages(user.id).listen((event) async {
        if (event.isEmpty) {
          DefaultCacheManager().emptyCache();
        }
        state = state.copyWith(chats: event);
        if (connectivity != ConnectivityResult.none) {
          updateMessageSaw();
          updateMessage();
        }
      });
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
    return streamSubscription;
  }

  Future<StreamSubscription<int>?> getBadge() async {
    StreamSubscription<int>? streamSubscription;
    try {
      streamSubscription = repo.getBadge(user.id).listen((event) {
        state = state.copyWith(badgeCount: event);
      });
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
    return streamSubscription;
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

  void stopTypingSound() {
    player?.stop();
    player?.dispose();
    timer?.cancel();
    timer = null;
    player = null;
  }

  void playTypingSound() async {
    player ??= AudioPlayer();
    if (player != null) {
      final bytes = await rootBundle.load('assets/audio/typing.mp3');
      final audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      final result = await player?.playBytes(audiobytes);
      if (result == 1) {
        final duration = await player?.onDurationChanged.first;
        timer ??= Timer.periodic(duration ?? Duration.zero + const Duration(milliseconds: 200), (timer) {
          player?.resume();
        });
      }
    }
  }

  Future<StreamSubscription<bool>?> getTyping() async {
    StreamSubscription<bool>? streamSubscription;
    try {
      streamSubscription = repo.getTyping(user.id).listen((event) async {
        state = state.copyWith(isTyping: event);
        if (event) {
          playTypingSound();
        } else {
          stopTypingSound();
        }
      });
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
    return streamSubscription;
  }

  Future<void> sendMessage(String message) async {
    try {
      final request = Chat(dateSent: DateTime.now(), message: message, sender: user.id);
      await repo.sendMessage(request.toJson(), user.id);
      await sendPushNoti(message);
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }

  Future<void> sendPushNoti(String message) async {
    try {
      final token = read(profileLogic).profile.fcmToken;
      await repo.sendPushNoti(token, user.notificationId, user.name, message);
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }

  Future<void> deleteLike(String messageId) async {
    try {
      await repo.deleteLike(user.id, messageId);
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }

  Future<void> updateLike(String messageId, String like) async {
    try {
      await repo.updateLike(user.id, messageId, like);
      read(chatLogic.notifier).sendPushNoti("${user.name} kedvelte az egyik üzenetét");
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }

  Future<void> updateMessage() async {
    try {
      await repo.updateMessage(user.id);
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }

  Future<void> updateMessageSaw() async {
    try {
      await repo.updateMessageSaw(user.id);
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }

  Future<void> typingStatus(bool typing) async {
    try {
      await repo.typingStatus(user.id, 1, typing);
    } catch (e) {
      String error = ExceptionHelper.getExceptionMessage(e.toString());
      read(loaderLogic.notifier).showError(error);
    }
  }
}
