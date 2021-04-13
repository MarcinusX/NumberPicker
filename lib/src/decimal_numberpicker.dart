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
  final TextMapper? integerTextMapper;
  final TextMapper? decimalTextMapper;
  final bool integerZeroPad;

  /// Decoration to apply to central box where the selected integer value is placed
  final Decoration? integerDecoration;

  /// Decoration to apply to central box where the selected decimal value is placed
  final Decoration? decimalDecoration;

  /// Inidcates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
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
    this.integerTextMapper,
    this.decimalTextMapper,
    this.integerZeroPad = false,
    this.integerDecoration,
    this.decimalDecoration,
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
          itemCount: itemCount,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          textStyle: textStyle,
          selectedTextStyle: selectedTextStyle,
          haptics: haptics,
          zeroPad: integerZeroPad,
          textMapper: integerTextMapper,
          decoration: integerDecoration,
        ),
        NumberPicker(
          minValue: 0,
          maxValue: doubleMaxValue,
          value: decimalValue,
          onChanged: _onDoubleChanged,
          itemCount: itemCount,
          itemHeight: itemHeight,
          itemWidth: itemWidth,
          textStyle: textStyle,
          selectedTextStyle: selectedTextStyle,
          haptics: haptics,
          textMapper: decimalTextMapper,
          decoration: decimalDecoration,
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
