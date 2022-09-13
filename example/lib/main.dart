import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPicker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Integer'),
              Tab(text: 'Decimal'),
            ],
          ),
          title: Text('Numberpicker example'),
        ),
        body: TabBarView(
          children: [
            _IntegerExample(),
            _DecimalExample(),
          ],
        ),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 16),
        Text('Default', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentIntValue,
          minValue: 1,
          maxValue: 10,
          step: 1,
          haptics: true,
          itemCount: 10,
          infiniteLoop: true,
          itemHeight: 40,
          itemWidth: 56,
          selectedTextStyle: TextStyle(color: Color(0xFF3B5B6A), fontSize: 18),
          textStyle: TextStyle(color: Color(0xFF7A909F), fontSize: 14),
          onChanged: (value) => setState(() => _currentIntValue = value),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentIntValue - 1;
                _currentIntValue = newValue.clamp(1, 10);
              }),
            ),
            Text('Current int value: $_currentIntValue'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentIntValue + 1;
                _currentIntValue = newValue.clamp(1, 10);
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecimalExample extends StatefulWidget {
  @override
  __DecimalExampleState createState() => __DecimalExampleState();
}

class __DecimalExampleState extends State<_DecimalExample> {
  double _currentDoubleValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Decimal', style: Theme.of(context).textTheme.headline6),
        DecimalNumberPicker(
          value: _currentDoubleValue,
          minValue: 0,
          maxValue: 10,
          decimalPlaces: 2,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
