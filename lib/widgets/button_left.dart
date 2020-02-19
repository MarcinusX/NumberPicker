import 'package:flutter/material.dart';

class ButtonLeft extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final Function onLongPress;

  const ButtonLeft({
    Key key,
    this.width = 80.0,
    this.height = 80.0,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(Icons.remove, color: Colors.black54, size: 46.0,),
      onPressed: onPressed,
      onLongPress: onLongPress,
      elevation: 1.0,
      constraints: BoxConstraints.tightFor(
        width: width,
        height: height,
      ),
      shape: CircleBorder(),
      fillColor: Colors.lightBlue,
    );
  }
}
