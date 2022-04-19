import 'dart:io';
import 'package:common/ui/widget/image_indicator.dart';
import 'package:common/ui/widget/saw_indicator.dart';
import 'package:flutter/material.dart';

class PictureBubble extends StatelessWidget {
  final double maxWidth;
  final bool isSender;
  final String picture;
  final Function() onTap;
  final bool isShowIndicator;
  final bool isSaw;
  final double progress;
  const PictureBubble({
    Key? key,
    required this.maxWidth,
    required this.isSender,
    this.picture = "",
    required this.onTap,
    this.isShowIndicator = false,
    this.isSaw = false,
    this.progress = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isShowIndicator) {
      return ImageIndicator(
        image: File(picture),
        progressValue: progress,
        width: maxWidth,
      );
    }
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () => onTap(),
            child: Hero(
              tag: picture,
              child: Image.network(
                picture,
                loadingBuilder: (c, w, e) {
                  if (e == null) return w;
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                width: maxWidth,
                errorBuilder: (c, e, s) {
                  return picture.isNotEmpty
                      ? Image.file(
                          File(picture),
                          errorBuilder: (fc, fe, fs) => Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                            child: Text(
                              "Kép feltöltése folyamatban...",
                              style:
                                  isSender ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            "Hiba a kép betöltésekor!",
                            style: isSender ? Theme.of(context).textTheme.bodyText1 : Theme.of(context).textTheme.bodyText2,
                          ),
                        );
                },
              ),
            ),
          ),
        ),
        if (isSender)
          Positioned(
            right: 0,
            bottom: 2,
            child: SawIndicator(showIndicator: isSaw),
          ),
      ],
    );
  }
}
