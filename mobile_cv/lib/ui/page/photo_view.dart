import 'dart:io';
import 'package:common/ui/widget/picture_bubble.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cv/ui/application.dart';

class PhotoView extends StatelessWidget {
  final double maxWidth;
  final bool isSender;
  final File? picture;
  final String indicatorPicture;
  final bool isShowIndicator;
  final bool isSaw;
  final double progress;
  final String errorMessage;
  final String like;
  final Function onTap;
  const PhotoView({
    Key? key,
    required this.maxWidth,
    required this.isSender,
    this.picture,
    this.indicatorPicture = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.errorMessage = "",
    this.progress = 0.0,
    this.like = "",
    required this.onTap,
  }) : super(key: key);

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
                return PhotoViewWidget(picture: picture);
              }),
        );
      },
      child: PictureBubble(
        isSender: isSender,
        picture: picture,
        indicatorPicture: indicatorPicture,
        isShowIndicator: isShowIndicator,
        progress: progress,
        isSaw: isSaw,
        maxWidth: maxWidth,
        like: like,
        errorMessage: errorMessage,
        onTap: () => onTap(),
      ),
    );
  }
}

class PhotoViewWidget extends StatefulWidget {
  final File? picture;
  const PhotoViewWidget({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  State<PhotoViewWidget> createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> with TickerProviderStateMixin {
  double initalPositionY = 0.0;
  double initalPositionX = 0.0;
  double opacity = 0.0;
  double initalScaleFactor = 0.0;
  double scaleFactor = 1.0;
  double currentScale = 0.0;
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

  void onDragStart(ScaleStartDetails details) {
    setState(() {
      currentScale = scaleFactor;
    });
  }

  void onDragUpdate(ScaleUpdateDetails details) {
    setState(() {
      initalPositionY += details.focalPointDelta.dy;
      if (currentScale * details.scale >= 1.0 && initalScaleFactor == 0.0) {
        scaleFactor = currentScale * details.scale;
      } else {
        scaleFactor = 1.0;
        initalPositionX = 0.0;
      }
      if (scaleFactor > 1.0) {
        initalPositionX += details.focalPointDelta.dx;
      }
      if (scaleFactor == 1.0) {
        animationController.value = initalPositionY < 0 ? 1.0 : 1 - (initalPositionY / 500);
        initalScaleFactor = initalPositionY < 0 ? 0.0 : 0.0 + (initalPositionY / 250);
      }
    });
  }

  void onDragEnd(ScaleEndDetails details) {
    if (scaleFactor == 1.0) {
      if (animationController.value <= 0.7) {
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
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  onScaleStart: onDragStart,
                  onScaleUpdate: onDragUpdate,
                  onScaleEnd: onDragEnd,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(opacityAnimation.value),
                        height: height,
                        width: width,
                      ),
                      Positioned(
                        top: initalPositionY,
                        left: scaleFactor > 1.0 ? initalPositionX : 0 + initalScaleFactor * 30,
                        right: scaleFactor > 1.0 ? -initalPositionX : 0 + initalScaleFactor * 30,
                        child: Container(
                          color: Colors.transparent,
                          height: height,
                          width: width,
                          child: Hero(
                            tag: widget.picture?.path ?? "",
                            child: Transform.scale(
                              scale: scaleFactor,
                              child: widget.picture != null
                                  ? Image.file(
                                      widget.picture!,
                                      errorBuilder: (c, o, s) {
                                        return Container(
                                          color: Colors.black12,
                                          height: height,
                                          width: width,
                                        );
                                      },
                                    )
                                  : Container(),
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
