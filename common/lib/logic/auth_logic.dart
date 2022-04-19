import 'package:common/logic/base.dart';
import 'package:common/model/response/user.dart' as user;
import 'package:common/model/state/auth_state.dart';
import 'package:common/repository/auth_repository.dart';
import 'package:common/repository/interface/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final user = ref.watch(firebaseAuthProvider).authStateChanges();
  return user;
});

final authenticationLogic =
    StateNotifierProvider<AuthenticationLogic, AuthenticationState>((ref) => AuthenticationLogic(ref.read));

class AuthenticationLogic extends BaseLogic<AuthenticationState> {
  AuthenticationLogic(Reader read) : super(read, const AuthenticationState());

  IAuthRepository get repo => read(authenticationRepo);

  @override
  Future<void> initialize() async {
    await getUser();
  }

  Future<void> getUser() async {
    final user = await repo.getUser();
    state = state.copyWith(dto: user);
  }

  Future<void> login() async {
    final user = await repo.signInWithGoogle();
    state = state.copyWith(dto: user);
  }

  Future<void> logout() async {
    await repo.signOut();
    state = state.copyWith(dto: const user.User());
  }
}
