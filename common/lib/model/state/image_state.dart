import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_state.freezed.dart';

@freezed
class ImageState with _$ImageState {
  const ImageState._();
  const factory ImageState({@Default(0.0) double progress}) = _ImageState;
}
