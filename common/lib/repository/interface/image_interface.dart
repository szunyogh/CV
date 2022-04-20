import 'package:common/model/response/image.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageRepository {
  Future<void> getImage(Map<String, dynamic> data, String id);

  Stream<Image> uploadImage(String id, XFile file);

  Future<void> removeImage(String uId, String imageId);

  Future<String> downloadImage(String id, XFile file);

  Future<void> sendImage(String uId, String imageId, String picture);
}
