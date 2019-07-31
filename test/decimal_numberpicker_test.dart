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

Future<NumberPicker> _testNumberPicker(
    {WidgetTester tester,
    int minValue,
    int maxValue,
    double initialValue,
    int scrollByInt,
    int scrollByDecimal,
    int decimalPlaces = 1,
    double expectedValue,
    bool animateToItself = false}) async {
  double value = initialValue;
  NumberPicker picker;

  await tester.pumpWidget(
    StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      picker = NumberPicker.decimal(
        initialValue: value,
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

  if (animateToItself) {
    expect(picker.selectedIntValue, equals(expectedValue));
    await picker.animateInt(picker.selectedIntValue);
    await tester.pumpAndSettle();
    expect(picker.selectedIntValue, equals(expectedValue));
  }
  return picker;
}

_scrollNumberPicker(Offset pickerPosition, WidgetTester tester, int scrollBy,
    bool integer) async {
  Offset pickerCenter = Offset(
    pickerPosition.dx + (integer ? 300.0 : 400.0),
    pickerPosition.dy + 1.5 * NumberPicker.kDefaultItemExtent,
  );
  final TestGesture testGesture = await tester.startGesture(pickerCenter);
  await testGesture.moveBy(Offset(
    0.0,
    -scrollBy * 50.0,
  ));
}
