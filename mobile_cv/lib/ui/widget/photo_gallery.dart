import 'dart:typed_data';
import 'package:common/ui/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoGallery extends StatefulWidget {
  final ScrollController controller;
  const PhotoGallery({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  List<AssetEntity> assets = [];

  List<AssetEntity> selectedAssets = [];

  @override
  void initState() {
    getAlbums();
    super.initState();
  }

  void getAlbums() async {
    final albums = await PhotoManager.getAssetPathList();

    for (var item in albums) {
      if (item.name == 'Screenshots' ||
          item.name == 'Camera' ||
          item.name == 'Download' ||
          item.name == 'Screen recordings') {
        final recentAssets = await item.getAssetListRange(
          start: 0,
          end: 1000000,
        );
        assets.addAll(recentAssets);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,
            ),
            padding: const EdgeInsets.all(7),
            physics: const BouncingScrollPhysics(),
            controller: widget.controller,
            itemCount: assets.length,
            itemBuilder: (_, index) {
              final selected = selectedAssets.any((element) => element == assets[index]);
              return AssetThumbnail(
                asset: assets[index],
                selected: selected,
                onTap: (value) {
                  final _selected = selectedAssets.any((element) => element == value);
                  setState(() {
                    if (!_selected) {
                      selectedAssets.add(value);
                    } else {
                      selectedAssets.remove(value);
                    }
                  });
                },
              );
            },
          ),
          if (selectedAssets.isNotEmpty)
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: CustomButton.primary(
                child: const Text("Küldés"),
                onTap: () {
                  Navigator.of(context).pop(selectedAssets);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class AssetThumbnail extends StatefulWidget {
  final bool selected;
  final AssetEntity asset;
  final Function(AssetEntity) onTap;
  const AssetThumbnail({
    Key? key,
    required this.asset,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<AssetThumbnail> {
  Uint8List? bytes;
  @override
  void initState() {
    getBytes();
    super.initState();
  }

  void getBytes() async {
    final _bytes = await widget.asset.thumbnailData;
    setState(() {
      bytes = _bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (bytes == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return GestureDetector(
      onTap: () => widget.onTap(widget.asset),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(bytes!, fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 25,
            width: 25,
            margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            decoration: BoxDecoration(
              color: widget.selected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: widget.selected
                ? const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  )
                : Container(
                    color: Colors.white.withOpacity(0.6),
                  ),
          ),
          if (widget.asset.type == AssetType.video)
            Center(
              child: Icon(
                Icons.play_arrow_rounded,
                color: Colors.white.withOpacity(0.7),
                size: 60,
              ),
            ),
        ],
      ),
    );
  }
}
