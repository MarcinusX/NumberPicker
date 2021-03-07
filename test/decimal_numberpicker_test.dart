import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  testWidgets('Decimal small scroll up works', (WidgetTester tester) async {
    await _testNumberPicker(
        tester: tester,
        minValue: 1,
        maxValue: 10,
        decimalPlaces: 1,
        initialValue: 5.0,
        scrollByInt: 2,
        scrollByDecimal: 3,
        expectedValue: 7.3);
  });
}

Future<DecimalNumberPicker> _testNumberPicker({
  required WidgetTester tester,
  required int minValue,
  required int maxValue,
  required double initialValue,
  required int scrollByInt,
  required int scrollByDecimal,
  int decimalPlaces = 1,
  required double expectedValue,
}) async {
  double value = initialValue;
  late DecimalNumberPicker picker;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      picker = DecimalNumberPicker(
        value: value,
        minValue: minValue,
        maxValue: maxValue,
        decimalPlaces: decimalPlaces,
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

  await _scrollNumberPicker(Offset(0.0, 0.0), tester, scrollByInt, true);
  await tester.pumpAndSettle();

  await _scrollNumberPicker(Offset(0.0, 0.0), tester, scrollByDecimal, false);
  await tester.pumpAndSettle();
  expect(value, equals(expectedValue));
  return picker;
}

_scrollNumberPicker(Offset pickerPosition, WidgetTester tester, int scrollBy,
    bool integer) async {
  Offset pickerCenter = Offset(
    pickerPosition.dx + (integer ? 300.0 : 400.0),
    pickerPosition.dy + 1.5 * 50,
  );
  final TestGesture testGesture = await tester.startGesture(pickerCenter);
  await testGesture.moveBy(Offset(
    0.0,
    -scrollBy * 50.0,
  ));
}
