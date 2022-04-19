// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Experience _$$_ExperienceFromJson(Map<String, dynamic> json) =>
    _$_Experience(
      name: json['name'] as String? ?? "",
      beginning: const TimestampConverterNullable()
          .fromJson(json['beginning'] as Timestamp?),
      completion: const TimestampConverterNullable()
          .fromJson(json['completion'] as Timestamp?),
      description: json['description'] as String? ?? "",
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_ExperienceToJson(_$_Experience instance) =>
    <String, dynamic>{
      'name': instance.name,
      'beginning':
          const TimestampConverterNullable().toJson(instance.beginning),
      'completion':
          const TimestampConverterNullable().toJson(instance.completion),
      'description': instance.description,
      'keywords': instance.keywords,
    };
