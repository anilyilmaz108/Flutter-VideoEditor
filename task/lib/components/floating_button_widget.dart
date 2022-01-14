import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final Widget child;

  const FloatingButtonWidget({
    Key key,
    @required this.onClicked, this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
    backgroundColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 2, color: Colors.blue),
      borderRadius: BorderRadius.circular(30),
    ),
    child: child,
    onPressed: onClicked,
  );
}