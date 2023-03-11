import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:photofetch/UI/fullScreenView.dart';
import 'package:photofetch/models/imageModel.dart';
import 'package:photofetch/providers/imageProvider.dart';
import 'package:photofetch/utils/utilities.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/homepage';

  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 1;
  bool _isLoading = false;
  bool initial = true;
  bool multigrid = true;
  int columnCount = 3;

  @override
  void initState() {
    super.initState();
    //calling the api at first to load initial data on screen
    _fetchImages(initial);
  }

  Future<void> _fetchImages(initial) async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.

      if (await Utils.connectivityCheck()) {
        final imageProvider =
            Provider.of<PhotoProvider>(context, listen: false);
        if (initial) {
          _currentPage = 1;
          imageProvider.imageList.clear();
        }
        if (_isLoading) {
          return;
        }
        setState(() {
          _isLoading = true;
        });
        final response = await http.get(Uri.parse(
            'https://jsonplaceholder.typicode.com/photos?4_page=$_currentPage&_limit=18 '));
        final jsonData = json.decode(response.body);
        for (var i = 0; i < jsonData.length; i++) {
          imageProvider.addImageData(imageModel(
            id: jsonData[i]['id'].toString(),
            albumId: jsonData[i]['albumId'].toString(),
            url: jsonData[i]['url'].toString(),
            thumbnailUrl: jsonData[i]['thumbnailUrl'].toString(),
            title: jsonData[i]['title'].toString(),
            uniqueId: jsonData[i]['id'].toString() +
                jsonData[i]['albumId'].toString() +
                jsonData[i]['url'].toString() +
                DateTime.now().millisecondsSinceEpoch.toString(),
          ));
        }

        setState(() {
          _currentPage++;
          _isLoading = false;
        });
      }
    } else {
      _fetchImages(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<PhotoProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/logo_icon.jpeg',
              fit: BoxFit.fitHeight,
              height: 40,
            ),
          ),
          actions: [
            IconButton(
                onPressed: (() {
                  multigrid = !multigrid;
                  if (multigrid) {
                    columnCount = 3;
                  } else {
                    columnCount = 2;
                  }
                  setState(() {});
                }),
                icon: Icon(
                  multigrid ? Icons.grid_view : Icons.grid_on,
                  size: 25,
                  color: Colors.black,
                ))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: (() => _fetchImages(true)),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                initial = false;
                _fetchImages(initial);
                return true;
              }
              return false;
            },
            child: GridView.count(
              padding: const EdgeInsets.only(top: 10),
              crossAxisCount: columnCount,
              children: imageProvider.imageList.map((image) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullScreenImage(
                            imageUrl: image.url.toString(),
                            title: image.title.toString(),
                            uniqueId: image.uniqueId.toString(),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: image.uniqueId.toString(),
                      child: CachedNetworkImage(
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.fill,
                        imageUrl: image.thumbnailUrl.toString(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
