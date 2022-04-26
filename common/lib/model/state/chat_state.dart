import 'package:common/model/response/chat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const ChatState._();
  const factory ChatState({
    @Default([]) List<Chat> chats,
    @Default(false) bool isTyping,
    @Default(0) int badgeCount,
  }) = _ChatState;
}
