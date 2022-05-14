import 'dart:io';
import 'package:common/logic/file_logic.dart';
import 'package:common/ui/widget/image_indicator.dart';
import 'package:common/ui/widget/like_indicator.dart';
import 'package:common/ui/widget/saw_indicator.dart';
import 'package:common/ui/widget/thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoBubble extends ConsumerWidget {
  final String id;
  final double maxWidth;
  final bool isSender;
  final File? video;
  final String thumbnail;
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
    this.thumbnail = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.like = "",
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(fileLogic(id)).progress;
    final duration = ref.watch(fileLogic(id)).duration;
    final position = ref.watch(fileLogic(id)).position;
    final isPlaying = ref.watch(fileLogic(id)).isPlaying;
    final isInitialized = ref.watch(fileLogic(id)).isInitialized;
    final aspectRatio = controller?.value.aspectRatio ?? 9 / 16;
    if (isShowIndicator) {
      return ImageIndicator(
        file: thumbnail,
        progressValue: progress,
        width: maxWidth / 2,
      );
    }
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 7, 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: video?.path ?? "",
                child: Container(
                  width: maxWidth,
                  color: Colors.black12,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        isInitialized && video != null
                            ? SizedBox(
                                width: maxWidth,
                                child: AspectRatio(
                                  aspectRatio: aspectRatio,
                                  child: VideoPlayer(controller!),
                                ),
                              )
                            : ThumbnailWidget(
                                thumbnail: thumbnail,
                                maxWidth: maxWidth,
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
                        Visibility(
                          visible: !isPlaying,
                          child: GestureDetector(
                            onTap: () {
                              ref.read(fileLogic(id).notifier).videoInitalize();
                            },
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 80,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                left: isSender ? -9 : null,
                right: isSender ? null : -10,
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
