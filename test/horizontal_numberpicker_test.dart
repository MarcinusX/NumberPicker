import 'package:flutter/widgets.dart';
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
      axis: Axis.horizontal,
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
      axis: Axis.horizontal,
    );
  });

  testWidgets('Integer overscroll up to max value',
      (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 1,
      maxValue: 5,
      initialValue: 3,
      scrollBy: 10,
      expectedValue: 5,
      axis: Axis.horizontal,
    );
  });

  testWidgets('Integer overscroll down to min value',
      (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 1,
      maxValue: 5,
      initialValue: 3,
      scrollBy: -10,
      expectedValue: 1,
      axis: Axis.horizontal,
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
      axis: Axis.horizontal,
    );
  });

  testWidgets('Step cuts max value', (WidgetTester tester) async {
    await testNumberPicker(
      tester: tester,
      minValue: 0,
      maxValue: 5,
      step: 3,
      initialValue: 0,
      scrollBy: 3,
      expectedValue: 3,
      axis: Axis.horizontal,
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
      axis: Axis.horizontal,
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
      axis: Axis.horizontal,
    );
  });
}
