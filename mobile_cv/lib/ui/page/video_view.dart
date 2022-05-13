import 'dart:io';
import 'package:common/logic/file_logic.dart';
import 'package:common/ui/widget/thumbnail.dart';
import 'package:common/ui/widget/video_bubble.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mobile_cv/ui/application.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoView extends ConsumerWidget {
  final String id;
  final double maxWidth;
  final bool isSender;
  final String thumbnail;
  final bool isShowIndicator;
  final bool isSaw;
  final String like;
  final Function onTap;
  const VideoView({
    Key? key,
    required this.id,
    required this.maxWidth,
    required this.isSender,
    this.thumbnail = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.like = "",
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _videoPlayerController = ref.watch(fileLogic(id)).controller;
    final video = ref.watch(fileLogic(id)).file;
    return GestureDetector(
      onTap: () {
        if (_videoPlayerController != null) {
          globalNavigatorKey.currentState?.push(
            PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.transparent,
                pageBuilder: (BuildContext context, _, __) {
                  return VideoViewWidget(
                    video: video,
                    id: id,
                    thumbnail: thumbnail,
                  );
                }),
          );
        }
      },
      child: VideoBubble(
        id: id,
        controller: _videoPlayerController,
        isSender: isSender,
        video: video,
        thumbnail: thumbnail,
        isShowIndicator: isShowIndicator,
        isSaw: isSaw,
        maxWidth: maxWidth,
        like: like,
        onTap: () => onTap(),
      ),
    );
  }
}

class VideoViewWidget extends ConsumerStatefulWidget {
  final File? video;
  final String id;
  final String thumbnail;
  final VideoPlayerController? controller;
  const VideoViewWidget({
    Key? key,
    required this.video,
    required this.id,
    required this.thumbnail,
    this.controller,
  }) : super(key: key);

  @override
  ConsumerState<VideoViewWidget> createState() => _VideoViewWidgetState();
}

class _VideoViewWidgetState extends ConsumerState<VideoViewWidget> with TickerProviderStateMixin {
  double initalPositionY = 0.0;
  double initalPositionX = 0.0;
  double opacity = 0.0;
  double initalScaleFactor = 0.0;
  late AnimationController animationController;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      initalPositionY += details.delta.dy;
      animationController.value = initalPositionY < 0 ? 1.0 : 1 - (initalPositionY / 500);
      initalScaleFactor = initalPositionY < 0 ? 0.0 : 0.0 + (initalPositionY / 250);
    });
  }

  void onDragEnd(DragEndDetails details) {
    if (animationController.value <= 0.5) {
      animationController.reverse();
      Navigator.of(context).pop();
    } else {
      animationController.value = 1.0;
      setState(() {
        initalPositionY = 0.0;
        initalScaleFactor = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final duration = ref.watch(fileLogic(widget.id)).duration;
    final position = ref.watch(fileLogic(widget.id)).position;
    final isPlaying = ref.watch(fileLogic(widget.id)).isPlaying;
    final controller = ref.watch(fileLogic(widget.id)).controller;
    final isInitialized = ref.watch(fileLogic(widget.id)).isInitialized;
    return WillPopScope(
      onWillPop: () async {
        animationController.reverse();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: AnimatedBuilder(
              animation: animationController,
              builder: (c, w) {
                return GestureDetector(
                  onVerticalDragUpdate: onDragUpdate,
                  onVerticalDragEnd: onDragEnd,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(opacityAnimation.value),
                        height: height,
                        width: width,
                      ),
                      Positioned(
                        top: initalPositionY,
                        left: 0 + initalScaleFactor * 30,
                        right: 0 + initalScaleFactor * 30,
                        child: Container(
                          color: Colors.transparent,
                          height: height,
                          width: width,
                          child: GestureDetector(
                            onTap: () {
                              if (controller != null) {
                                if (isPlaying) {
                                  controller.pause();
                                } else {
                                  controller.play();
                                }
                              } else {
                                ref.read(fileLogic(widget.id).notifier).videoInitalize();
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Hero(
                                  tag: widget.video?.path ?? "",
                                  child: isInitialized && widget.video != null
                                      ? AspectRatio(
                                          aspectRatio: controller!.value.aspectRatio,
                                          child: VideoPlayer(controller),
                                        )
                                      : ThumbnailWidget(
                                          thumbnail: widget.thumbnail,
                                          maxWidth: MediaQuery.of(context).size.width,
                                        ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  left: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (controller != null) {
                                            if (controller.value.volume == 0) {
                                              controller.setVolume(1.0);
                                            } else {
                                              controller.setVolume(0.0);
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.black.withOpacity(0.7),
                                          ),
                                          child: Icon(
                                            controller?.value.volume == 0
                                                ? Icons.volume_off_rounded
                                                : Icons.volume_up_rounded,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        height: 50,
                                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              position.getDuration(),
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: ProgressBar(
                                                progress: position,
                                                total: duration,
                                                timeLabelLocation: TimeLabelLocation.none,
                                                onSeek: (duration) {
                                                  controller?.seekTo(duration);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              duration.getDuration(),
                                              style: const TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: !isPlaying,
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 80,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
