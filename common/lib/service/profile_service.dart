import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/model/response/experience.dart';
import 'package:common/model/response/my_abilities.dart';
import 'package:common/model/response/profile.dart';
import 'package:common/model/response/school.dart';

class ProfileService {
  Future<Profile> getProfile() async {
    return FirebaseFirestore.instance.collection('me').get().then((value) async {
      final jsonResponse = value.docs.first.data();
      final json = await FirebaseFirestore.instance.collection('users').doc(jsonResponse["uid"]).get();
      jsonResponse.addAll({"fcmToken": json["fcmToken"]});
      return Profile.fromJson(jsonResponse);
    });
  }

  Future<List<Experience>> getExperiences(String id) async {
    return await FirebaseFirestore.instance
        .collection('me')
        .doc(id)
        .collection('professional_experience')
        .orderBy('beginning')
        .get()
        .then((value) => value.docs.map((e) => Experience.fromJson(e.data())).toList());
  }

  Future<List<School>> getSchools(String id) async {
    return await FirebaseFirestore.instance
        .collection('me')
        .doc(id)
        .collection('schools')
        .orderBy('beginning')
        .get()
        .then((value) => value.docs.map((e) => School.fromJson(e.data())).toList());
  }

  Future<List<MyAbilities>> getMyAbilities(String id) async {
    return await FirebaseFirestore.instance
        .collection('me')
        .doc(id)
        .collection('my_abilities ')
        .get()
        .then((value) => value.docs.map((e) => MyAbilities.fromJson(e.data())).toList());
  }
}
