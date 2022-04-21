import 'dart:io';
import 'package:common/ui/widget/image_indicator.dart';
import 'package:common/ui/widget/saw_indicator.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PictureBubble extends StatelessWidget {
  final double maxWidth;
  final bool isSender;
  final String picture;
  final bool isShowIndicator;
  final bool isSaw;
  final double progress;
  final String errorMessage;
  const PictureBubble({
    Key? key,
    required this.maxWidth,
    required this.isSender,
    this.picture = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.errorMessage = "",
    this.progress = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isShowIndicator) {
      return ImageIndicator(
        image: File(picture),
        progressValue: progress,
        width: maxWidth / 2,
      );
    }
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 7, 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: picture,
                child: CachedNetworkImage(
                  imageUrl: picture,
                  placeholder: (context, url) => Container(
                    height: 150,
                    color: Colors.black12,
                    width: maxWidth,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  width: maxWidth,
                  errorWidget: (c, s, d) {
                    return Container(
                      color: Colors.black12,
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text(
                        errorMessage,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  },
                ),
              ),
            ),
            if (isSender)
              Positioned(
                right: -6.0,
                bottom: -4.0,
                child: SawIndicator(showIndicator: isSaw),
              ),
          ],
        ),
      ),
    );
  }
}
