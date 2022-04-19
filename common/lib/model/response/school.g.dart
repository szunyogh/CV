// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_School _$$_SchoolFromJson(Map<String, dynamic> json) => _$_School(
      id: json['id'] as String? ?? "",
      beginning: const TimestampConverterNullable()
          .fromJson(json['beginning'] as Timestamp?),
      completion: const TimestampConverterNullable()
          .fromJson(json['completion'] as Timestamp?),
      department: json['department'] as String? ?? "",
      qualification: json['qualification'] as String? ?? "",
      schoolName: json['schoolName'] as String? ?? "",
    );

Map<String, dynamic> _$$_SchoolToJson(_$_School instance) => <String, dynamic>{
      'id': instance.id,
      'beginning':
          const TimestampConverterNullable().toJson(instance.beginning),
      'completion':
          const TimestampConverterNullable().toJson(instance.completion),
      'department': instance.department,
      'qualification': instance.qualification,
      'schoolName': instance.schoolName,
    };
