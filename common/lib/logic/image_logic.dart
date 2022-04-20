import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/user.dart';
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

  User get user => read(authenticationLogic).currentUser;

  @override
  Future<void> initialize();

  Future<void> uploadImage(XFile file) async {
    repo.uploadImage(user.id, file).listen((event) async {
      state = state.copyWith(image: event);
      if (event.state == TaskState.success) {
        final picture = await downloadImage(file);
        sendImage(picture);
      } else if (event.state == TaskState.error) {
        removeImage();
      }
    });
  }

  Future<String> downloadImage(XFile file) async {
    return repo.downloadImage(user.id, file);
  }

  Future<void> getImage(XFile? file) async {
    if (file == null) return;
    final request = Chat(id: id, dateSent: DateTime.now(), picture: file.path, sender: user.id);
    await repo.getImage(request.toJson(), user.id);
    uploadImage(file);
    state = state.copyWith(imageId: id);
  }

  Future<void> sendImage(String picture) async {
    await repo.sendImage(user.id, id, picture);
  }

  Future<void> removeImage() async {
    await repo.removeImage(user.id, id);
  }
}
