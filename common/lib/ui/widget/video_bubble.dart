import 'package:common/ui/widget/image_indicator.dart';
import 'package:common/ui/widget/like_indicator.dart';
import 'package:common/ui/widget/saw_indicator.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBubble extends StatefulWidget {
  final double maxWidth;
  final bool isSender;
  final String video;
  final bool isShowIndicator;
  final bool isSaw;
  final double progress;
  final String errorMessage;
  final String like;
  final Function onTap;
  final VideoPlayerController? controller;
  final Duration position;
  final Duration duration;
  const VideoBubble({
    Key? key,
    required this.maxWidth,
    required this.isSender,
    this.video = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.errorMessage = "",
    this.progress = 0.0,
    this.like = "",
    required this.onTap,
    required this.controller,
    required this.duration,
    required this.position,
  }) : super(key: key);

  @override
  State<VideoBubble> createState() => _VideoBubbleState();
}

class _VideoBubbleState extends State<VideoBubble> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void didUpdateWidget(covariant VideoBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      setState(() {
        duration = widget.duration;
      });
    }
    if (oldWidget.position != widget.position) {
      setState(() {
        position = widget.position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isInitialized = widget.controller?.value.isInitialized ?? false;
    bool isPlaying = widget.controller?.value.isPlaying ?? false;
    String _duration = duration.getDuration();
    String _position = position.getDuration();
    if (widget.isShowIndicator) {
      return ImageIndicator(
        file: widget.video,
        progressValue: widget.progress,
        width: widget.maxWidth / 2,
      );
    }
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 7, 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: widget.video,
                child: Container(
                  color: Colors.black12,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: widget.maxWidth,
                        child: isInitialized
                            ? AspectRatio(
                                aspectRatio: widget.controller!.value.aspectRatio,
                                child: VideoPlayer(widget.controller!),
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
                              '$_position/$_duration',
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
                                  widget.controller?.play();
                                  setState(() {});
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
            if (widget.isSender)
              Positioned(
                right: -6.0,
                bottom: -4.0,
                child: SawIndicator(showIndicator: widget.isSaw),
              ),
            if (widget.like.isNotEmpty)
              Positioned(
                bottom: -6,
                left: -9,
                child: LikeIndicator(
                  like: widget.like,
                  onTap: () => widget.onTap(),
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
