import 'package:flutter/material.dart';
import 'package:mobile_cv/ui/application.dart';

class PhotoViewWidget extends StatelessWidget {
  final Widget child;
  final String picture;
  const PhotoViewWidget({
    Key? key,
    required this.child,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        globalNavigatorKey.currentState?.push(
          PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.transparent,
              pageBuilder: (BuildContext context, _, __) {
                return PhotoView(picture: picture);
              }),
        );
      },
      child: child,
    );
  }
}

class PhotoView extends StatefulWidget {
  final String picture;
  const PhotoView({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> with TickerProviderStateMixin {
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
        initalPositionY = 0.0;
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
    final double flingVelocity = details.velocity.pixelsPerSecond.dy;
    if (scaleFactor == 1.0) {
      if (flingVelocity > 0) {
        animationController.reverse();
        Navigator.of(context).pop();
      } else if (flingVelocity < 0) {
        animationController.value = 1.0;
        setState(() {
          initalPositionY = 0.0;
          initalScaleFactor = 0.0;
        });
      } else {
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
                            tag: widget.picture,
                            child: Transform.scale(
                              scale: scaleFactor,
                              child: Image.network(
                                widget.picture,
                                loadingBuilder: (c, w, e) {
                                  if (e == null) return w;
                                  return Container(
                                    color: Colors.black12,
                                    height: height,
                                    width: width,
                                    child: const Center(child: CircularProgressIndicator()),
                                  );
                                },
                              ),
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
