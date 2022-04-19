import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';

@freezed
class Image with _$Image {
  const factory Image({
    @Default(0.0) double progress,
    @Default(TaskState.running) TaskState state,
  }) = _Image;
}
