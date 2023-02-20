import 'package:flutter/material.dart';

class BorderSideHelper {
  static BorderSide borderSide(int index, double borderWidth, Color color) {
    return BorderSide(
      width: borderWidth,
      color: color,
    );
  }
}
