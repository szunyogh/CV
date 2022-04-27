import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class LikeWidget extends StatefulWidget {
  final Widget child;
  final Function(String) onChanged;
  final bool enabled;
  const LikeWidget({
    Key? key,
    required this.child,
    required this.onChanged,
    this.enabled = false,
  }) : super(key: key);

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  OverlayEntry? loader;
  final GlobalKey key = GlobalKey();
  Offset initalPosition = Offset.zero;
  double dragPosition = 0.0;

  String selectEmoji = "";

  void showLoader(BuildContext _context) {
    OverlayState overlay = Overlay.of(_context)!;

    if (loader == null) {
      loader = OverlayEntry(
        maintainState: true,
        builder: (context) {
          return Stack(
            children: [
              _OverLay(
                dragPosition: dragPosition,
                initalPosition: initalPosition,
                onChanged: (value) {
                  selectEmoji = value;
                },
              ),
            ],
          );
        },
      );
      overlay.insert(loader!);
    }
  }

  void hideloader() {
    loader!.remove();
    loader = null;
  }

  void onLongPressStart(BuildContext context, LongPressStartDetails details) {
    if (!widget.enabled) return;
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    setState(() {
      initalPosition = box.localToGlobal(Offset.zero);
    });
    showLoader(context);
  }

  void onLongPressUpdate(LongPressMoveUpdateDetails details) {
    if (!widget.enabled) return;
    setState(() {
      dragPosition = details.localPosition.dx;
    });
    loader?.markNeedsBuild();
  }

  void onLongPressEnd(LongPressEndDetails details) {
    if (!widget.enabled) return;
    widget.onChanged(selectEmoji);
    hideloader();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) => onLongPressStart(context, details),
      onLongPressMoveUpdate: onLongPressUpdate,
      onLongPressEnd: onLongPressEnd,
      child: Container(key: key, child: widget.child),
    );
  }
}

class Emotikon extends StatefulWidget {
  final String url;
  final Function(double, double) onPosition;
  final bool isSelected;
  const Emotikon({
    Key? key,
    required this.url,
    required this.onPosition,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<Emotikon> createState() => _EmotikonState();
}

class _EmotikonState extends State<Emotikon> {
  final GlobalKey key = GlobalKey();
  double p1 = 0.0;
  double p2 = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await WidgetsBinding.instance?.endOfFrame;
      RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      p1 = position.dx - (box.size.width / 2);
      p2 = position.dx;
      widget.onPosition(p1, p2);
      if (widget.isSelected) {
        Vibrate.feedback(FeedbackType.impact);
      }
    });
  }

  @override
  void didUpdateWidget(covariant Emotikon oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.onPosition(p1, p2);
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        Vibrate.feedback(FeedbackType.impact);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.isSelected ? 1.5 : 1.0,
      duration: const Duration(milliseconds: 100),
      alignment: Alignment.bottomCenter,
      child: SvgPicture.asset(
        widget.url,
        key: key,
        height: 40,
        width: 40,
      ),
    );
  }
}

class _OverLay extends StatefulWidget {
  final double dragPosition;
  final Offset initalPosition;
  final Function(String) onChanged;
  const _OverLay({
    Key? key,
    required this.dragPosition,
    required this.initalPosition,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_OverLay> createState() => __OverLayState();
}

class __OverLayState extends State<_OverLay> with TickerProviderStateMixin {
  bool emoji1 = false;
  bool emoji2 = false;
  bool emoji3 = false;
  bool emoji4 = false;
  bool emoji5 = false;
  bool emoji6 = false;

  String selectEmojiName = "";

  late AnimationController controller;

  late Animation<double> cardOpacityAnimation;
  late Animation<double> cardMoveAnimation;
  late Animation<double> emoji1Animation;
  late Animation<double> emoji2Animation;
  late Animation<double> emoji3Animation;
  late Animation<double> emoji4Animation;
  late Animation<double> emoji5Animation;
  late Animation<double> emoji6Animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    cardOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    ));
    emoji1Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.25,
        curve: Curves.ease,
      ),
    ));
    emoji2Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.15,
        0.4,
        curve: Curves.ease,
      ),
    ));
    emoji3Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.3,
        0.55,
        curve: Curves.ease,
      ),
    ));
    emoji4Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.45,
        0.7,
        curve: Curves.ease,
      ),
    ));
    emoji5Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.6,
        0.85,
        curve: Curves.ease,
      ),
    ));
    emoji6Animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.75,
        1.0,
        curve: Curves.ease,
      ),
    ));
    cardMoveAnimation =
        Tween<double>(begin: widget.initalPosition.dy, end: widget.initalPosition.dy - 45).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    ));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(covariant _OverLay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (emoji1 || emoji2 || emoji3 || emoji4 || emoji5 || emoji6) {
      widget.onChanged(selectEmojiName);
    } else {
      widget.onChanged("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Positioned(
            top: cardMoveAnimation.value,
            left: 30,
            right: 30,
            child: Stack(
              children: [
                Opacity(
                  opacity: cardOpacityAnimation.value,
                  child: Card(
                    elevation: 4,
                    child: SizedBox(
                      height: 40,
                      child: Container(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Transform.scale(
                          scale: emoji1Animation.value,
                          child: Emotikon(
                            url: 'assets/images/hFace.svg',
                            isSelected: emoji1,
                            onPosition: (p1, p2) {
                              if (widget.dragPosition >= p1 && widget.dragPosition <= p2) {
                                selectEmojiName = "hFace";
                                emoji1 = true;
                              } else {
                                emoji1 = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.scale(
                          scale: emoji2Animation.value,
                          child: Emotikon(
                            url: 'assets/images/lFace.svg',
                            isSelected: emoji2,
                            onPosition: (p1, p2) {
                              if (widget.dragPosition >= p1 && widget.dragPosition <= p2) {
                                selectEmojiName = "lFace";
                                emoji2 = true;
                              } else {
                                emoji2 = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.scale(
                          scale: emoji3Animation.value,
                          child: Emotikon(
                            url: 'assets/images/rFace.svg',
                            isSelected: emoji3,
                            onPosition: (p1, p2) {
                              if (widget.dragPosition >= p1 && widget.dragPosition <= p2) {
                                selectEmojiName = "rFace";
                                emoji3 = true;
                              } else {
                                emoji3 = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.scale(
                          scale: emoji4Animation.value,
                          child: Emotikon(
                            url: 'assets/images/vFace.svg',
                            isSelected: emoji4,
                            onPosition: (p1, p2) {
                              if (widget.dragPosition >= p1 && widget.dragPosition <= p2) {
                                selectEmojiName = "vFace";
                                emoji4 = true;
                              } else {
                                emoji4 = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.scale(
                          scale: emoji5Animation.value,
                          child: Emotikon(
                            url: 'assets/images/cFace.svg',
                            isSelected: emoji5,
                            onPosition: (p1, p2) {
                              if (widget.dragPosition >= p1 && widget.dragPosition <= p2) {
                                selectEmojiName = "cFace";
                                emoji5 = true;
                              } else {
                                emoji5 = false;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Transform.scale(
                          scale: emoji6Animation.value,
                          child: Emotikon(
                            url: 'assets/images/sFace.svg',
                            isSelected: emoji6,
                            onPosition: (p1, p2) {
                              if (widget.dragPosition >= p1 && widget.dragPosition <= p2) {
                                selectEmojiName = "sFace";
                                emoji6 = true;
                              } else {
                                emoji6 = false;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
