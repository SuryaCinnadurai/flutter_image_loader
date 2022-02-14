import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  List<String> imageUrls = <String>[].obs;
  List<Widget> images = <Widget>[].obs;
  int loadingIndex = 0;

  @override
  void onClose() {
    imageUrls.clear();
    images.clear();
    loadingIndex = 0;
    super.onClose();
  }

  void fetchDataFromApi(Uri uri) async {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var dat = jsonData['hits'];
      for (int i = 0; i < dat.length; i++) {
        imageUrls.add(dat[i]['webformatURL']);
      }

      loadMoreImages();
    } else {
      throw Exception('Failed to load json');
    }
  }

  void loadMoreImages() async {
    if (loadingIndex + 6 < imageUrls.length - 1) {
      await Future.delayed(const Duration(seconds: 2));
      for (int i = loadingIndex; i < loadingIndex + 6; i++) {
        images.add(
          Image.network(
            imageUrls[i],
            fit: BoxFit.fill,
          ),
        );
      }

      loadingIndex += 6;
    } else {
      if (loadingIndex != imageUrls.length - 1) {
        await Future.delayed(const Duration(seconds: 2));
        for (int i = loadingIndex; i < imageUrls.length; i++) {
          images.add(
            Image.network(
              imageUrls[i],
              fit: BoxFit.fill,
            ),
          );
        }
      }

      loadingIndex = imageUrls.length - 1;
    }
  }
}
