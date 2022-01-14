import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:task/constants.dart';
import 'package:task/services/firebase_api.dart';
import 'package:path/path.dart';

class EditPageProvider extends ChangeNotifier{
  File imageFile;

  Future<Null> cropImage(String sourcePath) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: sourcePath,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        maxWidth: 512,
        maxHeight: 512,
        aspectRatioPresets: Platform.isAndroid
        ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
        ]
        : [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: kCropper,
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: kCropper,
        ));

    if (croppedFile != null) {
      imageFile = croppedFile;
    }
    notifyListeners();
  }

  Future <void> clearImage() {
    imageFile = null;
    notifyListeners();
  }

  Future uploadFile(File file, UploadTask task) async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    super.notifyListeners();

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

}
