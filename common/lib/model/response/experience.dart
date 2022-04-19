import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

class TimestampConverterNullable implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverterNullable();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();

  @override
  Timestamp? toJson(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
}

@freezed
class Experience with _$Experience {
  const factory Experience({
    @Default("") String name,
    @TimestampConverterNullable() DateTime? beginning,
    @TimestampConverterNullable() DateTime? completion,
    @Default("") String description,
    @Default([]) List<String> keywords,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
}
