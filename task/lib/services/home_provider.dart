import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:export_video_frame/export_video_frame.dart';

class HomeProvider extends ChangeNotifier{
  List<Image> images = [];

  bool isClean = false;
  ImagePicker picker = ImagePicker();
  Stream<File> imagesStream;

  Future combinedFunction() async {
    if (isClean) {
      await cleanCache();
      notifyListeners();
    } else {
      await getImagesByTime();
      notifyListeners();
    }
    notifyListeners();
  }

  Future getImagesByTime() async {
    final XFile file = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 10));
    imagesStream = ExportVideoFrame.exportImagesFromFile(
      File(file.path),
      const Duration(milliseconds: 1200),
      pi / 130,
    );

    addListener(() {
      isClean = true;
    });

    imagesStream.listen((image) {
      images.add(Image.file(image));
      super.notifyListeners();
    });

    notifyListeners();

  }

  Future cleanCache() async {
    addListener(() {
      images.clear();
      isClean = false;
    });
    notifyListeners();
  }



}