import 'package:common/model/response/school.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/model/response/my_abilities.dart';
import 'package:common/model/response/experience.dart';
import 'package:common/repository/interface/profile_interface.dart';
import 'package:common/service/profile_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

final profileRepo = Provider<IProfileRepository>((ref) => ProfileRepository());

class ProfileRepository implements IProfileRepository {
  ProfileRepository();

  ProfileService get service => ProfileService();

  @override
  Future<List<Experience>> getExperiences(String id) async {
    try {
      return await service.getExperiences(id);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Future<List<MyAbilities>> getMyAbilities(String id) async {
    try {
      return await service.getMyAbilities(id);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Future<Profile> getProfile() async {
    try {
      return await service.getProfile();
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }

  @override
  Future<List<School>> getSchools(String id) async {
    try {
      return await service.getSchools(id);
    } on firebase.FirebaseException catch (err) {
      throw Exception(err.code);
    } catch (error) {
      throw Exception('');
    }
  }
}
