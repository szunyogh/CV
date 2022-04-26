import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/state/image_state.dart';
import 'package:common/repository/image_repository.dart';
import 'package:common/repository/interface/image_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageLogic = StateNotifierProvider.family<ImageLogic, ImageState, String>((ref, id) => ImageLogic(ref.read, id));

class ImageLogic extends BaseLogic<ImageState> {
  final String id;
  ImageLogic(Reader read, this.id) : super(read, const ImageState());

  IImageRepository get repo => read(imageRepo);

  String get userId => read(authenticationLogic).userId;

  @override
  Future<void> initialize() async {}

  Future<void> uploadImage(XFile file) async {
    repo.uploadImage(userId, file).listen((event) async {
      state = state.copyWith(progress: (event.bytesTransferred / event.totalBytes));
      if (event.state == TaskState.success) {
        final picture = await downloadImage(file);
        sendImage(picture);
      } else if (event.state == TaskState.error) {
        removeImage();
      }
    });
  }

  Future<String> downloadImage(XFile file) async {
    return repo.downloadImage(userId, file);
  }

  Future<void> getImage(XFile? file) async {
    if (file == null) return;
    final request = Chat(id: id, dateSent: DateTime.now(), picture: file.path, sender: userId);
    await repo.getImage(request.toJson(), userId);
    uploadImage(file);
  }

  Future<void> sendImage(String picture) async {
    await repo.sendImage(userId, id, picture);
  }

  Future<void> removeImage() async {
    await repo.removeImage(userId, id);
  }
}
