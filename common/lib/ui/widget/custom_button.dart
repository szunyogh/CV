import 'package:common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final double width;
  final Color color;
  final Function onTap;
  const CustomButton({
    Key? key,
    required this.child,
    required this.color,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  factory CustomButton.primary({required Widget child, required Function onTap, double width = double.maxFinite}) {
    return CustomButton(child: child, color: blueColor, onTap: onTap, width: width);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        child: child,
        onPressed: () => onTap(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
      ),
    );
  }
}
