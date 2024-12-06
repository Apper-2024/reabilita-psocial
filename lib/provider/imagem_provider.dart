import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageProviderCustom with ChangeNotifier {
  static final ImageProviderCustom _instance = ImageProviderCustom._internal();

  ImageProviderCustom._internal();

  static ImageProviderCustom get instance => _instance;

  final List<Uint8List> _images = [];

  List<Uint8List>? get images => _images;
  
  void addImage(Uint8List image) {
    _images.add(image);
    notifyListeners();
  }
}
