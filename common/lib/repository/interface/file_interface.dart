import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

abstract class IFileRepository {
  Future<void> getFile(Map<String, dynamic> data, String id);

  Stream<TaskSnapshot> uploadFile(String id, String name, File file);

  Future<void> removeFile(String uId, String imageId);

  Future<String> downloadFile(String id, String name, File file);

  Future<void> sendFile(String uId, String imageId, String url, String type);
}
