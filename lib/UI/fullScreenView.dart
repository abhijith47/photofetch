import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  static const routeName = '/splash';
  final String imageUrl;
  final String uniqueId;
  final String title;

  const FullScreenImage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.uniqueId,
  }) : super(key: key);
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  double imageHeight = 200;
  double imageWidth = 200;
  bool fullscreen = true;
  bool instance = true;

  @override
  void initState() {
    super.initState();
  }

  changeSize(fullscreen) {
    if (fullscreen) {
      imageHeight = MediaQuery.of(context).size.height;
      imageWidth = MediaQuery.of(context).size.width;
    } else {
      imageHeight = MediaQuery.of(context).size.width - 10;
      imageWidth = MediaQuery.of(context).size.width - 10;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (instance) {
      instance = false;
      changeSize(true);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Hero(
                tag: widget.uniqueId.toString(),
                child: CachedNetworkImage(
                  height: imageHeight,
                  width: imageWidth,
                  fit: fullscreen ? BoxFit.cover : BoxFit.fitWidth,
                  imageUrl: widget.imageUrl,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            right: 15,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 70,
              //  width: MediaQuery.of(context).size.width * .7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          widget.title,
                          maxLines: 6,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                        )),
                    IconButton(
                        onPressed: () {
                          fullscreen = !fullscreen;
                          changeSize(fullscreen);
                        },
                        icon: Icon(
                          fullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          color: Colors.black,
                          size: 25,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
