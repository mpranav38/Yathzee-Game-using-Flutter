import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'views/yahtzee.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MaterialApp(
    title: 'Yahtzee',
    home: Scaffold(body: Yahtzee()),
  ));
}
