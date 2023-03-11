
import 'package:flutter/material.dart';
import 'package:photofetch/models/imageModel.dart';

class PhotoProvider with ChangeNotifier {
  imageModel _imageData = imageModel();
  List<imageModel> imageList = [];

  List<imageModel> get imageData {
    return imageList;
  }

  void addImageData(imageModel obj) {
    _imageData = obj;
    imageList.add(_imageData);
    notifyListeners();
  }

  void removeItem(docId) {
    imageList.removeWhere((item) => item.id == docId);

    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
