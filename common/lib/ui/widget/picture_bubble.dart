import 'dart:io';
import 'package:common/logic/file_logic.dart';
import 'package:common/ui/widget/image_indicator.dart';
import 'package:common/ui/widget/like_indicator.dart';
import 'package:common/ui/widget/saw_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PictureBubble extends ConsumerWidget {
  final String id;
  final double maxWidth;
  final bool isSender;
  final File? picture;
  final String indicatorPicture;
  final bool isShowIndicator;
  final bool isSaw;
  final String errorMessage;
  final String like;
  final Function onTap;
  const PictureBubble({
    Key? key,
    required this.id,
    required this.maxWidth,
    required this.isSender,
    this.picture,
    this.indicatorPicture = "",
    this.isShowIndicator = false,
    this.isSaw = false,
    this.errorMessage = "",
    this.like = "",
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(fileLogic(id)).progress;
    if (isShowIndicator) {
      return ImageIndicator(
        file: indicatorPicture,
        progressValue: progress,
        width: maxWidth / 2,
      );
    }
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 7, 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: picture?.path ?? "",
                child: picture != null
                    ? Image.file(
                        picture!,
                        width: maxWidth,
                        errorBuilder: (c, o, s) {
                          return Container(
                            color: Colors.red[400],
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              errorMessage,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 150,
                        color: Colors.black12,
                        width: maxWidth,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
            if (isSender)
              Positioned(
                right: -6.0,
                bottom: -4.0,
                child: SawIndicator(showIndicator: isSaw),
              ),
            if (like.isNotEmpty)
              Positioned(
                bottom: -6,
                left: isSender ? -9 : null,
                right: isSender ? null : -9,
                child: LikeIndicator(
                  like: like,
                  onTap: () => onTap(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
