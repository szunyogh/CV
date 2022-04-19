import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/logic/profile_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/user.dart';
import 'package:common/model/state/chat_state.dart';
import 'package:common/repository/chat_repository.dart';
import 'package:common/repository/interface/chat_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final chatLogic = StateNotifierProvider<ChatLogic, ChatState>((ref) => ChatLogic(ref.read));

class ChatLogic extends BaseLogic<ChatState> {
  ChatLogic(Reader read) : super(read, const ChatState());

  IChatRepository get repo => read(chatRepo);

  User get user => read(authenticationLogic).currentUser;

  @override
  Future<void> initialize() async {
    getTyping();
    repo.getMessages(user.id).listen((event) async {
      state = state.copyWith(chats: event);
      updateMessageSaw();
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        updateMessage();
      }
    });
  }

  Future<void> getTyping() async {
    repo.getTyping(user.id).listen((event) async {
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
