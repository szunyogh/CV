import 'dart:io';
import 'package:common/logic/file_logic.dart';
import 'package:common/ui/widget/image_indicator.dart';
import 'package:common/ui/widget/like_indicator.dart';
import 'package:common/ui/widget/saw_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoBubble extends ConsumerWidget {
  final String id;
  final double maxWidth;
  final bool isSender;
  final File? video;
  final String indicatorPicture;
  final bool isShowIndicator;
  final bool isSaw;
  final String like;
  final Function onTap;
  final VideoPlayerController? controller;
  const VideoBubble({
    Key? key,
    required this.id,
    required this.maxWidth,
    required this.isSender,
    this.video,
    this.indicatorPicture = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.like = "",
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isInitialized = controller?.value.isInitialized ?? false;
    final progress = ref.watch(fileLogic(id)).progress;
    final duration = ref.watch(fileLogic(id)).duration;
    final position = ref.watch(fileLogic(id)).position;
    final isPlaying = ref.watch(fileLogic(id)).isPlaying;
    if (isShowIndicator) {
      return ImageIndicator(
        file: indicatorPicture,
        progressValue: progress,
        width: maxWidth / 2,
      );
    }
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 7, 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: video?.path ?? "",
                child: Container(
                  color: Colors.black12,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: maxWidth,
                        child: isInitialized && video != null
                            ? AspectRatio(
                                aspectRatio: controller!.value.aspectRatio,
                                child: VideoPlayer(controller!),
                              )
                            : const AspectRatio(
                                aspectRatio: 1,
                              ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black.withOpacity(0.7),
                          ),
                          child: FittedBox(
                            child: Text(
                              '${position.getDuration()}/${duration.getDuration()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      isInitialized
                          ? Visibility(
                              visible: !isPlaying,
                              child: GestureDetector(
                                onTap: () {
                                  controller?.play();
                                },
                                child: Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 80,
                                ),
                              ),
                            )
                          : const CircularProgressIndicator()
                    ],
                  ),
                ),
              ),
            ),
            if (isSender)
              Positioned(
                right: -6.0,
                bottom: -4.0,
                child: SawIndicator(showIndicator: isSaw),
              ),
            if (like.isNotEmpty)
              Positioned(
                bottom: -6,
                left: -9,
                child: LikeIndicator(
                  like: like,
                  onTap: () => onTap(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

extension HmsString on Duration {
  String getDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
