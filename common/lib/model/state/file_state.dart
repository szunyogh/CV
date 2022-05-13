import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';

part 'file_state.freezed.dart';

@freezed
class FileState with _$FileState {
  const FileState._();
  const factory FileState({
    @Default(0.0) double progress,
    File? file,
    @Default(Duration.zero) Duration duration,
    @Default(Duration.zero) Duration position,
    @Default(false) bool isPlaying,
    VideoPlayerController? controller,
    @Default(false) bool isInitialized,
  }) = _FileState;
}
