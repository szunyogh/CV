import 'dart:io';
import 'package:common/repository/interface/file_interface.dart';
import 'package:common/service/file_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

final fileRepo = Provider<IFileRepository>((ref) => FileRepository());

class FileRepository implements IFileRepository {
  FileRepository();

  FileService get service => FileService();

  @override
  Future<void> getFile(Map<String, dynamic> data, String id) async {
    try {
      await service.getFile(data, id);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Future<void> removeFile(String uId, String imageId) async {
    try {
      await service.removeFile(uId, imageId);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Future<void> sendFile(String uId, String imageId, String url, String type) async {
    try {
      await service.sendFile(uId, imageId, url, type);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Stream<TaskSnapshot> uploadFile(String id, String name, File file) {
    try {
      return service.uploadFile(id, name, file);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Future<String> downloadFile(String id, String name, File file) {
    try {
      return service.downloadFile(id, name, file);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }
}
