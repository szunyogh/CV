import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

class TimestampConverterNullable implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverterNullable();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();

  @override
  Timestamp? toJson(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
}

@freezed
class Chat with _$Chat {
  const Chat._();
  const factory Chat({
    @Default("") String id,
    @TimestampConverterNullable() DateTime? dateSent,
    @Default(false) bool isSee,
    @Default(false) bool isUpload,
    @Default("") String message,
    @Default({"url": "", "type": ""}) Map<String, String> file,
    @Default("") String sender,
    @Default("") String like,
  }) = _Chat;

  bool get isPicture => (file['type'] as String) == 'image';

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
