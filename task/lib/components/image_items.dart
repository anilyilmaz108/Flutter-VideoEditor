import 'package:flutter/material.dart';
import 'package:task/models/image_model.dart';
import 'package:task/views/edit_page_view.dart';

class ImageItem extends StatelessWidget {
  ImageItem({this.image}) : super(key: ObjectKey(image));
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPageView(
                ImageModel(image: image)
            )));
          },
          child: image
      ),
    );
  }
}