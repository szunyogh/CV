import 'package:common/model/response/image.dart';
import 'package:image_picker/image_picker.dart';

abstract class IImageRepository {
  Future<String> getImage(Map<String, dynamic> data, String id);

  Stream<Image> uploadImage(String id, XFile file);

  Future<void> removeImage(String uId, String imageId);

  Future<void> sendImage(String uId, String imageId);
}
