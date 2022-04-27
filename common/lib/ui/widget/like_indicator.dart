import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeIndicator extends StatefulWidget {
  final String like;
  final Function onTap;
  const LikeIndicator({
    Key? key,
    required this.like,
    required this.onTap,
  }) : super(key: key);

  @override
  _LikeIndicatorState createState() => _LikeIndicatorState();
}

class _LikeIndicatorState extends State<LikeIndicator> with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  @override
  void initState() {
    super.initState();

    _appearanceController = AnimationController(vsync: this, value: widget.like.isNotEmpty ? 1.0 : 0.0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(LikeIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.like.isNotEmpty) {
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
    return InkWell(
      onTap: () => widget.onTap(),
      child: Transform.scale(
        scale: _appearanceController.value,
        child: Container(
          height: 25,
          width: 25,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SvgPicture.asset(
            'assets/images/${widget.like}.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
    ;
  }
}
