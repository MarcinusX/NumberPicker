import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Created by Marcin Szałek

///NumberPicker is a widget designed to use inside of SimpleDialog
///It allows user to choose number between #minValue and %maxValue
class NumberPicker extends StatefulWidget {
  static const String defaultConfirmText = "OK";
  static const String defaultCancelText = "CANCEL";

  ///constructor for integer number picker
  factory NumberPicker.integer({
    Key key,
    @required int initialValue,
    @required int minValue,
    @required int maxValue,
    String confirmText = defaultConfirmText,
    String cancelText = defaultCancelText,
  }) {
    assert(initialValue != null);
    assert(minValue != null);
    assert(maxValue != null);
    assert(maxValue > minValue);
    assert(initialValue >= minValue && initialValue <= maxValue);
    return new NumberPicker._internal(
        minValue: minValue,
        maxValue: maxValue,
        initialIntValue: initialValue,
        initialDecimalValue: -1,
        decimalPlaces: 0,
        confirmText: confirmText,
        cancelText: cancelText,
        key: key);
  }

  ///constructor for decimal number picker
  factory NumberPicker.decimal({
    Key key,
    @required double initialValue,
    @required int minValue,
    @required int maxValue,
    @required int decimalPlaces,
    String confirmText = defaultConfirmText,
    String cancelText = defaultCancelText,
  }) {
    assert(initialValue != null);
    assert(minValue != null);
    assert(maxValue != null);
    assert(decimalPlaces != null && decimalPlaces > 0);
    assert(maxValue > minValue);
    assert(initialValue >= minValue && initialValue <= maxValue);
    return new NumberPicker._internal(
        minValue: minValue,
        maxValue: maxValue,
        initialIntValue: initialValue.floor(),

        ///the decimal part transformed to integer,
        ///e.g. initialValue = 7.26 => initialDecimalValue = 26
        initialDecimalValue: ((initialValue - initialValue.floorToDouble()) *
                pow(10, decimalPlaces))
            .floor(),
        decimalPlaces: decimalPlaces,
        confirmText: confirmText,
        cancelText: cancelText,
        key: key);
  }

  ///internal constructor
  NumberPicker._internal({
    Key key,
    @required this.minValue,
    @required this.maxValue,
    @required this.initialIntValue,
    @required this.initialDecimalValue,
    @required this.decimalPlaces,
    @required this.confirmText,
    @required this.cancelText,
  })
      : super(key: key);

  ///min value user can pick
  final int minValue;

  ///max value user can pick
  final int maxValue;

  ///initial integer value to be selected
  final int initialIntValue;

  ///initial decimal value to be selected
  final int initialDecimalValue;

  ///inidcates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  ///text to be displayed in confirmation button
  final String confirmText;

  ///text to be displayed in cancel button
  final String cancelText;

  @override
  _NumberPickerState createState() => new _NumberPickerState();
}

///State of NumberPicker
class _NumberPickerState extends State<NumberPicker> {
  ///height of every list element
  static const double _itemExtent = 50.0;

  ///view will always contain only 3 elements of list
  static const double _listViewHeight = 3 * (_itemExtent - 2.0);

  ///width of list view
  static const double _listViewWidth = 100.0;

  ///ScrollController used for integer list
  ScrollController intScrollController;

  ///ScrollController used for decimal list
  ScrollController decimalScrollController;

  ///Currently selected integer value
  int selectedIntValue;

  ///Currently selected decimal value
  int selectedDecimalValue;

  ///Default text style
  TextStyle _defaultStyle;

  ///Selected text style
  TextStyle _selectedStyle;

  @override
  void initState() {
    super.initState();

    //copy initial values
    selectedIntValue = widget.initialIntValue;
    selectedDecimalValue = widget.initialDecimalValue;

    //init scroll controllers
    intScrollController = new ScrollController(
      initialScrollOffset: (selectedIntValue - widget.minValue) * _itemExtent,
    );
    decimalScrollController = new ScrollController(
      initialScrollOffset: selectedDecimalValue * _itemExtent,
    );
  }

  //
  //----------------------------- VIEWS -----------------------------
  //

  ///main widget
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _defaultStyle = themeData.textTheme.body1;
    _selectedStyle = themeData.textTheme.headline
        .copyWith(color: themeData.accentColor);

