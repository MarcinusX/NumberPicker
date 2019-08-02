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
      expectedValue: 7,
      infiniteLoop: true,
    );
  });

  testWidgets('Integer small scroll down works', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 1,
      maxValue: 10,
      initialValue: 5,
      scrollBy: -2,
      expectedValue: 3,
      infiniteLoop: true,
    );
  });

  testWidgets('Integer overscroll over max value', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 1,
      maxValue: 5,
      initialValue: 5,
      scrollBy: 1,
      expectedValue: 1,
      infiniteLoop: true,
    );
  });

  testWidgets('Integer overscroll under min value',
      (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 1,
      maxValue: 5,
      initialValue: 1,
      scrollBy: -1,
      expectedValue: 5,
      infiniteLoop: true,
    );
  });

  testWidgets('Step works', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 0,
      maxValue: 6,
      step: 3,
      initialValue: 0,
      scrollBy: 2,
      expectedValue: 6,
      infiniteLoop: true,
    );
  });

  testWidgets('Step cuts max value', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 0,
      maxValue: 5,
      step: 3,
      initialValue: 0,
      scrollBy: 2,
      expectedValue: 0,
      infiniteLoop: true,
    );
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
      animateToItself: true,
      infiniteLoop: true,
    );
  });

  testWidgets('Force animate works', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 10,
      maxValue: 50,
      initialValue: 10,
      scrollBy: 13,
      expectedValue: 23,
      animateToItself: true,
      infiniteLoop: true,
    );
  });

  testWidgets('Zero pad works', (WidgetTester tester) async {
    await testMultipleValuesInPicker(
        tester: tester,
        minValue: 0,
        maxValue: 10,
        initialValue: 9,
        zeroPad: true,
        scrollBy: 1,
        infiniteLoop: true,
        expectedDisplayValues: ['09', '10', '00']);
  });

  testWidgets('Decorated number picker works', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 0,
      maxValue: 10,
      initialValue: 2,
      scrollBy: 2,
      expectedValue: 4,
      infiniteLoop: true,
      highlightSelectedValue: false,
      decoration: decoration,
    );
  });
}
