import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class ImageIndicator extends StatelessWidget {
  final double width;
  final String file;
  final double progressValue;
  const ImageIndicator({
    Key? key,
    required this.width,
    required this.file,
    required this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width, 0, 7, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.memory(base64.decode(file), fit: BoxFit.cover),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SizedBox(
                height: width / 2.7,
                width: width / 2.7,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: progressValue),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, progress, child) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.grey[400]!,
                      valueColor: const AlwaysStoppedAnimation(Colors.black),
                      value: progress,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
