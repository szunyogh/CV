// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'image_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ImageStateTearOff {
  const _$ImageStateTearOff();

  _ImageState call({double progress = 0.0}) {
    return _ImageState(
      progress: progress,
    );
  }
}

/// @nodoc
const $ImageState = _$ImageStateTearOff();

/// @nodoc
mixin _$ImageState {
  double get progress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageStateCopyWith<ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageStateCopyWith<$Res> {
  factory $ImageStateCopyWith(
          ImageState value, $Res Function(ImageState) then) =
      _$ImageStateCopyWithImpl<$Res>;
  $Res call({double progress});
}

/// @nodoc
class _$ImageStateCopyWithImpl<$Res> implements $ImageStateCopyWith<$Res> {
  _$ImageStateCopyWithImpl(this._value, this._then);

  final ImageState _value;
  // ignore: unused_field
  final $Res Function(ImageState) _then;

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
abstract class _$ImageStateCopyWith<$Res> implements $ImageStateCopyWith<$Res> {
  factory _$ImageStateCopyWith(
          _ImageState value, $Res Function(_ImageState) then) =
      __$ImageStateCopyWithImpl<$Res>;
  @override
  $Res call({double progress});
}

/// @nodoc
class __$ImageStateCopyWithImpl<$Res> extends _$ImageStateCopyWithImpl<$Res>
    implements _$ImageStateCopyWith<$Res> {
  __$ImageStateCopyWithImpl(
      _ImageState _value, $Res Function(_ImageState) _then)
      : super(_value, (v) => _then(v as _ImageState));

  @override
  _ImageState get _value => super._value as _ImageState;

  @override
  $Res call({
    Object? progress = freezed,
  }) {
    return _then(_ImageState(
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_ImageState extends _ImageState {
  const _$_ImageState({this.progress = 0.0}) : super._();

  @JsonKey()
  @override
  final double progress;

  @override
  String toString() {
    return 'ImageState(progress: $progress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageState &&
            const DeepCollectionEquality().equals(other.progress, progress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(progress));

  @JsonKey(ignore: true)
  @override
  _$ImageStateCopyWith<_ImageState> get copyWith =>
      __$ImageStateCopyWithImpl<_ImageState>(this, _$identity);
}

abstract class _ImageState extends ImageState {
  const factory _ImageState({double progress}) = _$_ImageState;
  const _ImageState._() : super._();

  @override
  double get progress;
  @override
  @JsonKey(ignore: true)
  _$ImageStateCopyWith<_ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}
