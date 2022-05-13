import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileService {
  Future<void> getFile(Map<String, dynamic> data, String id) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).collection('chat').doc(data["id"]).set(data);
  }

  Stream<TaskSnapshot> uploadFile(String id, String name, File file) {
    return FirebaseStorage.instance.ref('$id/$name').putFile(File(file.path)).snapshotEvents.map((event) {
      return event;
    });
  }

  Future<String> downloadFile(String id, String name, File file) async {
    return await FirebaseStorage.instance.ref('$id/$name').getDownloadURL();
  }

  Future<void> removeFile(String uId, String imageId) async {
    return await FirebaseFirestore.instance.collection('users').doc(uId).collection('chat').doc(imageId).delete();
  }

  Future<void> sendFile(String uId, String imageId, String url, String type) async {
    return await FirebaseFirestore.instance.collection('users').doc(uId).collection('chat').doc(imageId).set({
      "isUpload": true,
      "file": {"url": url, "type": type}
    }, SetOptions(merge: true));
  }
}
