import 'package:common/model/response/experience.dart';
import 'package:common/model/response/my_abilities.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/model/response/school.dart';

abstract class IProfileRepository {
  Future<Profile> getProfile();

  Future<List<Experience>> getExperiences(String id);

  Future<List<School>> getSchools(String id);

  Future<List<MyAbilities>> getMyAbilities(String id);
}
