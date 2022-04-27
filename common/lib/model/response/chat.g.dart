// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$$_ChatFromJson(Map<String, dynamic> json) => _$_Chat(
      id: json['id'] as String? ?? "",
      dateSent: const TimestampConverterNullable()
          .fromJson(json['dateSent'] as Timestamp?),
      isSee: json['isSee'] as bool? ?? false,
      isUpload: json['isUpload'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      picture: json['picture'] as String? ?? "",
      sender: json['sender'] as String? ?? "",
      like: json['like'] as String? ?? "",
    );

Map<String, dynamic> _$$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'id': instance.id,
      'dateSent': const TimestampConverterNullable().toJson(instance.dateSent),
      'isSee': instance.isSee,
      'isUpload': instance.isUpload,
      'message': instance.message,
      'picture': instance.picture,
      'sender': instance.sender,
      'like': instance.like,
    };
