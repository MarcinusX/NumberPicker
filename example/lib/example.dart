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
  int _currentInfIntValue = 10;
  double _currentDoubleValue = 3.0;
  NumberPicker integerNumberPicker;
  NumberPicker integerInfiniteNumberPicker;
  NumberPicker decimalNumberPicker;

  @override
  Widget build(BuildContext context) {
    integerNumberPicker = new NumberPicker.integer(
      initialValue: _currentIntValue,
      minValue: 0,
      maxValue: 100,
      step: 10,
      onChanged: (value) => setState(() => _currentIntValue = value),
    );
    integerInfiniteNumberPicker = new NumberPicker.integer(
      initialValue: _currentInfIntValue,
      minValue: 0,
      maxValue: 99,
      step: 10,
      infiniteLoop: true,
      onChanged: (value) => setState(() => _currentInfIntValue = value),
    );
    decimalNumberPicker = new NumberPicker.decimal(
      initialValue: _currentDoubleValue,
      minValue: 1,
      maxValue: 5,
      decimalPlaces: 2,
      onChanged: (value) => setState(() => _currentDoubleValue = value),
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Row(children: <Widget>[
            Expanded(
              child: Column(children: <Widget>[
                Text("Default"),
                integerNumberPicker,
                new RaisedButton(
                  onPressed: () => _showIntDialog(),
                  child: new Text("Current int value: $_currentIntValue"),
                ),
              ]),
            ),
            Expanded(
              child: Column(children: <Widget>[
                Text("With infinite loop"),
                integerInfiniteNumberPicker,
                new RaisedButton(
                  onPressed: () => _showInfIntDialog(),
                  child: new Text("Current int value: $_currentInfIntValue"),
                ),
              ]),
            ),
          ]),
          decimalNumberPicker,
          new RaisedButton(
            onPressed: () => _showDoubleDialog(),
            child: new Text("Current double value: $_currentDoubleValue"),
          ),
        ],
      ),
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
    await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 5,
          decimalPlaces: 2,
          initialDoubleValue: _currentDoubleValue,
          title: new Text("Pick a decimal number"),
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _currentDoubleValue = value);
        decimalNumberPicker.animateInt(value);
      }
    });
  }
}
