import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/user.dart';
import 'package:common/model/state/image_state.dart';
import 'package:common/repository/image_repository.dart';
import 'package:common/repository/interface/image_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageLogic = StateNotifierProvider<ImageLogic, ImageState>((ref) => ImageLogic(ref.read));

class ImageLogic extends BaseLogic<ImageState> {
  ImageLogic(Reader read) : super(read, const ImageState());

  IImageRepository get repo => read(imageRepo);

  User get user => read(authenticationLogic).currentUser;

  @override
  Future<void> initialize();

  Future<void> uploadImage(XFile file) async {
    repo.uploadImage(user.id, file).listen((event) async {
      state = state.copyWith(image: event);
    });
  }

  Future<void> sendImage() async {
    await repo.sendImage(user.id, state.imageId);
  }
}
