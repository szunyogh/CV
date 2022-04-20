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

  _ImageState call(
      {Image image = const Image(progress: 0.0), String imageId = ""}) {
    return _ImageState(
      image: image,
      imageId: imageId,
    );
  }
}

/// @nodoc
const $ImageState = _$ImageStateTearOff();

/// @nodoc
mixin _$ImageState {
  Image get image => throw _privateConstructorUsedError;
  String get imageId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageStateCopyWith<ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageStateCopyWith<$Res> {
  factory $ImageStateCopyWith(
          ImageState value, $Res Function(ImageState) then) =
      _$ImageStateCopyWithImpl<$Res>;
  $Res call({Image image, String imageId});

  $ImageCopyWith<$Res> get image;
}

/// @nodoc
class _$ImageStateCopyWithImpl<$Res> implements $ImageStateCopyWith<$Res> {
  _$ImageStateCopyWithImpl(this._value, this._then);

  final ImageState _value;
  // ignore: unused_field
  final $Res Function(ImageState) _then;

  @override
  $Res call({
    Object? image = freezed,
    Object? imageId = freezed,
  }) {
    return _then(_value.copyWith(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Image,
      imageId: imageId == freezed
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $ImageCopyWith<$Res> get image {
    return $ImageCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value));
    });
  }
}

/// @nodoc
abstract class _$ImageStateCopyWith<$Res> implements $ImageStateCopyWith<$Res> {
  factory _$ImageStateCopyWith(
          _ImageState value, $Res Function(_ImageState) then) =
      __$ImageStateCopyWithImpl<$Res>;
  @override
  $Res call({Image image, String imageId});

  @override
  $ImageCopyWith<$Res> get image;
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
    Object? image = freezed,
    Object? imageId = freezed,
  }) {
    return _then(_ImageState(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as Image,
      imageId: imageId == freezed
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ImageState extends _ImageState {
  const _$_ImageState(
      {this.image = const Image(progress: 0.0), this.imageId = ""})
      : super._();

  @JsonKey()
  @override
  final Image image;
  @JsonKey()
  @override
  final String imageId;

  @override
  String toString() {
    return 'ImageState(image: $image, imageId: $imageId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImageState &&
            const DeepCollectionEquality().equals(other.image, image) &&
            const DeepCollectionEquality().equals(other.imageId, imageId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(image),
      const DeepCollectionEquality().hash(imageId));

  @JsonKey(ignore: true)
  @override
  _$ImageStateCopyWith<_ImageState> get copyWith =>
      __$ImageStateCopyWithImpl<_ImageState>(this, _$identity);
}

abstract class _ImageState extends ImageState {
  const factory _ImageState({Image image, String imageId}) = _$_ImageState;
  const _ImageState._() : super._();

  @override
  Image get image;
  @override
  String get imageId;
  @override
  @JsonKey(ignore: true)
  _$ImageStateCopyWith<_ImageState> get copyWith =>
      throw _privateConstructorUsedError;
}
