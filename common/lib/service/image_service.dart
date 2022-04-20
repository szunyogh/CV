import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/model/response/image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<void> getImage(Map<String, dynamic> data, String id) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).collection('chat').doc(data["id"]).set(data);
  }

  Stream<Image> uploadImage(String id, XFile file) {
    return FirebaseStorage.instance.ref('$id/${file.name}').putFile(File(file.path)).snapshotEvents.map((event) {
      return Image(progress: event.bytesTransferred / event.totalBytes, state: event.state);
    });
  }

  Future<String> downloadImage(String id, XFile file) async {
    return await FirebaseStorage.instance.ref('$id/${file.name}').getDownloadURL();
  }

  Future<void> removeImage(String uId, String imageId) async {
    return await FirebaseFirestore.instance.collection('users').doc(uId).collection('chat').doc(imageId).delete();
  }

  Future<void> sendImage(String uId, String imageId, String picture) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(imageId)
        .update({"isUpload": true, "picture": picture});
  }
}
