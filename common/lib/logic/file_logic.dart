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
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

final fileLogic =
    StateNotifierProvider.family.autoDispose<FileLogic, FileState, String>((ref, id) => FileLogic(ref.read, id));

class FileLogic extends BaseLogic<FileState> {
  final String id;
  FileLogic(Reader read, this.id) : super(read, const FileState());

  IFileRepository get repo => read(fileRepo);

  User get user => read(authenticationLogic).currentUser;

  VideoPlayerController? controller;

  @override
  Future<void> initialize({String url = ""}) async {
    try {
      final cachedFile = await DefaultCacheManager().getSingleFile(url);
      state = state.copyWith(file: cachedFile);
    } catch (e) {}
  }

  void videoInitalize() {
    if (state.file == null) return;
    controller = VideoPlayerController.file(state.file!)..initialize();
    state = state.copyWith(controller: controller);
    controller?.addListener(() {
      if (controller?.value.position == controller?.value.duration) {
        controller?.seekTo(const Duration(seconds: 0));
      }
      state = state.copyWith(
        duration: controller?.value.duration ?? Duration.zero,
        position: controller?.value.position ?? Duration.zero,
        isPlaying: controller?.value.isPlaying ?? false,
      );
    });
  }

  @override
  void dispose() {
    controller?.removeListener(() {});
    controller?.dispose();
    state = state.copyWith(
      controller: null,
      isPlaying: false,
      duration: Duration.zero,
      position: Duration.zero,
    );
    controller = null;
    super.dispose();
  }

  Future<void> uploadFile(String name, File file, String type) async {
    File? _file;
    if (type == "video") {
      try {
        await VideoCompress.setLogLevel(0);
        final mediaInfo = await VideoCompress.compressVideo(file.path, quality: VideoQuality.MediumQuality);
        _file = mediaInfo?.file;
      } catch (e) {
        VideoCompress.cancelCompression();
      }
    } else {
      _file = file;
    }
    if (_file != null) {
      repo.uploadFile(user.id, name, _file).listen((event) async {
        state = state.copyWith(progress: (event.bytesTransferred / event.totalBytes));
        if (event.state == TaskState.success) {
          final url = await downloadFile(name, file);
          final cachedFile = await DefaultCacheManager().getSingleFile(url);
          if (type == "video") {
            videoInitalize();
          }
          state = state.copyWith(file: cachedFile);
          sendFile(type, url);
        } else if (event.state == TaskState.error) {
          removeFile();
        }
      });
    }
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
    read(chatLogic.notifier).sendPushNoti("${user.name} ${type == 'image' ? 'képet' : 'videót'} küldött önnek");
  }

  Future<void> removeFile() async {
    await repo.removeFile(user.id, id);
  }
}
