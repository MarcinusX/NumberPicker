# NumberPicker [![Build Status](https://travis-ci.org/MarcinusX/NumberPicker.svg?branch=master)](https://travis-ci.org/MarcinusX/NumberPicker) [![Coverage Status](https://coveralls.io/repos/github/MarcinusX/NumberPicker/badge.svg?branch=master)](https://coveralls.io/github/MarcinusX/NumberPicker?branch=CI)

NumberPicker is a custom widget designed for choosing an integer or decimal number by scrolling spinners.

![ezgif com-gif-maker](https://user-images.githubusercontent.com/16286046/110208631-aabb8480-7e88-11eb-8a92-4e77636965ce.gif)

## Example:
(See `example` for more)

```dart
class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentValue = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          value: _currentValue,
          minValue: 0,
          maxValue: 100,
          onChanged: (value) => setState(() => _currentValue = value),
        ),
        Text('Current value: $_currentValue'),
      ],
    );
  }
}
```
