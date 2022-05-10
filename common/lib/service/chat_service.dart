import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/model/response/chat.dart';
import 'package:http/http.dart';

class ChatService {
  Future<String> sendMessage(Map<String, dynamic> data, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('chat')
        .add(data)
        .then((value) => value.id);
  }

  Stream<List<Chat>> getMessages(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('chat')
        .orderBy('dateSent', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        final json = e.data();
        json.addAll({"id": e.id});
        return Chat.fromJson(json);
      }).toList();
    });
  }

  Stream<bool> getTyping(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .snapshots()
        .map((event) => event.data()?['typingStatus']['user_1'] ?? false);
  }

  Future<Response> sendPushNoti(String messageToken, int id, String title, String body) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    final header = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAFOQM9LU:APA91bFZ3wKMth6RqiFsRzhF8WmVJZ2KAb0FFlLvCGLvrNYlt-LslrFeG0qI9TBn5JDvuYjPWmsr4wtCoWm_tcrh-x9panXu2mSlcA5_Xv_1lucEeKu7xEV6NnbXOTkbS0XCsyU2EQ7r",
    };
    final request = {
      "to": messageToken,
      "notification": {"title": title, "android_channel_id": "message_channel", "body": body},
      "priority": "HIGH",
      "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": id}
    };
    final client = Client();
    return await client.post(Uri.parse(url), headers: header, body: json.encode(request));
  }

  Stream<int> getBadsge(String id) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('chat')
        .where('sender', isNotEqualTo: id)
        .where('isSee', isEqualTo: false)
        .snapshots()
        .map((event) => event.docs.length);
  }

  Future<void> updateMessage(String id) async {
    DocumentReference<Map<String, dynamic>> chat = FirebaseFirestore.instance.collection('users').doc(id);

    WriteBatch batch = FirebaseFirestore.instance.batch();

    return await chat
        .collection('chat')
        .where('isUpload', isEqualTo: false)
        .where("file.url", isEqualTo: "")
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var document in querySnapshot.docs) {
          batch.update(document.reference, {"isUpload": true, "id": document.id});
        }
        batch.commit();
      }
    });
  }

  Future<void> updateMessageSaw(String id) async {
    DocumentReference<Map<String, dynamic>> chat = FirebaseFirestore.instance.collection('users').doc(id);

    WriteBatch batch = FirebaseFirestore.instance.batch();

    return await chat
        .collection('chat')
        .where('sender', isNotEqualTo: id)
        .where('isSee', isEqualTo: false)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var document in querySnapshot.docs) {
          batch.update(document.reference, {"isSee": true});
        }
        return batch.commit();
      }
    });
  }

  Future<void> typingStatus(String id, int index, bool typing) async {
    final typingData = index == 0 ? {"user_1": typing} : {"user_2": typing};
    FirebaseFirestore.instance.collection('users').doc(id).set({'typingStatus': typingData}, SetOptions(merge: true));
  }

  Future<void> deleteLike(String uId, String messageId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(messageId)
        .set({'like': ""}, SetOptions(merge: true));
  }

  Future<void> updateLike(String uId, String messageId, String like) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(messageId)
        .set({'like': like}, SetOptions(merge: true));
  }
}
