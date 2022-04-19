// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProfileStateTearOff {
  const _$ProfileStateTearOff();

  _ProfileState call(
      {Profile profile = const Profile(),
      List<MyAbilities> myAbilities = const [],
      List<Experience> experiences = const [],
      List<School> schools = const [],
      int yearsOfExperience = 0}) {
    return _ProfileState(
      profile: profile,
      myAbilities: myAbilities,
      experiences: experiences,
      schools: schools,
      yearsOfExperience: yearsOfExperience,
    );
  }
}

/// @nodoc
const $ProfileState = _$ProfileStateTearOff();

/// @nodoc
mixin _$ProfileState {
  Profile get profile => throw _privateConstructorUsedError;
  List<MyAbilities> get myAbilities => throw _privateConstructorUsedError;
  List<Experience> get experiences => throw _privateConstructorUsedError;
  List<School> get schools => throw _privateConstructorUsedError;
  int get yearsOfExperience => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res>;
  $Res call(
      {Profile profile,
      List<MyAbilities> myAbilities,
      List<Experience> experiences,
      List<School> schools,
      int yearsOfExperience});

  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res> implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  final ProfileState _value;
  // ignore: unused_field
  final $Res Function(ProfileState) _then;

  @override
  $Res call({
    Object? profile = freezed,
    Object? myAbilities = freezed,
    Object? experiences = freezed,
    Object? schools = freezed,
    Object? yearsOfExperience = freezed,
  }) {
    return _then(_value.copyWith(
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      myAbilities: myAbilities == freezed
          ? _value.myAbilities
          : myAbilities // ignore: cast_nullable_to_non_nullable
              as List<MyAbilities>,
      experiences: experiences == freezed
          ? _value.experiences
          : experiences // ignore: cast_nullable_to_non_nullable
              as List<Experience>,
      schools: schools == freezed
          ? _value.schools
          : schools // ignore: cast_nullable_to_non_nullable
              as List<School>,
      yearsOfExperience: yearsOfExperience == freezed
          ? _value.yearsOfExperience
          : yearsOfExperience // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc
abstract class _$ProfileStateCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(
          _ProfileState value, $Res Function(_ProfileState) then) =
      __$ProfileStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Profile profile,
      List<MyAbilities> myAbilities,
      List<Experience> experiences,
      List<School> schools,
      int yearsOfExperience});

  @override
  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$ProfileStateCopyWithImpl<$Res> extends _$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(
      _ProfileState _value, $Res Function(_ProfileState) _then)
      : super(_value, (v) => _then(v as _ProfileState));

  @override
  _ProfileState get _value => super._value as _ProfileState;

  @override
  $Res call({
    Object? profile = freezed,
    Object? myAbilities = freezed,
    Object? experiences = freezed,
    Object? schools = freezed,
    Object? yearsOfExperience = freezed,
  }) {
    return _then(_ProfileState(
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      myAbilities: myAbilities == freezed
          ? _value.myAbilities
          : myAbilities // ignore: cast_nullable_to_non_nullable
              as List<MyAbilities>,
      experiences: experiences == freezed
          ? _value.experiences
          : experiences // ignore: cast_nullable_to_non_nullable
              as List<Experience>,
      schools: schools == freezed
          ? _value.schools
          : schools // ignore: cast_nullable_to_non_nullable
              as List<School>,
      yearsOfExperience: yearsOfExperience == freezed
          ? _value.yearsOfExperience
          : yearsOfExperience // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ProfileState extends _ProfileState {
  const _$_ProfileState(
      {this.profile = const Profile(),
      this.myAbilities = const [],
      this.experiences = const [],
      this.schools = const [],
      this.yearsOfExperience = 0})
      : super._();

  @JsonKey()
  @override
  final Profile profile;
  @JsonKey()
  @override
  final List<MyAbilities> myAbilities;
  @JsonKey()
  @override
  final List<Experience> experiences;
  @JsonKey()
  @override
  final List<School> schools;
  @JsonKey()
  @override
  final int yearsOfExperience;

  @override
  String toString() {
    return 'ProfileState(profile: $profile, myAbilities: $myAbilities, experiences: $experiences, schools: $schools, yearsOfExperience: $yearsOfExperience)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProfileState &&
            const DeepCollectionEquality().equals(other.profile, profile) &&
            const DeepCollectionEquality()
                .equals(other.myAbilities, myAbilities) &&
            const DeepCollectionEquality()
                .equals(other.experiences, experiences) &&
            const DeepCollectionEquality().equals(other.schools, schools) &&
            const DeepCollectionEquality()
                .equals(other.yearsOfExperience, yearsOfExperience));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(profile),
      const DeepCollectionEquality().hash(myAbilities),
      const DeepCollectionEquality().hash(experiences),
      const DeepCollectionEquality().hash(schools),
      const DeepCollectionEquality().hash(yearsOfExperience));

  @JsonKey(ignore: true)
  @override
  _$ProfileStateCopyWith<_ProfileState> get copyWith =>
      __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);
}

abstract class _ProfileState extends ProfileState {
  const factory _ProfileState(
      {Profile profile,
      List<MyAbilities> myAbilities,
      List<Experience> experiences,
      List<School> schools,
      int yearsOfExperience}) = _$_ProfileState;
  const _ProfileState._() : super._();

  @override
  Profile get profile;
  @override
  List<MyAbilities> get myAbilities;
  @override
  List<Experience> get experiences;
  @override
  List<School> get schools;
  @override
  int get yearsOfExperience;
  @override
  @JsonKey(ignore: true)
  _$ProfileStateCopyWith<_ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}
