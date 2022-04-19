// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
class _$ChatTearOff {
  const _$ChatTearOff();

  _Chat call(
      {String id = "",
      @TimestampConverterNullable() DateTime? dateSent,
      bool isSee = false,
      bool isUpload = false,
      String message = "",
      String picture = "",
      String sender = ""}) {
    return _Chat(
      id: id,
      dateSent: dateSent,
      isSee: isSee,
      isUpload: isUpload,
      message: message,
      picture: picture,
      sender: sender,
    );
  }

  Chat fromJson(Map<String, Object?> json) {
    return Chat.fromJson(json);
  }
}

/// @nodoc
const $Chat = _$ChatTearOff();

/// @nodoc
mixin _$Chat {
  String get id => throw _privateConstructorUsedError;
  @TimestampConverterNullable()
  DateTime? get dateSent => throw _privateConstructorUsedError;
  bool get isSee => throw _privateConstructorUsedError;
  bool get isUpload => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get picture => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @TimestampConverterNullable() DateTime? dateSent,
      bool isSee,
      bool isUpload,
      String message,
      String picture,
      String sender});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? dateSent = freezed,
    Object? isSee = freezed,
    Object? isUpload = freezed,
    Object? message = freezed,
    Object? picture = freezed,
    Object? sender = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dateSent: dateSent == freezed
          ? _value.dateSent
          : dateSent // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSee: isSee == freezed
          ? _value.isSee
          : isSee // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpload: isUpload == freezed
          ? _value.isUpload
          : isUpload // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      picture: picture == freezed
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) then) =
      __$ChatCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @TimestampConverterNullable() DateTime? dateSent,
      bool isSee,
      bool isUpload,
      String message,
      String picture,
      String sender});
}

/// @nodoc
class __$ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$ChatCopyWith<$Res> {
  __$ChatCopyWithImpl(_Chat _value, $Res Function(_Chat) _then)
      : super(_value, (v) => _then(v as _Chat));

  @override
  _Chat get _value => super._value as _Chat;

  @override
  $Res call({
    Object? id = freezed,
    Object? dateSent = freezed,
    Object? isSee = freezed,
    Object? isUpload = freezed,
    Object? message = freezed,
    Object? picture = freezed,
    Object? sender = freezed,
  }) {
    return _then(_Chat(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dateSent: dateSent == freezed
          ? _value.dateSent
          : dateSent // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isSee: isSee == freezed
          ? _value.isSee
          : isSee // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpload: isUpload == freezed
          ? _value.isUpload
          : isUpload // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      picture: picture == freezed
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      sender: sender == freezed
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Chat extends _Chat {
  const _$_Chat(
      {this.id = "",
      @TimestampConverterNullable() this.dateSent,
      this.isSee = false,
      this.isUpload = false,
      this.message = "",
      this.picture = "",
      this.sender = ""})
      : super._();

  factory _$_Chat.fromJson(Map<String, dynamic> json) => _$$_ChatFromJson(json);

  @JsonKey()
  @override
  final String id;
  @override
  @TimestampConverterNullable()
  final DateTime? dateSent;
  @JsonKey()
  @override
  final bool isSee;
  @JsonKey()
  @override
  final bool isUpload;
  @JsonKey()
  @override
  final String message;
  @JsonKey()
  @override
  final String picture;
  @JsonKey()
  @override
  final String sender;

  @override
  String toString() {
    return 'Chat(id: $id, dateSent: $dateSent, isSee: $isSee, isUpload: $isUpload, message: $message, picture: $picture, sender: $sender)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Chat &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.dateSent, dateSent) &&
            const DeepCollectionEquality().equals(other.isSee, isSee) &&
            const DeepCollectionEquality().equals(other.isUpload, isUpload) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.picture, picture) &&
            const DeepCollectionEquality().equals(other.sender, sender));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(dateSent),
      const DeepCollectionEquality().hash(isSee),
      const DeepCollectionEquality().hash(isUpload),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(picture),
      const DeepCollectionEquality().hash(sender));

  @JsonKey(ignore: true)
  @override
  _$ChatCopyWith<_Chat> get copyWith =>
      __$ChatCopyWithImpl<_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatToJson(this);
  }
}

abstract class _Chat extends Chat {
  const factory _Chat(
      {String id,
      @TimestampConverterNullable() DateTime? dateSent,
      bool isSee,
      bool isUpload,
      String message,
      String picture,
      String sender}) = _$_Chat;
  const _Chat._() : super._();

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

  @override
  String get id;
  @override
  @TimestampConverterNullable()
  DateTime? get dateSent;
  @override
  bool get isSee;
  @override
  bool get isUpload;
  @override
  String get message;
  @override
  String get picture;
  @override
  String get sender;
  @override
  @JsonKey(ignore: true)
  _$ChatCopyWith<_Chat> get copyWith => throw _privateConstructorUsedError;
}
