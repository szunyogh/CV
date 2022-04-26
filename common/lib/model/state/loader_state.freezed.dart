// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'loader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoaderStateTearOff {
  const _$LoaderStateTearOff();

  _LoaderState call({bool hide = false, String message = ""}) {
    return _LoaderState(
      hide: hide,
      message: message,
    );
  }
}

/// @nodoc
const $LoaderState = _$LoaderStateTearOff();

/// @nodoc
mixin _$LoaderState {
  bool get hide => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoaderStateCopyWith<LoaderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoaderStateCopyWith<$Res> {
  factory $LoaderStateCopyWith(
          LoaderState value, $Res Function(LoaderState) then) =
      _$LoaderStateCopyWithImpl<$Res>;
  $Res call({bool hide, String message});
}

/// @nodoc
class _$LoaderStateCopyWithImpl<$Res> implements $LoaderStateCopyWith<$Res> {
  _$LoaderStateCopyWithImpl(this._value, this._then);

  final LoaderState _value;
  // ignore: unused_field
  final $Res Function(LoaderState) _then;

  @override
  $Res call({
    Object? hide = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      hide: hide == freezed
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LoaderStateCopyWith<$Res>
    implements $LoaderStateCopyWith<$Res> {
  factory _$LoaderStateCopyWith(
          _LoaderState value, $Res Function(_LoaderState) then) =
      __$LoaderStateCopyWithImpl<$Res>;
  @override
  $Res call({bool hide, String message});
}

/// @nodoc
class __$LoaderStateCopyWithImpl<$Res> extends _$LoaderStateCopyWithImpl<$Res>
    implements _$LoaderStateCopyWith<$Res> {
  __$LoaderStateCopyWithImpl(
      _LoaderState _value, $Res Function(_LoaderState) _then)
      : super(_value, (v) => _then(v as _LoaderState));

  @override
  _LoaderState get _value => super._value as _LoaderState;

  @override
  $Res call({
    Object? hide = freezed,
    Object? message = freezed,
  }) {
    return _then(_LoaderState(
      hide: hide == freezed
          ? _value.hide
          : hide // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoaderState extends _LoaderState {
  const _$_LoaderState({this.hide = false, this.message = ""}) : super._();

  @JsonKey()
  @override
  final bool hide;
  @JsonKey()
  @override
  final String message;

  @override
  String toString() {
    return 'LoaderState(hide: $hide, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoaderState &&
            const DeepCollectionEquality().equals(other.hide, hide) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(hide),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$LoaderStateCopyWith<_LoaderState> get copyWith =>
      __$LoaderStateCopyWithImpl<_LoaderState>(this, _$identity);
}

abstract class _LoaderState extends LoaderState {
  const factory _LoaderState({bool hide, String message}) = _$_LoaderState;
  const _LoaderState._() : super._();

  @override
  bool get hide;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$LoaderStateCopyWith<_LoaderState> get copyWith =>
      throw _privateConstructorUsedError;
}
