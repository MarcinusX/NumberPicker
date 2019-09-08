import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';

Decoration decoration = new BoxDecoration(
  border: new Border(
    top: new BorderSide(
      style: BorderStyle.solid,
      color: Colors.black26,
    ),
    bottom: new BorderSide(
      style: BorderStyle.solid,
      color: Colors.black26,
    ),
  ),
);

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
  bool infiniteLoop = false,
  Decoration decoration,
  bool highlightSelectedValue = true,
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
              infiniteLoop: infiniteLoop,
              decoration: decoration,
              highlightSelectedValue: highlightSelectedValue,
              onChanged: (newValue) => setState(() => value = newValue),
            )
          : NumberPicker.horizontal(
              initialValue: value,
              minValue: minValue,
              maxValue: maxValue,
              step: step,
              decoration: decoration,
              highlightSelectedValue: highlightSelectedValue,
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

  await scrollNumberPicker(Offset(0.0, 0.0), tester, scrollBy, axis);
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

Future<NumberPicker> testMultipleValuesInPicker({
  WidgetTester tester,
  int minValue,
  int maxValue,
  int initialValue,
  int scrollBy,
  int step = 1,
  bool animateToItself = false,
  Axis axis = Axis.vertical,
  bool zeroPad = false,
  List<String> expectedDisplayValues,
  bool infiniteLoop = false,
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
              infiniteLoop: infiniteLoop,
              onChanged: (newValue) => setState(() => value = newValue),
              zeroPad: zeroPad,
            )
          : NumberPicker.horizontal(
              initialValue: value,
              minValue: minValue,
              maxValue: maxValue,
              step: step,
              zeroPad: zeroPad,
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

  await scrollNumberPicker(Offset(0, 0), tester, scrollBy, axis);
  await tester.pumpAndSettle();

  for (String displayValue in expectedDisplayValues) {
    expect(find.text(displayValue), findsOneWidget);
  }

  return picker;
}

scrollNumberPicker(
  Offset pickerPosition,
  WidgetTester tester,
  int scrollBy,
  Axis axis,
) async {
  double pickerCenterX, pickerCenterY, offsetX, offsetY;
  double pickerCenterMainAxis = 1.5 * NumberPicker.kDefaultItemExtent;
  double pickerCenterCrossAxis = NumberPicker.kDefaultListViewCrossAxisSize / 2;
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
