import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  testWidgets('Integer small scroll up works', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 10,
        initialValue: 5,
        scrollBy: 2,
        expectedValue: 7);
  });

  testWidgets('Integer small scroll down works', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 10,
        initialValue: 5,
        scrollBy: -2,
        expectedValue: 3);
  });

  testWidgets('Integer overscroll up to max value',
      (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 5,
        initialValue: 3,
        scrollBy: 10,
        expectedValue: 5);
  });

  testWidgets('Integer overscroll down to min value',
      (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 5,
        initialValue: 3,
        scrollBy: -10,
        expectedValue: 1);
  });
}

_testNumberPicker(
    {WidgetTester tester,
    int minValue,
    int maxValue,
    int initialValue,
    int scrollBy,
    int expectedValue}) async {
  int value = initialValue;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return MaterialApp(
        home: Scaffold(
          body: NumberPicker.integer(
            initialValue: value,
            minValue: minValue,
            maxValue: maxValue,
            onChanged: (newValue) => setState(() => value = newValue),
          ),
        ),
      );
    }),
  );
  expect(value, equals(initialValue));

  await _scrollNumberPicker(Offset(0.0, 0.0), tester, scrollBy);

  expect(value, equals(expectedValue));
}

_scrollNumberPicker(
    Offset pickerPosition, WidgetTester tester, int scrollBy) async {
  Offset pickerCenter = Offset(
    pickerPosition.dx + NumberPicker.DEFUALT_LISTVIEW_WIDTH / 2,
    pickerPosition.dy + 1.5 * NumberPicker.DEFAULT_ITEM_EXTENT,
  );
  final TestGesture testGesture = await tester.startGesture(pickerCenter);
  await testGesture.moveBy(Offset(
    0.0,
    -scrollBy * NumberPicker.DEFAULT_ITEM_EXTENT,
  ));
}
