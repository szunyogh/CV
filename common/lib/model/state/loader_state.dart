import 'package:freezed_annotation/freezed_annotation.dart';

part 'loader_state.freezed.dart';

@freezed
class LoaderState with _$LoaderState {
  const LoaderState._();
  const factory LoaderState({
    @Default(false) bool hide,
    @Default("") String message,
  }) = _LoaderState;
}
