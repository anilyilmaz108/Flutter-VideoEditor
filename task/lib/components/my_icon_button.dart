import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  MyIconButton({@required this.icon, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: Colors.white,
    );
  }
}