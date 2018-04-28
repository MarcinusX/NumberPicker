# NumberPicker

NumberPicker is a custom widget designed for choosing an integer or decimal number by scrolling spinners.

It is possible to use NumberPicker as a standalone widget as well as in NumberPickerDialog.
![vertical](https://raw.githubusercontent.com/MarcinusX/NumberPicker/master/example/screenshots/gif_example.gif)

## Getting Started
#### Creating NumberPicker Widget

```
new NumberPicker.integer(
                initialValue: 50,
                minValue: 0,
                maxValue: 100,
                onChanged: _handleChange)
```
#### Creating NumberPickerDialog (use in material's showDialog method)
```
new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 10,
          initialDoubleValue: _currentPrice),
```
### Usage examples
See examples directory for full examples.

#### Standalone widget
![vertical](https://raw.githubusercontent.com/MarcinusX/NumberPicker/master/example/screenshots/gif_widget.gif)
```
class _MyHomePageState extends State<MyHomePage> {
  int _currentValue = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new NumberPicker.integer(
                initialValue: _currentValue,
                minValue: 0,
                maxValue: 100,
                onChanged: (newValue) =>
                    setState(() => _currentValue = newValue)),
            new Text("Current number: $_currentValue"),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
    );
  }
}

```


#### Dialog
![vertical](https://raw.githubusercontent.com/MarcinusX/NumberPicker/master/example/screenshots/gif_dialog.gif)
```
class _MyHomePageState extends State<MyHomePage> {
  double _currentPrice = 1.0;

  void _showDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 10,
          title: new Text("Pick a new price"),
          initialDoubleValue: _currentPrice,
        );
      }
    ).then((int value)) {
      if (value != null) {
        setState(() => _currentPrice = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("Current price: $_currentPrice \$"),
      ),
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.attach_money),
        onPressed: _showDialog,
      ),
    );
  }
}
```

