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

  testWidgets('Integer overscroll over max value', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 5,
        initialValue: 5,
        scrollBy: 1,
        expectedValue: 1);
  });

  testWidgets('Integer overscroll under min value', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 5,
        initialValue: 1,
        scrollBy: -1,
        expectedValue: 5);
  });

  testWidgets('Step works', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 0,
        maxValue: 6,
        step: 3,
        initialValue: 0,
        scrollBy: 2,
        expectedValue: 6);
  });

  testWidgets('Step cuts max value', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 0,
        maxValue: 5,
        step: 3,
        initialValue: 0,
        scrollBy: 2,
        expectedValue: 0);
  });

  testWidgets('Min value==step, force animate', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 10,
        maxValue: 50,
        step: 10,
        initialValue: 10,
        scrollBy: 2,
        expectedValue: 30,
        animateToItself: true);
  });

  testWidgets('Force animate works', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 10,
        maxValue: 50,
        initialValue: 10,
        scrollBy: 13,
        expectedValue: 23,
        animateToItself: true);
  });
}

Future<NumberPicker> _testNumberPicker(
    {WidgetTester tester,
    int minValue,
    int maxValue,
    int initialValue,
    int scrollBy,
    int step = 1,
    int expectedValue,
    bool animateToItself = false}) async {
  int value = initialValue;
  NumberPicker picker;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      picker = NumberPicker.integer(
        initialValue: value,
        minValue: minValue,
        maxValue: maxValue,
        step: step,
        infiniteLoop: true,
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

  await _scrollNumberPicker(Offset(0.0, 0.0), tester, scrollBy);
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
    Offset pickerPosition, WidgetTester tester, int scrollBy) async {
  Offset pickerCenter = Offset(
    pickerPosition.dx + NumberPicker.DEFAULT_LISTVIEW_WIDTH / 2,
    pickerPosition.dy + 1.5 * NumberPicker.DEFAULT_ITEM_EXTENT,
  );
  final TestGesture testGesture = await tester.startGesture(pickerCenter);
  await testGesture.moveBy(Offset(
    0.0,
    -scrollBy * NumberPicker.DEFAULT_ITEM_EXTENT,
  ));
}
