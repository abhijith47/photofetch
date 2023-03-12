import 'package:flutter/material.dart';
import 'package:photofetch/models/imageModel.dart';

//creating a provider for image class
class PhotoProvider with ChangeNotifier {
  imageModel _imageData = imageModel();
  List<imageModel> imageList = [];

  List<imageModel> get imageData {
    return imageList;
  }

  void addImageData(imageModel obj) {
    // To add image to provider list
    _imageData = obj;
    imageList.add(_imageData);
    notifyListeners();
  }

  void removeItem(docId) {
    // Removing particular image from list
    imageList.removeWhere((item) => item.id == docId);

    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
