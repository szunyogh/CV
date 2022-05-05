import 'package:common/ui/widget/video_bubble.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:mobile_cv/ui/application.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class VideoView extends StatefulWidget {
  final double maxWidth;
  final bool isSender;
  final String video;
  final bool isShowIndicator;
  final bool isSaw;
  final String like;
  final Function onTap;
  final double progress;
  const VideoView({
    Key? key,
    required this.maxWidth,
    required this.isSender,
    this.video = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.like = "",
    required this.onTap,
    required this.progress,
  }) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _videoPlayerController;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.video, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
          ..initialize().then(
            (value) => setState(() {
              duration = _videoPlayerController?.value.duration ?? Duration.zero;
            }),
          );

    _videoPlayerController?.addListener(() => listener());
  }

  void listener() {
    if (_videoPlayerController?.value.position == _videoPlayerController?.value.duration) {
      _videoPlayerController?.seekTo(const Duration(seconds: 0));
    }
    setState(() {
      position = _videoPlayerController?.value.position ?? Duration.zero;
    });
  }

  @override
  void didUpdateWidget(covariant VideoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video != widget.video) {
      _videoPlayerController =
          VideoPlayerController.network(widget.video, videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
            ..initialize().then(
              (value) => setState(() {
                duration = _videoPlayerController?.value.duration ?? Duration.zero;
              }),
            );
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.removeListener(() {});
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        globalNavigatorKey.currentState?.push(
          PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.transparent,
              pageBuilder: (BuildContext context, _, __) {
                return VideoViewWidget(
                  video: widget.video,
                  controller: _videoPlayerController,
                  duration: duration,
                );
              }),
        );
      },
      child: VideoBubble(
        controller: _videoPlayerController,
        isSender: widget.isSender,
        video: widget.video,
        isShowIndicator: widget.isShowIndicator,
        progress: widget.progress,
        isSaw: widget.isSaw,
        maxWidth: widget.maxWidth,
        like: widget.like,
        errorMessage: widget.isShowIndicator ? "Hiba a videó betöltése során" : "A videó feltöltése folyamatban",
        onTap: () => widget.onTap(),
        position: position,
        duration: duration,
      ),
    );
  }
}

class VideoViewWidget extends StatefulWidget {
  final String video;
  final VideoPlayerController? controller;
  final Duration duration;
  const VideoViewWidget({
    Key? key,
    required this.video,
    required this.controller,
    required this.duration,
  }) : super(key: key);

  @override
  State<VideoViewWidget> createState() => _VideoViewWidgetState();
}

class _VideoViewWidgetState extends State<VideoViewWidget> with TickerProviderStateMixin {
  double initalPositionY = 0.0;
  double initalPositionX = 0.0;
  double opacity = 0.0;
  double initalScaleFactor = 0.0;
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });
    isPlaying = widget.controller?.value.isPlaying ?? false;
    duration = widget.controller?.value.duration ?? Duration.zero;
    widget.controller?.addListener(() => listener());
  }

  void listener() {
    if (widget.controller?.value.position == widget.controller?.value.duration) {
      widget.controller?.seekTo(const Duration(seconds: 0));
    }
    setState(() {
      isPlaying = widget.controller?.value.isPlaying ?? false;
      position = widget.controller?.value.position ?? Duration.zero;
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(() {});
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
    bool isInitialized = widget.controller?.value.isInitialized ?? false;
    String _duration = duration.getDuration();
    String _position = position.getDuration();
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
                              if (isPlaying) {
                                widget.controller?.pause();
                                setState(() {});
                              } else {
                                widget.controller?.play();
                                setState(() {});
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Hero(
                                  tag: widget.video,
                                  child: isInitialized
                                      ? AspectRatio(
                                          aspectRatio: widget.controller!.value.aspectRatio,
                                          child: VideoPlayer(widget.controller!),
                                        )
                                      : Container(),
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
                                          if (widget.controller?.value.volume == 0) {
                                            widget.controller?.setVolume(1.0);
                                          } else {
                                            widget.controller?.setVolume(0.0);
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
                                            widget.controller?.value.volume == 0
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
                                              _position,
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: ProgressBar(
                                                progress: position,
                                                total: duration,
                                                timeLabelLocation: TimeLabelLocation.none,
                                                onSeek: (duration) {
                                                  widget.controller?.seekTo(duration);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              _duration,
                                              style: const TextStyle(color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isInitialized
                                    ? Visibility(
                                        visible: !isPlaying,
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 80,
                                        ),
                                      )
                                    : const CircularProgressIndicator()
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
