import 'package:common/logic/base.dart';
import 'package:common/model/state/profile_state.dart';
import 'package:common/repository/interface/profile_interface.dart';
import 'package:common/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final profileLogic = StateNotifierProvider<ProfileLogic, ProfileState>((ref) => ProfileLogic(ref.read));

class ProfileLogic extends BaseLogic<ProfileState> {
  ProfileLogic(Reader read) : super(read, const ProfileState());

  IProfileRepository get repo => read(profileRepo);

  @override
  Future<void> initialize() async {
    await getProfile();
    await getExperiences();
    await getMyAbilities();
    await getSchools();
  }

  Future<void> getProfile() async {
    final profile = await repo.getProfile();
    state = state.copyWith(profile: profile);
  }

  Future<void> getExperiences() async {
    Duration duration = const Duration();
    final exp = await repo.getExperiences(state.profileId);
    final experiences = exp.sortedBy((element) => element.beginning!);
    for (var item in experiences) {
      if (item.completion != null) {
        duration += item.completion!.difference(item.beginning!);
      }
    }
    state = state.copyWith(experiences: exp, yearsOfExperience: duration.inDays);
  }

  Future<void> getMyAbilities() async {
    final myAbilities = await repo.getMyAbilities(state.profileId);
    state = state.copyWith(myAbilities: myAbilities);
  }

  Future<void> getSchools() async {
    final schools = await repo.getSchools(state.profileId);
    state = state.copyWith(schools: schools);
  }
}
