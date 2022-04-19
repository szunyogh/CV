import 'package:common/model/response/image.dart';
import 'package:common/repository/interface/image_interface.dart';
import 'package:common/service/image_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageRepo = Provider<IImageRepository>((ref) => ImageRepository());

class ImageRepository implements IImageRepository {
  ImageRepository();

  ImageService get service => ImageService();

  @override
  Future<String> getImage(Map<String, dynamic> data, String id) async {
    try {
      return await service.getImage(data, id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> removeImage(String uId, String imageId) async {
    try {
      await service.removeImage(uId, imageId);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<void> sendImage(String uId, String imageId) async {
    try {
      await service.sendImage(uId, imageId);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Stream<Image> uploadImage(String id, XFile file) {
    try {
      return service.uploadImage(id, file);
    } catch (err) {
      throw Exception();
    }
  }
}
