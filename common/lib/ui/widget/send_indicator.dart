import 'package:flutter/material.dart';

class SendIndicator extends StatefulWidget {
  final bool showIndicator;
  const SendIndicator({Key? key, this.showIndicator = true}) : super(key: key);

  @override
  _SendIndicatorState createState() => _SendIndicatorState();
}

class _SendIndicatorState extends State<SendIndicator> with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  late Animation<double> _indicatorSpaceAnimation;

  @override
  void initState() {
    super.initState();
    _appearanceController = AnimationController(
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _indicatorSpaceAnimation = CurvedAnimation(
      parent: _appearanceController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut,
    ).drive(Tween<double>(
      begin: 0.0,
      end: 20.0,
    ));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.showIndicator) {
        _showIndicator();
      }
    });
  }

  @override
  void didUpdateWidget(SendIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showIndicator) {
      _showIndicator();
    } else {
      _hideIndicator();
    }
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    super.dispose();
  }

  void _showIndicator() {
    _appearanceController.value = 1.0;
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 200)
      ..reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _indicatorSpaceAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _appearanceController.value,
            child: Container(
              width: _indicatorSpaceAnimation.value,
              child: const Icon(
                Icons.send_rounded,
                color: Colors.grey,
              ),
            ),
          );
        });
    ;
  }
}
