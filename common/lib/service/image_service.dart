import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/model/response/image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<String> getImage(Map<String, dynamic> data, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('chat')
        .add(data)
        .then((value) => value.id);
  }

  Stream<Image> uploadImage(String id, XFile file) {
    return FirebaseStorage.instance.ref('$id/${file.name}').putFile(File(file.path)).snapshotEvents.map((event) {
      return Image(progress: event.bytesTransferred / event.totalBytes, state: event.state);
    });
  }

  Future<void> removeImage(String uId, String imageId) async {
    return await FirebaseFirestore.instance.collection('users').doc(uId).collection('chat').doc(imageId).delete();
  }

  Future<void> sendImage(String uId, String imageId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chat')
        .doc(imageId)
        .update({"isUpload": true});
  }
}
