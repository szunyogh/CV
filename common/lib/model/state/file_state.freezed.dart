// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'file_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FileStateTearOff {
  const _$FileStateTearOff();

  _FileState call(
      {double progress = 0.0,
      File? file,
      Duration duration = Duration.zero,
      Duration position = Duration.zero,
      bool isPlaying = false,
      VideoPlayerController? controller}) {
    return _FileState(
      progress: progress,
      file: file,
      duration: duration,
      position: position,
      isPlaying: isPlaying,
      controller: controller,
    );
  }
}

/// @nodoc
const $FileState = _$FileStateTearOff();

/// @nodoc
mixin _$FileState {
  double get progress => throw _privateConstructorUsedError;
  File? get file => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  VideoPlayerController? get controller => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FileStateCopyWith<FileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileStateCopyWith<$Res> {
  factory $FileStateCopyWith(FileState value, $Res Function(FileState) then) =
      _$FileStateCopyWithImpl<$Res>;
  $Res call(
      {double progress,
      File? file,
      Duration duration,
      Duration position,
      bool isPlaying,
      VideoPlayerController? controller});
}

/// @nodoc
class _$FileStateCopyWithImpl<$Res> implements $FileStateCopyWith<$Res> {
  _$FileStateCopyWithImpl(this._value, this._then);

  final FileState _value;
  // ignore: unused_field
  final $Res Function(FileState) _then;

  @override
  $Res call({
    Object? progress = freezed,
    Object? file = freezed,
    Object? duration = freezed,
    Object? position = freezed,
    Object? isPlaying = freezed,
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
    ));
  }
}

/// @nodoc
abstract class _$FileStateCopyWith<$Res> implements $FileStateCopyWith<$Res> {
  factory _$FileStateCopyWith(
          _FileState value, $Res Function(_FileState) then) =
      __$FileStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {double progress,
      File? file,
      Duration duration,
      Duration position,
      bool isPlaying,
      VideoPlayerController? controller});
}

/// @nodoc
class __$FileStateCopyWithImpl<$Res> extends _$FileStateCopyWithImpl<$Res>
    implements _$FileStateCopyWith<$Res> {
  __$FileStateCopyWithImpl(_FileState _value, $Res Function(_FileState) _then)
      : super(_value, (v) => _then(v as _FileState));

  @override
  _FileState get _value => super._value as _FileState;

  @override
  $Res call({
    Object? progress = freezed,
    Object? file = freezed,
    Object? duration = freezed,
    Object? position = freezed,
    Object? isPlaying = freezed,
    Object? controller = freezed,
  }) {
    return _then(_FileState(
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      isPlaying: isPlaying == freezed
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      controller: controller == freezed
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as VideoPlayerController?,
    ));
  }
}

/// @nodoc

class _$_FileState extends _FileState {
  const _$_FileState(
      {this.progress = 0.0,
      this.file,
      this.duration = Duration.zero,
      this.position = Duration.zero,
      this.isPlaying = false,
      this.controller})
      : super._();

  @JsonKey()
  @override
  final double progress;
  @override
  final File? file;
  @JsonKey()
  @override
  final Duration duration;
  @JsonKey()
  @override
  final Duration position;
  @JsonKey()
  @override
  final bool isPlaying;
  @override
  final VideoPlayerController? controller;

  @override
  String toString() {
    return 'FileState(progress: $progress, file: $file, duration: $duration, position: $position, isPlaying: $isPlaying, controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FileState &&
            const DeepCollectionEquality().equals(other.progress, progress) &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.duration, duration) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.isPlaying, isPlaying) &&
            const DeepCollectionEquality()
                .equals(other.controller, controller));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(progress),
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(duration),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(isPlaying),
      const DeepCollectionEquality().hash(controller));

  @JsonKey(ignore: true)
  @override
  _$FileStateCopyWith<_FileState> get copyWith =>
      __$FileStateCopyWithImpl<_FileState>(this, _$identity);
}

abstract class _FileState extends FileState {
  const factory _FileState(
      {double progress,
      File? file,
      Duration duration,
      Duration position,
      bool isPlaying,
      VideoPlayerController? controller}) = _$_FileState;
  const _FileState._() : super._();

  @override
  double get progress;
  @override
  File? get file;
  @override
  Duration get duration;
  @override
  Duration get position;
  @override
  bool get isPlaying;
  @override
  VideoPlayerController? get controller;
  @override
  @JsonKey(ignore: true)
  _$FileStateCopyWith<_FileState> get copyWith =>
      throw _privateConstructorUsedError;
}
