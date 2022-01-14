import 'package:flutter/material.dart';

class MyImageWidget extends StatelessWidget {
  final Function onChanged;
  final bool value;
  MyImageWidget({this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.greenAccent,
              ),
            ),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ],

      ),
    );
  }
}