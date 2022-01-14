import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/components/floating_button_widget.dart';
import 'package:task/constants.dart';
import 'package:task/models/image_model.dart';
import 'package:task/services/edit_page_provider.dart';

class EditPageView extends StatefulWidget {
  ImageModel _imageModel;
  EditPageView(this._imageModel);

  @override
  _EditPageViewState createState() => _EditPageViewState();
}

enum AppState {
  _free,
  _picked,
  _cropped,
}

class _EditPageViewState extends State<EditPageView> {
  AppState _state = AppState._picked;
  File _imageFile;
  UploadTask _task;
  File _file;

  @override
  Widget build(BuildContext context) {
    String sourcePath = "${widget._imageModel.image.image.toString().substring(11,92)}";
    return Consumer<EditPageProvider>(
        builder: (context,itemData,child)=>Scaffold(
          appBar: AppBar(
          ),
          body: Center(
            child: _imageFile != null ? Image.file(_imageFile) : Container(
              child: Text(kEditPageTitle)
            ),
          ),
          floatingActionButton: FloatingButtonWidget(
            onClicked: ()async {
              if (_state == AppState._free){
                itemData.clearImage();
                setState(() {
                  _imageFile = itemData.imageFile;
                  _state = AppState._picked;
                });
              }

              else if (_state == AppState._picked) {
                itemData.cropImage(sourcePath).whenComplete(() {
                  setState(() {
                    _imageFile = itemData.imageFile;
                    _state = AppState._cropped;
                  });
                });
              }

              else if (_state == AppState._cropped){
                setState(() => _file = File(itemData.imageFile.path));
                itemData.uploadFile(_file, _task);
                setState(() => _state = AppState._free);
              }
            },
            child: _buildButtonIcon(_state),
          ),
        )
    );
  }

  Widget _buildButtonIcon(AppState state) {
    if (state == AppState._free)
      return Icon(Icons.delete);
    else if (state == AppState._picked)
      return Icon(Icons.crop);
    else if (state == AppState._cropped)
      return Icon(Icons.upload_file);
    else
      return Container();
  }


}
