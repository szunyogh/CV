import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_state.freezed.dart';

@freezed
class FileState with _$FileState {
  const FileState._();
  const factory FileState({@Default(0.0) double progress}) = _FileState;
}
