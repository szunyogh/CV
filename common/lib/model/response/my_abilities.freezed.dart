// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_abilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyAbilities _$MyAbilitiesFromJson(Map<String, dynamic> json) {
  return _MyAbilities.fromJson(json);
}

/// @nodoc
class _$MyAbilitiesTearOff {
  const _$MyAbilitiesTearOff();

  _MyAbilities call(
      {String name = "",
      @JsonKey(name: 'strength ', defaultValue: 0) int? strength}) {
    return _MyAbilities(
      name: name,
      strength: strength,
    );
  }

  MyAbilities fromJson(Map<String, Object?> json) {
    return MyAbilities.fromJson(json);
  }
}

/// @nodoc
const $MyAbilities = _$MyAbilitiesTearOff();

/// @nodoc
mixin _$MyAbilities {
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'strength ', defaultValue: 0)
  int? get strength => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyAbilitiesCopyWith<MyAbilities> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyAbilitiesCopyWith<$Res> {
  factory $MyAbilitiesCopyWith(
          MyAbilities value, $Res Function(MyAbilities) then) =
      _$MyAbilitiesCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @JsonKey(name: 'strength ', defaultValue: 0) int? strength});
}

/// @nodoc
class _$MyAbilitiesCopyWithImpl<$Res> implements $MyAbilitiesCopyWith<$Res> {
  _$MyAbilitiesCopyWithImpl(this._value, this._then);

  final MyAbilities _value;
  // ignore: unused_field
  final $Res Function(MyAbilities) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? strength = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strength: strength == freezed
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$MyAbilitiesCopyWith<$Res>
    implements $MyAbilitiesCopyWith<$Res> {
  factory _$MyAbilitiesCopyWith(
          _MyAbilities value, $Res Function(_MyAbilities) then) =
      __$MyAbilitiesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @JsonKey(name: 'strength ', defaultValue: 0) int? strength});
}

/// @nodoc
class __$MyAbilitiesCopyWithImpl<$Res> extends _$MyAbilitiesCopyWithImpl<$Res>
    implements _$MyAbilitiesCopyWith<$Res> {
  __$MyAbilitiesCopyWithImpl(
      _MyAbilities _value, $Res Function(_MyAbilities) _then)
      : super(_value, (v) => _then(v as _MyAbilities));

  @override
  _MyAbilities get _value => super._value as _MyAbilities;

  @override
  $Res call({
    Object? name = freezed,
    Object? strength = freezed,
  }) {
    return _then(_MyAbilities(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strength: strength == freezed
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyAbilities implements _MyAbilities {
  const _$_MyAbilities(
      {this.name = "",
      @JsonKey(name: 'strength ', defaultValue: 0) this.strength});

  factory _$_MyAbilities.fromJson(Map<String, dynamic> json) =>
      _$$_MyAbilitiesFromJson(json);

  @JsonKey()
  @override
  final String name;
  @override
  @JsonKey(name: 'strength ', defaultValue: 0)
  final int? strength;

  @override
  String toString() {
    return 'MyAbilities(name: $name, strength: $strength)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyAbilities &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.strength, strength));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(strength));

  @JsonKey(ignore: true)
  @override
  _$MyAbilitiesCopyWith<_MyAbilities> get copyWith =>
      __$MyAbilitiesCopyWithImpl<_MyAbilities>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyAbilitiesToJson(this);
  }
}

abstract class _MyAbilities implements MyAbilities {
  const factory _MyAbilities(
          {String name,
          @JsonKey(name: 'strength ', defaultValue: 0) int? strength}) =
      _$_MyAbilities;

  factory _MyAbilities.fromJson(Map<String, dynamic> json) =
      _$_MyAbilities.fromJson;

  @override
  String get name;
  @override
  @JsonKey(name: 'strength ', defaultValue: 0)
  int? get strength;
  @override
  @JsonKey(ignore: true)
  _$MyAbilitiesCopyWith<_MyAbilities> get copyWith =>
      throw _privateConstructorUsedError;
}
