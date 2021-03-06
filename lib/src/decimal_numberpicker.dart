import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'numberpicker.dart';

class DecimalNumberPicker extends StatelessWidget {
  final int minValue;
  final int maxValue;
  final double value;
  final ValueChanged<double> onChanged;
  final int itemCount;
  final double itemHeight;
  final double itemWidth;
  final Axis axis;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final bool haptics;
  final int decimalPlaces;

  const DecimalNumberPicker({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
    this.itemCount = 3,
    this.itemHeight = 50,
    this.itemWidth = 100,
    this.axis = Axis.vertical,
    this.textStyle,
    this.selectedTextStyle,
    this.haptics = false,
    this.decimalPlaces = 1,
  })  : assert(minValue <= value),
        assert(value <= maxValue),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMax = value.floor() == maxValue;
    final decimalValue = isMax
        ? 0
        : ((value - value.floorToDouble()) * math.pow(10, decimalPlaces))
            .round();
    final doubleMaxValue = isMax ? 0 : math.pow(10, decimalPlaces).toInt() - 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberPicker(
          minValue: minValue,
          maxValue: maxValue,
          value: value.floor(),
          onChanged: _onIntChanged,
        ),
        NumberPicker(
          minValue: 0,
          maxValue: doubleMaxValue,
          value: decimalValue,
          onChanged: _onDoubleChanged,
        ),
      ],
    );
  }

  void _onIntChanged(int intValue) {
    final newValue =
        (value - value.floor() + intValue).clamp(minValue, maxValue);
    onChanged(newValue.toDouble());
  }

  void _onDoubleChanged(int doubleValue) {
    final decimalPart = double.parse(
        (doubleValue * math.pow(10, -decimalPlaces))
            .toStringAsFixed(decimalPlaces));
    onChanged(value.floor() + decimalPart);
  }
}
