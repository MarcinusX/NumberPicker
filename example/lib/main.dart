import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'NumberPicker Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'NumberPicker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;
  int _currentInfIntValue = 10;
  int _currentInfIntValueDecorated = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker integerNumberPicker;
  NumberPicker horizontalNumberPicker;
  NumberPicker integerInfiniteNumberPicker;
  NumberPicker integerInfiniteDecoratedNumberPicker;
  NumberPicker decimalNumberPicker;

  Decoration _decoration = new BoxDecoration(
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

  @override
  Widget build(BuildContext context) {
    _initializeNumberPickers();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Integer'),
              Tab(text: 'Decimal'),
              Tab(text: 'Infinite loop'),
            ],
          ),
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                SizedBox(height: 16),
                Text('Default', style: Theme.of(context).textTheme.title),
                integerNumberPicker,
                new RaisedButton(
                  onPressed: () => _showIntDialog(),
                  child: new Text("Current int value: $_currentIntValue"),
                ),
                Divider(color: Colors.grey, height: 32),
                Text('Horizontal', style: Theme.of(context).textTheme.title),
                horizontalNumberPicker,
                Text(
                  "Current int value: $_currentHorizontalIntValue",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                decimalNumberPicker,
                new RaisedButton(
                  onPressed: () => _showDoubleDialog(),
                  child: new Text("Current double value: $_currentDoubleValue"),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 16),
                Text('Default', style: Theme.of(context).textTheme.title),
                integerInfiniteNumberPicker,
                new RaisedButton(
                  onPressed: () => _showInfIntDialog(),
                  child: new Text("Current int value: $_currentInfIntValue"),
                ),
                Divider(color: Colors.grey, height: 32),
                Text('Decorated', style: Theme.of(context).textTheme.title),
                integerInfiniteDecoratedNumberPicker,
                Text(
                  "Current int value: $_currentInfIntValueDecorated",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _initializeNumberPickers() {
    integerNumberPicker = new NumberPicker.integer(
      initialValue: _currentIntValue,
      minValue: 0,
      maxValue: 100,
      step: 10,
      onChanged: (value) => setState(() => _currentIntValue = value),
    );
    horizontalNumberPicker = new NumberPicker.horizontal(
      initialValue: _currentHorizontalIntValue,
      minValue: 0,
      maxValue: 100,
      step: 10,
      zeroPad: true,
      onChanged: (value) => setState(() => _currentHorizontalIntValue = value),
    );
    integerInfiniteNumberPicker = new NumberPicker.integer(
      initialValue: _currentInfIntValue,
      minValue: 0,
      maxValue: 99,
      step: 10,
      infiniteLoop: true,
      onChanged: (value) => setState(() => _currentInfIntValue = value),
    );
    integerInfiniteDecoratedNumberPicker = new NumberPicker.integer(
      initialValue: _currentInfIntValueDecorated,
      minValue: 0,
      maxValue: 99,
      step: 10,
      infiniteLoop: true,
      highlightSelectedValue: false,
      decoration: _decoration,
      onChanged: (value) =>
          setState(() => _currentInfIntValueDecorated = value),
    );
    decimalNumberPicker = new NumberPicker.decimal(
      initialValue: _currentDoubleValue,
      minValue: 1,
      maxValue: 5,
      decimalPlaces: 2,
      onChanged: (value) => setState(() => _currentDoubleValue = value),
    );
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          step: 10,
          initialIntegerValue: _currentIntValue,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      }
    });
  }

  Future _showInfIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 99,
          step: 10,
          initialIntegerValue: _currentInfIntValue,
          infiniteLoop: true,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _currentInfIntValue = value);
        integerInfiniteNumberPicker.animateInt(value);
      }
    });
  }

  Future _showDoubleDialog() async {
    var value = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          maxText: "kg",
          minText: "wh",
          minValue: 1,
          maxValue: 5,
          decimalPlaces: 2,
          initialDoubleValue: _currentDoubleValue,
          title: new Text("Pick a decimal number"),
        );
      },
    );
    if (value != null) {
      setState(() => _currentDoubleValue = value);
      decimalNumberPicker.animateDecimalAndInteger(value);
    }
  }
}
