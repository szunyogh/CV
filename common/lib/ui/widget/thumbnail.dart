import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ThumbnailWidget extends StatefulWidget {
  final String thumbnail;
  final double maxWidth;
  const ThumbnailWidget({
    Key? key,
    required this.thumbnail,
    required this.maxWidth,
  }) : super(key: key);

  @override
  State<ThumbnailWidget> createState() => _ThumbnailWidgetState();
}

class _ThumbnailWidgetState extends State<ThumbnailWidget> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    bytes = base64.decode(widget.thumbnail);
  }

  @override
  void didUpdateWidget(covariant ThumbnailWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thumbnail != widget.thumbnail) {
      bytes = base64.decode(widget.thumbnail);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      bytes!,
      fit: BoxFit.cover,
      width: widget.maxWidth,
      errorBuilder: (c, o, s) {
        return AspectRatio(
          aspectRatio: 9 / 16,
          child: Container(
            color: Colors.black12,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
