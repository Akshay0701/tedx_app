import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PageViewTile extends StatefulWidget {
  final NetworkImage networkImage;

  const PageViewTile({Key? key, required this.networkImage}) : super(key: key);

  @override
  _PageViewTileState createState() => _PageViewTileState();
}

class _PageViewTileState extends State<PageViewTile> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: CachedNetworkImage(
          progressIndicatorBuilder:
              (BuildContext cnt, String s, DownloadProgress d) =>
                  Center(child: CircularProgressIndicator()),
          imageUrl: widget.networkImage.url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
