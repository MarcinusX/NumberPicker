import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

void main() {
  testWidgets('Integer small scroll up works', (WidgetTester tester) async {
    await testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 10,
        initialValue: 5,
        scrollBy: 2,
        expectedValue: 7);
  });

  testWidgets('Integer small scroll down works', (WidgetTester tester) async {
    await testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 10,
        initialValue: 5,
        scrollBy: -2,
        expectedValue: 3);
  });

  testWidgets('Integer overscroll up to max value',
      (WidgetTester tester) async {
    await testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 5,
        initialValue: 3,
        scrollBy: 10,
        expectedValue: 5);
  });

  testWidgets('Integer overscroll down to min value',
      (WidgetTester tester) async {
    await testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 5,
        initialValue: 3,
        scrollBy: -10,
        expectedValue: 1);
  });

  testWidgets('Step works', (WidgetTester tester) async {
    await testNumberPicker(
        tester: tester,
        minValue: 0,
        maxValue: 6,
        step: 3,
        initialValue: 0,
        scrollBy: 2,
        expectedValue: 6);
  });

  testWidgets('Step cuts max value', (WidgetTester tester) async {
    await testNumberPicker(
        tester: tester,
        minValue: 0,
        maxValue: 5,
        step: 3,
        initialValue: 0,
        scrollBy: 3,
        expectedValue: 3);
  });

  testWidgets('Min value==step, force animate', (WidgetTester tester) async {
    await testNumberPicker(
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
    await testNumberPicker(
        tester: tester,
        minValue: 10,
        maxValue: 50,
        initialValue: 10,
        scrollBy: 13,
        expectedValue: 23,
        animateToItself: true);
  });

  testWidgets('Zero pad works', (WidgetTester tester) async {
    await testMultipleValuesInPicker(
        tester: tester,
        minValue: 0,
        maxValue: 10,
        initialValue: 2,
        zeroPad: true,
        scrollBy: 1,
        expectedDisplayValues: ['02', '03', '04']);
  });

  testWidgets('Decorated number picker works', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 0,
      maxValue: 10,
      initialValue: 2,
      scrollBy: 2,
      expectedValue: 4,
      highlightSelectedValue: false,
      decoration: decoration,
    );
  });

  testWidgets('Text mapper works', (WidgetTester tester) async {
    await testMultipleValuesInPicker(
        tester: tester,
        minValue: 0,
        maxValue: 10,
        initialValue: 2,
        scrollBy: 1,
        textMapper: (text) => '$text days',
        expectedDisplayValues: ['2 days', '3 days', '4 days']);
  });

}
