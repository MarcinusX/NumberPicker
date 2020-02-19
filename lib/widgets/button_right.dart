import 'package:flutter/material.dart';

class ButtonRight extends StatelessWidget {
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final Function onLongPress;

  const ButtonRight({
    Key key,
    this.gradient,
    this.width = 80.0,
    this.height = 80.0,
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(Icons.add, color: Colors.white, size: 46.0,),
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