    return new Column(
      children: <Widget>[
        _initMainView(themeData),
        _initBottomView(),
      ],
    );
  }

  ///creates one listview if in integer version
  ///or a row with two listviews if in decimal version
  Widget _initMainView(ThemeData themeData) {
    if (widget.decimalPlaces == 0) {
      return _integerListView(themeData);
    } else {
      return new Row(
        children: <Widget>[
          _integerListView(themeData),
          _decimalListView(themeData),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
    }
  }

  Widget _integerListView(ThemeData themeData) {
    int itemCount = widget.maxValue - widget.minValue + 3;

    return new NotificationListener(
      child: new Container(
        height: _listViewHeight,
        width: _listViewWidth,
        child: new ListView.builder(
          controller: intScrollController,
          itemExtent: _itemExtent,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            final int value = widget.minValue + index - 1;

            //define special style for selected (middle) element
            final TextStyle itemStyle = value == selectedIntValue
                ? _selectedStyle : _defaultStyle;

            bool isExtra = index == 0 || index == itemCount - 1;

            return isExtra
                ? new Container() //empty first and last element
                : new Center(
                    child: new Text(value.toString(), style: itemStyle),
                  );
          },
        ),
      ),
      onNotification: _onIntegerNotification,
    );
  }

  Widget _decimalListView(ThemeData themeData) {
    int itemCount = selectedIntValue == widget.maxValue
        ? 3
        : pow(10, widget.decimalPlaces) + 2;

    return new NotificationListener(
      child: new Container(
        height: _listViewHeight,
        width: _listViewWidth,
        child: new ListView.builder(
          controller: decimalScrollController,
          itemExtent: _itemExtent,
          itemCount: itemCount,
          itemBuilder: (BuildContext context, int index) {
            final int value = index - 1;

            //define special style for selected (middle) element
            final TextStyle itemStyle = value == selectedDecimalValue
                ? _selectedStyle : _defaultStyle;

            bool isExtra = index == 0 || index == itemCount - 1;

            return isExtra
                ? new Container() //empty first and last element
                : new Center(
                    child: new Text(
                        value.toString().padLeft(widget.decimalPlaces, '0'),
                        style: itemStyle),
                  );
          },
        ),
      ),
      onNotification: _onDecimalNotification,
    );
  }

  ///view containing confirm and cancel buttons
  Widget _initBottomView() {
    return new ButtonTheme.bar(
      child: new ButtonBar(
        children: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text(widget.cancelText),
          ),
          new FlatButton(
            onPressed: () {
              if (widget.decimalPlaces > 0) {
                _navigatorPopDouble();
              } else {
                _navigatorPopInteger();
              }
            },
            child: new Text(widget.confirmText),
          ),
        ],
      ),
    );
  }

  //
  // ----------------------------- LOGIC -----------------------------
  //

  _navigatorPopDouble() {
    double returnValue = selectedIntValue +
        pow(10, -widget.decimalPlaces) * selectedDecimalValue;
    Navigator.of(context).pop(returnValue);
  }

  _navigatorPopInteger() {
    int returnValue = selectedIntValue;
    Navigator.of(context).pop(returnValue);
  }

  bool _userStoppedScrolling(Notification notification,
      ScrollController scrollController) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        !(scrollController.position.activity is HoldScrollActivity);
  }

  bool _onIntegerNotification(Notification notification) {
    if (notification is ScrollNotification) {
      if (_userStoppedScrolling(notification, intScrollController)) {
        //center selected value
        _animate(intScrollController,
            (selectedIntValue - widget.minValue) * _itemExtent);
      } else {
        //calculate
        int intIndexOfMiddleElement =
            (notification.metrics.pixels + _listViewHeight / 2) ~/ _itemExtent;
        int intValueInTheMiddle = widget.minValue + intIndexOfMiddleElement - 1;

        //update selection
        if (intValueInTheMiddle != selectedIntValue) {
          _setIntegerState(intValueInTheMiddle);
        }
      }
    }
    return true;
  }

  bool _onDecimalNotification(Notification notification) {
    if (notification is ScrollNotification) {
      if (_userStoppedScrolling(notification, decimalScrollController)) {
        //center selected value
        _animate(decimalScrollController, selectedDecimalValue * _itemExtent);
      } else {
        //calculate indexOfMiddleElement
        int indexOfMiddleElement =
            (notification.metrics.pixels + _listViewHeight / 2) ~/ _itemExtent;

        //calculate corresponding value
        int decimalValueInTheMiddle = indexOfMiddleElement - 1;

        //update selection
        if (decimalValueInTheMiddle != selectedDecimalValue) {
          _setDecimalState(decimalValueInTheMiddle);
        }
      }
    }
    return true;
  }

  _setIntegerState(int newSelectedIntValue) {
    setState(() {
      selectedIntValue = newSelectedIntValue;
      //if integer is at max value, then set decimal places to 0
      if (widget.decimalPlaces > 0 && selectedIntValue == widget.maxValue) {
        double multiplier = selectedDecimalValue == 1 ? 0.5 : 1.5;
        decimalScrollController.animateTo(multiplier * _itemExtent,
            duration: new Duration(microseconds: 1),
            curve: new ElasticOutCurve());
      }
    });
  }

  _setDecimalState(int newSelectedDecimalValue) {
    setState(() => selectedDecimalValue = newSelectedDecimalValue);
  }

  ///scroll to selected value
  _animate(ScrollController scrollController, double value) {
    scrollController.animateTo(value,
        duration: new Duration(seconds: 1), curve: new ElasticOutCurve());
  }
}
