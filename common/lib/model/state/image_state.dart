import 'package:common/model/response/chat.dart';
import 'package:common/model/response/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_state.freezed.dart';

@freezed
class ImageState with _$ImageState {
  const ImageState._();
  const factory ImageState({
    @Default(Image(progress: 0.0)) image,
    @Default("") String imageId,
  }) = _ImageState;
}
