import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class BorderHelper {
  static Border border(
      int index, FieldBorderStyle fieldBorderStyle, BorderSide borderSide) {
    Border border = Border.all(
      width: 0,
      color: Colors.transparent,
    );

    switch (fieldBorderStyle) {
      case FieldBorderStyle.top:
        {
          border = Border(
            top: borderSide,
          );
        }
        break;
      case FieldBorderStyle.bottom:
        {
          border = Border(
            bottom: borderSide,
          );
        }
        break;
      case FieldBorderStyle.left:
        {
          border = Border(
            left: borderSide,
          );
        }
        break;
      case FieldBorderStyle.right:
        {
          border = Border(
            right: borderSide,
          );
        }
        break;
      case FieldBorderStyle.leftRight:
        {
          border = Border.symmetric(
            horizontal: borderSide,
          );
        }
        break;
      case FieldBorderStyle.topBottom:
        {
          border = Border.symmetric(
            vertical: borderSide,
          );
        }
        break;
      case FieldBorderStyle.square:
        {
          border = Border.symmetric(
            vertical: borderSide,
            horizontal: borderSide,
          );
        }
        break;
    }

    return border;
  }
}
