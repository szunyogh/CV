import 'package:common/model/response/school.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/model/response/my_abilities.dart';
import 'package:common/model/response/experience.dart';
import 'package:common/repository/interface/profile_interface.dart';
import 'package:common/service/profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepo = Provider<IProfileRepository>((ref) => ProfileRepository());

class ProfileRepository implements IProfileRepository {
  ProfileRepository();

  ProfileService get service => ProfileService();

  @override
  Future<List<Experience>> getExperiences(String id) async {
    try {
      return await service.getExperiences(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<List<MyAbilities>> getMyAbilities(String id) async {
    try {
      return await service.getMyAbilities(id);
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<Profile> getProfile() async {
    try {
      return await service.getProfile();
    } catch (err) {
      throw Exception();
    }
  }

  @override
  Future<List<School>> getSchools(String id) async {
    try {
      return await service.getSchools(id);
    } catch (err) {
      throw Exception();
    }
  }
}
