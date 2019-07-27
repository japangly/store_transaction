library counter;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef void CounterChangeCallback(num value);

class CounterPlugin extends StatelessWidget {
  final CounterChangeCallback onChanged;

  CounterPlugin({
    Key key,
    @required num initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    @required this.decimalPlaces,
    this.color,
    this.textStyle,
    this.step = 1,
    this.buttonSize = 25,
  })  : assert(initialValue != null),
        assert(minValue != null),
        assert(maxValue != null),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color color;

  /// text syle
  TextStyle textStyle;

  final double buttonSize;

  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    color = color ?? themeData.accentColor;
    textStyle = textStyle ??
        TextStyle(
          fontSize: 32.0,
        );

    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            icon: Icon(
              Icons.remove,
              size: buttonSize,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: AutoSizeText(
              '$selectedValue',
              minFontSize: 32.0,
              maxFontSize: 128.0,
            ),
          ),
          IconButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            icon: Icon(
              Icons.add,
              size: buttonSize,
            ),
          ),
        ],
      ),
    );
  }
}
