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

  _FileState call({double progress = 0.0}) {
    return _FileState(
      progress: progress,
    );
  }
}

/// @nodoc
const $FileState = _$FileStateTearOff();

/// @nodoc
mixin _$FileState {
  double get progress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FileStateCopyWith<FileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileStateCopyWith<$Res> {
  factory $FileStateCopyWith(FileState value, $Res Function(FileState) then) =
      _$FileStateCopyWithImpl<$Res>;
  $Res call({double progress});
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
  }) {
    return _then(_value.copyWith(
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$FileStateCopyWith<$Res> implements $FileStateCopyWith<$Res> {
  factory _$FileStateCopyWith(
          _FileState value, $Res Function(_FileState) then) =
      __$FileStateCopyWithImpl<$Res>;
  @override
  $Res call({double progress});
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
  }) {
    return _then(_FileState(
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_FileState extends _FileState {
  const _$_FileState({this.progress = 0.0}) : super._();

  @JsonKey()
  @override
  final double progress;

  @override
  String toString() {
    return 'FileState(progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FileState &&
            const DeepCollectionEquality().equals(other.progress, progress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(progress));

  @JsonKey(ignore: true)
  @override
  _$FileStateCopyWith<_FileState> get copyWith =>
      __$FileStateCopyWithImpl<_FileState>(this, _$identity);
}

abstract class _FileState extends FileState {
  const factory _FileState({double progress}) = _$_FileState;
  const _FileState._() : super._();

  @override
  double get progress;
  @override
  @JsonKey(ignore: true)
  _$FileStateCopyWith<_FileState> get copyWith =>
      throw _privateConstructorUsedError;
}
