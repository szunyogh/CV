// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'experience.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Experience _$ExperienceFromJson(Map<String, dynamic> json) {
  return _Experience.fromJson(json);
}

/// @nodoc
class _$ExperienceTearOff {
  const _$ExperienceTearOff();

  _Experience call(
      {String name = "",
      @TimestampConverterNullable() DateTime? beginning,
      @TimestampConverterNullable() DateTime? completion,
      String description = "",
      List<String> keywords = const []}) {
    return _Experience(
      name: name,
      beginning: beginning,
      completion: completion,
      description: description,
      keywords: keywords,
    );
  }

  Experience fromJson(Map<String, Object?> json) {
    return Experience.fromJson(json);
  }
}

/// @nodoc
const $Experience = _$ExperienceTearOff();

/// @nodoc
mixin _$Experience {
  String get name => throw _privateConstructorUsedError;
  @TimestampConverterNullable()
  DateTime? get beginning => throw _privateConstructorUsedError;
  @TimestampConverterNullable()
  DateTime? get completion => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExperienceCopyWith<Experience> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceCopyWith<$Res> {
  factory $ExperienceCopyWith(
          Experience value, $Res Function(Experience) then) =
      _$ExperienceCopyWithImpl<$Res>;
  $Res call(
      {String name,
      @TimestampConverterNullable() DateTime? beginning,
      @TimestampConverterNullable() DateTime? completion,
      String description,
      List<String> keywords});
}

/// @nodoc
class _$ExperienceCopyWithImpl<$Res> implements $ExperienceCopyWith<$Res> {
  _$ExperienceCopyWithImpl(this._value, this._then);

  final Experience _value;
  // ignore: unused_field
  final $Res Function(Experience) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? beginning = freezed,
    Object? completion = freezed,
    Object? description = freezed,
    Object? keywords = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      beginning: beginning == freezed
          ? _value.beginning
          : beginning // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completion: completion == freezed
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$ExperienceCopyWith<$Res> implements $ExperienceCopyWith<$Res> {
  factory _$ExperienceCopyWith(
          _Experience value, $Res Function(_Experience) then) =
      __$ExperienceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      @TimestampConverterNullable() DateTime? beginning,
      @TimestampConverterNullable() DateTime? completion,
      String description,
      List<String> keywords});
}

/// @nodoc
class __$ExperienceCopyWithImpl<$Res> extends _$ExperienceCopyWithImpl<$Res>
    implements _$ExperienceCopyWith<$Res> {
  __$ExperienceCopyWithImpl(
      _Experience _value, $Res Function(_Experience) _then)
      : super(_value, (v) => _then(v as _Experience));

  @override
  _Experience get _value => super._value as _Experience;

  @override
  $Res call({
    Object? name = freezed,
    Object? beginning = freezed,
    Object? completion = freezed,
    Object? description = freezed,
    Object? keywords = freezed,
  }) {
    return _then(_Experience(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      beginning: beginning == freezed
          ? _value.beginning
          : beginning // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completion: completion == freezed
          ? _value.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      keywords: keywords == freezed
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Experience implements _Experience {
  const _$_Experience(
      {this.name = "",
      @TimestampConverterNullable() this.beginning,
      @TimestampConverterNullable() this.completion,
      this.description = "",
      this.keywords = const []});

  factory _$_Experience.fromJson(Map<String, dynamic> json) =>
      _$$_ExperienceFromJson(json);

  @JsonKey()
  @override
  final String name;
  @override
  @TimestampConverterNullable()
  final DateTime? beginning;
  @override
  @TimestampConverterNullable()
  final DateTime? completion;
  @JsonKey()
  @override
  final String description;
  @JsonKey()
  @override
  final List<String> keywords;

  @override
  String toString() {
    return 'Experience(name: $name, beginning: $beginning, completion: $completion, description: $description, keywords: $keywords)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Experience &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.beginning, beginning) &&
            const DeepCollectionEquality()
                .equals(other.completion, completion) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.keywords, keywords));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(beginning),
      const DeepCollectionEquality().hash(completion),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(keywords));

  @JsonKey(ignore: true)
  @override
  _$ExperienceCopyWith<_Experience> get copyWith =>
      __$ExperienceCopyWithImpl<_Experience>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExperienceToJson(this);
  }
}

abstract class _Experience implements Experience {
  const factory _Experience(
      {String name,
      @TimestampConverterNullable() DateTime? beginning,
      @TimestampConverterNullable() DateTime? completion,
      String description,
      List<String> keywords}) = _$_Experience;

  factory _Experience.fromJson(Map<String, dynamic> json) =
      _$_Experience.fromJson;

  @override
  String get name;
  @override
  @TimestampConverterNullable()
  DateTime? get beginning;
  @override
  @TimestampConverterNullable()
  DateTime? get completion;
  @override
  String get description;
  @override
  List<String> get keywords;
  @override
  @JsonKey(ignore: true)
  _$ExperienceCopyWith<_Experience> get copyWith =>
      throw _privateConstructorUsedError;
}
