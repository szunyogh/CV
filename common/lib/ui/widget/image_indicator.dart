import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

class ImageIndicator extends StatefulWidget {
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
  State<ImageIndicator> createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends State<ImageIndicator> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    bytes = base64.decode(widget.file);
  }

  @override
  void didUpdateWidget(covariant ImageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file != widget.file) {
      setState(() {
        bytes = base64.decode(widget.file);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(widget.width, 0, 7, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.memory(bytes!, fit: BoxFit.cover),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: SizedBox(
                height: widget.width / 2.7,
                width: widget.width / 2.7,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: widget.progressValue),
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
