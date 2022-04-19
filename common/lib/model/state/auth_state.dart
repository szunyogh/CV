import 'package:common/model/response/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const AuthenticationState._();
  const factory AuthenticationState({
    @Default(User()) User dto,
  }) = _AuthenticationState;

  User get currentUser => dto;

  String get userId => dto.id;

  String get name => dto.name;

  String get email => dto.email;

  bool get isAuthenticated => dto.id != "";
}
