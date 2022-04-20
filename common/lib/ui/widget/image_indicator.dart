import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageIndicator extends ConsumerWidget {
  final double width;
  final File image;
  final double progressValue;
  const ImageIndicator({
    Key? key,
    required this.width,
    required this.image,
    required this.progressValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width, 0, 7, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.file(
              image,
            ),
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
