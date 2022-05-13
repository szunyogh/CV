import 'dart:typed_data';
import 'package:common/ui/theme/theme.dart';
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
  Map<String, List<AssetEntity>> assets = {};

  List<AssetEntity> selectedAssets = [];

  List<AssetPathEntity> albums = [];

  String selectedAlbum = "Recent";

  @override
  void initState() {
    getAlbums();
    super.initState();
  }

  void getAlbums() async {
    albums = await PhotoManager.getAssetPathList();
    selectedAlbum = albums.first.name;
    for (var item in albums) {
      final recentAssets = await item.getAssetListRange(
        start: 0,
        end: 1000000,
      );
      assets.addAll({item.name: recentAssets});
    }
    debugPrint("");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Albums(
              albums: assets.keys.toList(),
              onChangedAlbum: (value) async {
                setState(() {
                  selectedAlbum = value;
                });
              },
              selectAlbum: selectedAlbum,
            ),
            if (assets[selectedAlbum] != null)
              Expanded(
                child: GridViewWidget(
                  assets: assets[selectedAlbum]!,
                  controller: widget.controller,
                  selectedAssets: selectedAssets,
                  onChanged: (value) {
                    setState(() {
                      selectedAssets = value;
                    });
                  },
                ),
              ),
          ],
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
    );
  }
}

class GridViewWidget extends StatelessWidget {
  final ScrollController controller;
  final List<AssetEntity> assets;
  final List<AssetEntity> selectedAssets;
  final Function(List<AssetEntity>) onChanged;
  const GridViewWidget({
    Key? key,
    required this.assets,
    required this.controller,
    required this.selectedAssets,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
      ),
      padding: const EdgeInsets.all(7),
      physics: const BouncingScrollPhysics(),
      controller: controller,
      itemCount: assets.length,
      itemBuilder: (_, index) {
        final selected = selectedAssets.any((element) => element == assets[index]);
        return AssetThumbnail(
          asset: assets[index],
          selected: selected,
          onTap: (value) {
            final _selected = selectedAssets.any((element) => element == value);
            if (!_selected) {
              selectedAssets.add(value);
            } else {
              selectedAssets.remove(value);
            }
            onChanged(selectedAssets);
          },
        );
      },
    );
  }
}

class Albums extends StatelessWidget {
  final List<String> albums;
  final Function(String) onChangedAlbum;
  final String selectAlbum;
  const Albums({
    Key? key,
    required this.albums,
    required this.selectAlbum,
    required this.onChangedAlbum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      scrollDirection: Axis.horizontal,
      child: Wrap(
        runSpacing: 5,
        spacing: 5,
        children: albums.map((album) {
          return GestureDetector(
            onTap: () => onChangedAlbum(album),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: album == selectAlbum ? blueColor : Colors.transparent,
              ),
              child: Text(
                album,
                style: TextStyle(
                  color: album == selectAlbum ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
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
  void didUpdateWidget(covariant AssetThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset != widget.asset) {
      getBytes();
    }
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
