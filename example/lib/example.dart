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
  double _currentDoubleValue = 3.0;
  NumberPicker integerNumberPicker;
  NumberPicker decimalNumberPicker;

  _handleValueChanged(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
      } else {
        setState(() => _currentDoubleValue = value);
      }
    }
  }

  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      } else {
        setState(() => _currentDoubleValue = value);
        decimalNumberPicker.animateDecimalAndInteger(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    integerNumberPicker = new NumberPicker.integer(
      initialValue: _currentIntValue,
      minValue: 0,
      maxValue: 100,
      onChanged: _handleValueChanged,
    );
    decimalNumberPicker = new NumberPicker.decimal(
        initialValue: _currentDoubleValue,
        minValue: 1,
        maxValue: 5,
        decimalPlaces: 2,
        onChanged: _handleValueChanged);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              integerNumberPicker,
              new RaisedButton(
                onPressed: () => _showIntDialog(),
                child: new Text("Current int value: $_currentIntValue"),
              ),
              decimalNumberPicker,
              new RaisedButton(
                onPressed: () => _showDoubleDialog(),
                child: new Text("Current double value: $_currentDoubleValue"),
              ),
            ],
          ),
        ));
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          initialIntegerValue: _currentIntValue,
        );
      },
    ).then(_handleValueChangedExternally);
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
    ).then(_handleValueChangedExternally);
  }
}
