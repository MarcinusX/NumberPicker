import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  // This widget is the root of your application.
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
  double _currentDoubleValue = 5.5;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new RaisedButton(
                onPressed: () => _showIntDialog(),
                child: new Text("Current int value: $_currentIntValue"),
              ),
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
      child: new SimpleDialog(
        children: [
          new NumberPicker.integer(initialValue: 50,
            minValue: 1,
            maxValue: 100,
            confirmText: "CONFIRM",)
        ],
        title: new Text("Integer NumberPicker"),
      ),
    ).then((value) {
      if (value != null) {
        setState(() => _currentIntValue = value);
      }
    });
  }

  Future _showDoubleDialog() async {
    await showDialog<double>(
      context: context,
      child: new SimpleDialog(
        children: [
          new NumberPicker.decimal(
            minValue: 1,
            maxValue: 10,
            initialValue: _currentDoubleValue,
            decimalPlaces: 2,
          ),
        ],
        title: new Text("Decimal NumberPicker"),
      ),
    ).then((value) {
      if (value != null) {
        setState(() => _currentDoubleValue = value);
      }
    });
  }

}
