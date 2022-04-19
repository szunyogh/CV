import 'package:common/model/response/user.dart';

abstract class IAuthRepository {
  Future<User> signInWithGoogle();

  Future<User> getUser();

  Future<void> signOut();
}
