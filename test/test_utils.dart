import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';

Future<NumberPicker> testNumberPicker({
  WidgetTester tester,
  int minValue,
  int maxValue,
  int initialValue,
  int scrollBy,
  int step = 1,
  int expectedValue,
  bool animateToItself = false,
  Axis axis = Axis.vertical,
}) async {
  int value = initialValue;
  NumberPicker picker;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      picker = axis == Axis.vertical
          ? picker = NumberPicker.integer(
              initialValue: value,
              minValue: minValue,
              maxValue: maxValue,
              step: step,
              onChanged: (newValue) => setState(() => value = newValue),
            )
          : NumberPicker.horizontal(
              initialValue: value,
              minValue: minValue,
              maxValue: maxValue,
              step: step,
              onChanged: (newValue) => setState(() => value = newValue),
            );
      return MaterialApp(
        home: Scaffold(
          body: picker,
        ),
      );
    }),
  );
  expect(value, equals(initialValue));

  await _scrollNumberPicker(Offset(0.0, 0.0), tester, scrollBy, axis);
  await tester.pumpAndSettle();

  expect(value, equals(expectedValue));

  if (animateToItself) {
    expect(picker.selectedIntValue, equals(expectedValue));
    await picker.animateInt(picker.selectedIntValue);
    await tester.pumpAndSettle();
    expect(picker.selectedIntValue, equals(expectedValue));
  }
  return picker;
}

_scrollNumberPicker(
  Offset pickerPosition,
  WidgetTester tester,
  int scrollBy,
  Axis axis,
) async {
  double pickerCenterX, pickerCenterY, offsetX, offsetY;
  double pickerCenterMainAxis = 1.5 * NumberPicker.kDefaultItemExtent;
  double pickerCenterCrossAxis =
      NumberPicker.kDefaultListViewCrossAxisSize / 2;
  if (axis == Axis.vertical) {
    pickerCenterX = pickerCenterCrossAxis;
    pickerCenterY = pickerCenterMainAxis;
    offsetX = 0.0;
    offsetY = -scrollBy * NumberPicker.kDefaultItemExtent;
  } else {
    pickerCenterX = pickerCenterMainAxis;
    pickerCenterY = pickerCenterCrossAxis;
    offsetX = -scrollBy * NumberPicker.kDefaultItemExtent;
    offsetY = 0.0;
  }
  Offset pickerCenter = Offset(
    pickerPosition.dx + pickerCenterX,
    pickerPosition.dy + pickerCenterY,
  );
  final TestGesture testGesture = await tester.startGesture(pickerCenter);
  await testGesture.moveBy(Offset(
    offsetX,
    offsetY,
  ));
}
