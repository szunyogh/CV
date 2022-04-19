import 'package:common/model/response/chat.dart';
import 'package:http/http.dart';

abstract class IChatRepository {
  Future<void> sendMessage(Map<String, dynamic> data, String id);

  Future<Response> sendPushNoti(String messageToken, int id, String title, String body);

  Future<void> updateMessage(String id);

  Future<void> updateMessageSaw(String id);

  Future<void> typingStatus(String id, int index, bool typing);

  Stream<List<Chat>> getMessages(String id);

  Stream<bool> getTyping(String id);
}
