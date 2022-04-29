import 'dart:io';
import 'package:common/logic/auth_logic.dart';
import 'package:common/logic/base.dart';
import 'package:common/logic/chat_logic.dart';
import 'package:common/model/response/chat.dart';
import 'package:common/model/response/user.dart';
import 'package:common/model/state/file_state.dart';
import 'package:common/repository/file_repository.dart';
import 'package:common/repository/interface/file_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fileLogic = StateNotifierProvider.family<FileLogic, FileState, String>((ref, id) => FileLogic(ref.read, id));

class FileLogic extends BaseLogic<FileState> {
  final String id;
  FileLogic(Reader read, this.id) : super(read, const FileState());

  IFileRepository get repo => read(fileRepo);

  User get user => read(authenticationLogic).currentUser;

  @override
  Future<void> initialize() async {}

  Future<void> uploadFile(String name, File file, String type) async {
    repo.uploadFile(user.id, name, file).listen((event) async {
      state = state.copyWith(progress: (event.bytesTransferred / event.totalBytes));
      if (event.state == TaskState.success) {
        final url = await downloadFile(name, file);
        sendFile(type, url);
      } else if (event.state == TaskState.error) {
        removeFile();
      }
    });
  }

  Future<String> downloadFile(String name, File file) async {
    return repo.downloadFile(user.id, name, file);
  }

  Future<void> getFile(String type, String name, String? base64, File file) async {
    if (base64 == null) return;
    final request = Chat(id: id, dateSent: DateTime.now(), file: {"url": base64, "type": type}, sender: user.id);
    await repo.getFile(request.toJson(), user.id);
    uploadFile(name, file, type);
  }

  Future<void> sendFile(String type, String url) async {
    await repo.sendFile(user.id, id, url, type);
    read(chatLogic.notifier).sendPushNoti("${user.name} képet küldött önnek");
  }

  Future<void> removeFile() async {
    await repo.removeFile(user.id, id);
  }
}
