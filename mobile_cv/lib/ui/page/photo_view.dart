import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {
  final String picture;
  const PhotoView({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Hero(
          tag: picture,
          child: Image.network(
            picture,
            loadingBuilder: (c, w, e) {
              if (e == null) return w;
              return Container(
                color: Colors.black12,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
