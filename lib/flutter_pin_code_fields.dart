library flutter_pin_code_fields;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodeFields extends StatefulWidget {
  @required

  /// Total number of pin code fields.
  final int length;

  /// Text editing controller for the fields.
  final TextEditingController controller;

  /// Enable/ disable autofocus on the field.
  final bool autofocus;

  /// Border style of the field.
  final FieldBorderStyle fieldBorderStyle;

  /// Border width of the field.
  final double borderWidth;

  /// Color of the border.
  final Color borderColor;

  /// Height of the pin code fields.
  final double fieldHeight;

  /// Width of the pin code fields.
  final double fieldWidth;

  /// Border radius of the field.
  final BorderRadius borderRadius;

  /// Border color of the active/ highlighted field.
  final Color activeBorderColor;

  /// Background color of the fields.
  final Color fieldBackgroundColor;

  /// Background color of the active/ highlighted field.
  final Color activeBackgroundColor;

  /// Focus node for the fields.
  final FocusNode focusNode;

  /// Enable/ disable editing on the fields.
  final bool enabled;

  /// Automatically adjusts fields to the size of the screen or provided space.
  final bool responsive;

  /// Hides the input text of the user.
  final bool obscureText;

  /// Character that replaces the user's input when obscureText is true.
  final String obscureCharacter;

  /// Provides margin between fields.
  final EdgeInsets margin;

  /// Provides padding within the fields.
  final EdgeInsets padding;

  /// Style of the text in the fields.
  final TextStyle textStyle;

  /// Type of keyboard to use for the fields.
  final TextInputType keyboardType;

  /// Automatically hide keyboard when the user reaches the last field or the first field (by delete).
  final bool autoHideKeyboard;

  /// Animation for the text in the fields.
  final Animations animation;

  /// Animation duration for the text in the fields.
  final Duration animationDuration;

  /// Animation curves for the text in the fields.
  final Curve animationCurve;

  /// Animation switch in curve for the text in the fields.
  final Curve switchInAnimationCurve;

  /// Animation switch out curve for the text in the fields.
  final Curve switchOutAnimationCurve;

  /// Callback that returns text on input.
  final ValueChanged<String> onChange;

  /// Callback that returns text on filling all the fields.
  @required
  final ValueChanged<String> onComplete;

  PinCodeFields({
    /// Default length is 4.
    this.length = 4,
    this.controller,

    /// autofocus is false by default.
    this.autofocus = false,

    /// Default border style is bottom.
    this.fieldBorderStyle = FieldBorderStyle.Bottom,

    /// Default width for border is 2.0.
    this.borderWidth = 2.0,

    /// Default border color is grey.
    this.borderColor = Colors.grey,
    this.fieldHeight,
    this.fieldWidth,
    this.borderRadius,

    /// Default active border color is blue.
    this.activeBorderColor = Colors.blue,
    this.fieldBackgroundColor,
    this.activeBackgroundColor,
    this.focusNode,

    /// Text fields are enabled by default.
    this.enabled = true,

    /// Responsive is true by default.
    this.responsive = true,

    /// Obscure text is false by default.
    this.obscureText = false,

    /// Default character for obscure text is *.
    this.obscureCharacter = "*",

    /// Default margin between fields is 5.0.
    this.margin = const EdgeInsets.all(5.0),

    /// Default padding in the fields is 5.0.
    this.padding = const EdgeInsets.only(bottom: 5.0),

    /// Default text style for the fields.
    this.textStyle = const TextStyle(
      fontSize: 20.0,
    ),

    /// Default keyboard type is visiblePassword by default.
    this.keyboardType = TextInputType.visiblePassword,

    /// Auto hide keyboard is true by default.
    this.autoHideKeyboard = true,

    /// Default animation for text is Fade.
    this.animation = Animations.Fade,

    /// Default duration for animation on text is 150ms.
    this.animationDuration = const Duration(milliseconds: 150),

    /// Default animation curve for animation on text is Curves.easeInOut.
    this.animationCurve = Curves.easeInOut,

    /// Default switch in animation curve for animation on text is Curves.easeIn.
    this.switchInAnimationCurve = Curves.easeIn,

    /// Default switch out animation curve for animation on text is Curves.easeOut.
    this.switchOutAnimationCurve = Curves.easeOut,
    this.onChange,
    this.onComplete,
  });

  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  TextEditingController _textEditingController;
  FocusNode _focusNode;

  /// Storing the input in this list.
  List<String> _inputList;

  /// Keeps a track of selected pin code field.
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

  /// function responsible for assigning controller to the text field.
  void _assignController() {
    if (widget.controller == null) {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = widget.controller;
    }

    /// Text editing controllers' listener
    /// Used to check which is the current field and set focus on that field,
    /// populate onComplete callback.
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

  /// Initializing the input list to empty.
  void _initializeValues() {
    for (int i = 0; i < _inputList.length; i++) {
      _inputList[i] = "";
    }
  }

  /// Checking if the requested text field has focus or not.
  void _onFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }

    /// Launching keyboard.
    FocusScope.of(context).requestFocus(_focusNode);
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  /// Populating the input list with the text that the user inputs.
  void _setTextToInput(String data) async {
    var replaceInputList = List<String>(widget.length);

    for (int i = 0; i < widget.length; i++) {
      if (data.length > i) {
        replaceInputList[i] = data[i];
      } else {
        replaceInputList[i] = "";
      }
    }

    setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }

  /// Setting the color of the active text field using _selectedIndex.
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

  /// Setting the background color of the active text field using _selectedIndex.
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

  /// Generating border of the field by using enum FieldBorderStyle.
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

  /// Generating animation for text based on the animation selected.
  Widget _getAnimation(Widget child, Animation animation) {
    if (widget.animation == Animations.SlideInUp) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, .5),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.SlideInDown) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -.5),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.SlideInRight) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.SlideInLeft) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.RotateLeft) {
      return RotationTransition(
        turns: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.RotateRight) {
      return RotationTransition(
        turns: Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.Grow) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: child,
      );
    } else if (widget.animation == Animations.Shrink) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 1.5,
          end: 1,
        ).animate(animation),
        child: child,
      );
    } else {
      return FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: child,
      );
    }
  }

  /// Generating text fields based on the length of text field provided and the bool value of responsive.
  Widget _generateTextField(int index) {
    return !widget.responsive
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            child: AnimatedContainer(
              margin: widget.margin,
              padding: widget.padding,
              curve: widget.animationCurve,
              duration: widget.animationDuration,
              width: widget.fieldWidth,
              height: widget.fieldHeight,
              decoration: BoxDecoration(
                color: _getBackgroundColorFromIndex(index),
                borderRadius: widget.borderRadius,
                border: _generateBorder(index),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  switchInCurve: widget.switchInAnimationCurve,
                  switchOutCurve: widget.switchOutAnimationCurve,
                  duration: widget.animationDuration,
                  transitionBuilder: (child, animation) {
                    return _getAnimation(child, animation);
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
              curve: widget.animationCurve,
              duration: widget.animationDuration,
              height: widget.fieldHeight,
              decoration: BoxDecoration(
                color: _getBackgroundColorFromIndex(index),
                borderRadius: widget.borderRadius,
                border: _generateBorder(index),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  switchInCurve: widget.switchInAnimationCurve,
                  switchOutCurve: widget.switchOutAnimationCurve,
                  duration: widget.animationDuration,
                  transitionBuilder: (child, animation) {
                    return _getAnimation(child, animation);
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

/// Styles for fields border.
enum FieldBorderStyle {
  Square,
  Top,
  Bottom,
  Left,
  Right,
  TopBottom,
  LeftRight,
}

/// Animation for the text in the pin code fields.
enum Animations {
  SlideInUp,
  SlideInDown,
  SlideInLeft,
  SlideInRight,
  Grow,
  Shrink,
  RotateRight,
  RotateLeft,
  Fade,
}
