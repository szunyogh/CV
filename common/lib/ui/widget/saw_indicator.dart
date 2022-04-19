import 'package:flutter/material.dart';

class SawIndicator extends StatefulWidget {
  final bool showIndicator;
  const SawIndicator({Key? key, this.showIndicator = true}) : super(key: key);

  @override
  _SawIndicatorState createState() => _SawIndicatorState();
}

class _SawIndicatorState extends State<SawIndicator> with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(vsync: this, value: widget.showIndicator ? 1.0 : 0.0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(SawIndicator oldWidget) {
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
    _appearanceController
      ..duration = const Duration(milliseconds: 100)
      ..forward();
  }

  void _hideIndicator() {
    _appearanceController
      ..duration = const Duration(milliseconds: 100)
      ..reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _appearanceController.value,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.grey[100]!),
        ),
        child: const Icon(
          Icons.done,
          color: Colors.white,
          size: 14,
        ),
      ),
    );
    ;
  }
}
