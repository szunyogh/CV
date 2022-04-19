import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default("") String id,
    @Default("") String name,
    @Default("") String email,
    @Default("") String profilePic,
    @Default(0) int notificationId,
    @Default("") String fcmToken,
    @Default({"user_1": false, "user_2": false}) Map<String, bool> typingStatus,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
