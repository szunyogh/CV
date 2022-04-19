// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as String? ?? "",
      name: json['name'] as String? ?? "",
      email: json['email'] as String? ?? "",
      profilePic: json['profilePic'] as String? ?? "",
      notificationId: json['notificationId'] as int? ?? 0,
      fcmToken: json['fcmToken'] as String? ?? "",
      typingStatus: (json['typingStatus'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {"user_1": false, "user_2": false},
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profilePic': instance.profilePic,
      'notificationId': instance.notificationId,
      'fcmToken': instance.fcmToken,
      'typingStatus': instance.typingStatus,
    };
