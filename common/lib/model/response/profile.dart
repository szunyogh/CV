import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

class TimestampConverterNullable implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverterNullable();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();

  @override
  Timestamp? toJson(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    @Default("") String name,
    @Default("") String phone,
    @Default("") String id,
    @Default("") String profile,
    @Default("") String email,
    @Default("") String facebook,
    @TimestampConverterNullable() DateTime? birthday,
    @Default("") String aboutMe,
    @Default("") String docId,
    @Default("") String fcmToken,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
