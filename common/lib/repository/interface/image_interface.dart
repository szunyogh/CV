import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageRepository {
  Future<void> getImage(Map<String, dynamic> data, String id);

  Stream<TaskSnapshot> uploadImage(String id, XFile file);

  Future<void> removeImage(String uId, String imageId);

  Future<String> downloadImage(String id, XFile file);

  Future<void> sendImage(String uId, String imageId, String picture);
}
