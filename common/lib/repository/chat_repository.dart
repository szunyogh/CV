import 'package:common/model/response/chat.dart';
import 'package:common/repository/interface/chat_interface.dart';
import 'package:common/service/chat_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final chatRepo = Provider<IChatRepository>((ref) => ChatRepository());

class ChatRepository implements IChatRepository {
  ChatRepository();

  ChatService get service => ChatService();

  @override
  Future<void> sendMessage(Map<String, dynamic> data, String id) async {
    try {
      await service.sendMessage(data, id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<Response> sendPushNoti(String messageToken, int id, String title, String body) async {
    try {
      final response = await service.sendPushNoti(messageToken, id, title, body);
      if (response.statusCode != 200) {
        throw Exception();
      }
      return response;
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> typingStatus(String id, int index, bool typing) async {
    try {
      await service.typingStatus(id, index, typing);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> updateMessage(String id) async {
    try {
      await service.updateMessage(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> updateMessageSaw(String id) async {
    try {
      await service.updateMessageSaw(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Stream<List<Chat>> getMessages(String id) {
    try {
      return service.getMessages(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Stream<bool> getTyping(String id) {
    try {
      return service.getTyping(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Stream<int> getBadsge(String id) {
    try {
      return service.getBadsge(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> deleteLike(String uId, String messageId) async {
    try {
      await service.deleteLike(uId, messageId);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> updateLike(String uId, String messageId, String like) async {
    try {
      await service.updateLike(uId, messageId, like);
    } catch (err) {
      throw Exception();
    }
  }
}
