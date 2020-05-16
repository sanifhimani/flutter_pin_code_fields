library flutter_pin_code_fields;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodeFields extends StatefulWidget {
  @required
  final int length;
  final TextEditingController controller;
  final bool autofocus;
  final FieldBorderStyle fieldBorderStyle;
  final double borderWidth;
  final Color borderColor;
  final double fieldHeight;
  final double fieldWidth;
  final BorderRadius borderRadius;
  final Color activeBorderColor;
  final Color fieldBackgroundColor;
  final Color activeBackgroundColor;
  final FocusNode focusNode;
  final bool enabled;
  final bool responsive;
  final bool obscureText;
  final String obscureCharacter;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final bool autoHideKeyboard;
  final ValueChanged<String> onChange;
  @required
  final ValueChanged<String> onComplete;

  PinCodeFields({
    this.length = 4,
    this.controller,
    this.autofocus = false,
    this.fieldBorderStyle = FieldBorderStyle.Bottom,
    this.borderWidth = 2.0,
    this.borderColor = Colors.grey,
    this.fieldHeight,
    this.fieldWidth,
    this.borderRadius,
    this.activeBorderColor = Colors.blue,
    this.fieldBackgroundColor,
    this.activeBackgroundColor,
    this.focusNode,
    this.enabled = true,
    this.responsive = true,
    this.obscureText = false,
    this.obscureCharacter = "*",
    this.margin = const EdgeInsets.all(5.0),
    this.padding = const EdgeInsets.only(bottom: 5.0),
    this.textStyle = const TextStyle(
      fontSize: 20.0,
    ),
    this.keyboardType = TextInputType.visiblePassword,
    this.autoHideKeyboard = true,
    this.onChange,
    this.onComplete,
  });
  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  TextEditingController _textEditingController;
  FocusNode _focusNode;
  List<String> _inputList;
  int _selectedIndex = 0;

  @override
  void initState() {
    _assignController();

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    _inputList = List<String>(widget.length);
    _initializeValues();
    super.initState();
  }

  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller;
    }
    _textEditingController.addListener(() {
      var currentText = _textEditingController.text;

      if (widget.enabled && _inputList.join("") != currentText) {
        if (currentText.length >= widget.length) {
          if (widget.onComplete != null) {
            if (currentText.length > widget.length) {
              currentText = currentText.substring(0, widget.length);
            }
            widget.onComplete(currentText);
          }
          if (widget.autoHideKeyboard) {
            _focusNode.unfocus();
          }
        } else if (currentText.length == 0) {
          if (widget.autoHideKeyboard) {
            _focusNode.unfocus();
          }
        }
        if (widget.onChange != null) {
          widget.onChange(currentText);
        }
      }
      _setTextToInput(currentText);
    });
  }

  void _initializeValues() {
    for (int i = 0; i < _inputList.length; i++) {
      _inputList[i] = "";
    }
  }

  void _onFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }

    FocusScope.of(context).requestFocus(_focusNode);
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  void _setTextToInput(String data) async {
    var replaceInputList = List<String>(widget.length);

    for (int i = 0; i < widget.length; i++) {
      if (data.length > i) {
        replaceInputList[i] = data[i];
      } else {
        replaceInputList[i] = "";
      }
//      replaceInputList[i] = data.length > i ? data[i] : "";
    }

    setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }

  Color _getColorFromIndex(int index) {
    if (!widget.enabled) {
      return widget.borderColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return widget.activeBorderColor;
    } else if (_selectedIndex > index) {
      return widget.borderColor;
    }
    return widget.borderColor;
  }

  Color _getBackgroundColorFromIndex(int index) {
    if (!widget.enabled) {
      return widget.fieldBackgroundColor;
    }
    if (((_selectedIndex == index) ||
            (_selectedIndex == index + 1 && index + 1 == widget.length)) &&
        _focusNode.hasFocus) {
      return widget.activeBackgroundColor;
    } else if (_selectedIndex > index) {
      return widget.fieldBackgroundColor;
    }
    return widget.fieldBackgroundColor;
  }

  Border _generateBorder(int index) {
    if (widget.fieldBorderStyle == FieldBorderStyle.Square) {
      return Border.all(
        color: _getColorFromIndex(index),
        width: widget.borderWidth,
      );
    } else if (widget.fieldBorderStyle == FieldBorderStyle.Top) {
      return Border(
        top: BorderSide(
          width: widget.borderWidth,
          color: _getColorFromIndex(index),
        ),
      );
    } else if (widget.fieldBorderStyle == FieldBorderStyle.Left) {
      return Border(
        left: BorderSide(
          width: widget.borderWidth,
          color: _getColorFromIndex(index),
        ),
      );
    } else if (widget.fieldBorderStyle == FieldBorderStyle.Right) {
      return Border(
        right: BorderSide(
          width: widget.borderWidth,
          color: _getColorFromIndex(index),
        ),
      );
    } else if (widget.fieldBorderStyle == FieldBorderStyle.LeftRight) {
      return Border.symmetric(
          horizontal: BorderSide(
        width: widget.borderWidth,
        color: _getColorFromIndex(index),
      ));
    } else if (widget.fieldBorderStyle == FieldBorderStyle.TopBottom) {
      return Border.symmetric(
          vertical: BorderSide(
        width: widget.borderWidth,
        color: _getColorFromIndex(index),
      ));
    } else {
      return Border(
        bottom: BorderSide(
          width: widget.borderWidth,
          color: _getColorFromIndex(index),
        ),
      );
    }
  }

  Widget _generateTextField(int index) {
    return !widget.responsive
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            child: AnimatedContainer(
              margin: widget.margin,
              padding: widget.padding,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 150),
              width: widget.fieldWidth,
              height: widget.fieldHeight,
              decoration: BoxDecoration(
                color: _getBackgroundColorFromIndex(index),
                borderRadius: widget.borderRadius,
                border: _generateBorder(index),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, .5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: Text(
                    widget.obscureText
                        ? _inputList[index]
                            .replaceAll(RegExp(r'.'), widget.obscureCharacter)
                        : _inputList[index],
                    key: ValueKey(_inputList[index]),
                    style: widget.textStyle,
                  ),
                ),
              ),
            ),
          )
        : Flexible(
            child: AnimatedContainer(
              margin: widget.margin,
              padding: widget.padding,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 150),
              height: widget.fieldHeight,
              decoration: BoxDecoration(
                color: _getBackgroundColorFromIndex(index),
                borderRadius: widget.borderRadius,
                border: _generateBorder(index),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, .5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: Text(
                    widget.obscureText
                        ? _inputList[index]
                            .replaceAll(RegExp(r'.'), widget.obscureCharacter)
                        : _inputList[index],
                    key: ValueKey(_inputList[index]),
                    style: widget.textStyle,
                  ),
                ),
              ),
            ),
          );
  }

  List<Widget> _generateFields() {
    var result = <Widget>[];
    for (int i = 0; i < widget.length; i++) {
      result.add(_generateTextField(i));
    }
    return result;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: AbsorbPointer(
              absorbing: true,
              child: TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                autocorrect: false,
                keyboardType: widget.keyboardType,
                enableInteractiveSelection: false,
                showCursor: false,
                cursorColor: Colors.blue,
                cursorWidth: 0.01,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.red,
                  height: 0.01,
                  fontSize: 0.01,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _onFocus,
            child: Container(
              constraints: const BoxConstraints(minHeight: 30),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: !widget.responsive
                  ? Wrap(
                      children: _generateFields(),
                    )
                  : Row(
                      children: _generateFields(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

enum FieldBorderStyle {
  Square,
  Top,
  Bottom,
  Left,
  Right,
  TopBottom,
  LeftRight,
}
