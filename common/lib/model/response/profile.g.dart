// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      name: json['name'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      id: json['id'] as String? ?? "",
      profile: json['profile'] as String? ?? "",
      email: json['email'] as String? ?? "",
      facebook: json['facebook'] as String? ?? "",
      birthday: const TimestampConverterNullable()
          .fromJson(json['birthday'] as Timestamp?),
      aboutMe: json['aboutMe'] as String? ?? "",
      docId: json['docId'] as String? ?? "",
      fcmToken: json['fcmToken'] as String? ?? "",
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'id': instance.id,
      'profile': instance.profile,
      'email': instance.email,
      'facebook': instance.facebook,
      'birthday': const TimestampConverterNullable().toJson(instance.birthday),
      'aboutMe': instance.aboutMe,
      'docId': instance.docId,
      'fcmToken': instance.fcmToken,
    };
