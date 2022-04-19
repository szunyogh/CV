import 'package:common/model/response/experience.dart';
import 'package:common/model/response/my_abilities.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/model/response/school.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const ProfileState._();
  const factory ProfileState({
    @Default(Profile()) Profile profile,
    @Default([]) List<MyAbilities> myAbilities,
    @Default([]) List<Experience> experiences,
    @Default([]) List<School> schools,
    @Default(0) int yearsOfExperience,
  }) = _ProfileState;

  String get profileId => profile.id;
}
