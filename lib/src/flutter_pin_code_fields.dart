part of flutter_pin_code_fields;

/// Pin code fields widget
class PinCodeFields extends StatefulWidget {
  /// Length of the pin code fields.
  /// Default length is 4
  final int length;

  /// Margin between the fields.
  /// Default margin is EdgeInsets.all(5.0)
  final EdgeInsets margin;

  /// Padding within a field
  /// Default padding is EdgeInsets.only(bottom: 5.0)
  final EdgeInsets padding;

  /// Height of the fields
  final double? fieldHeight;

  /// Width of the fields
  final double? fieldWidth;

  /// Border width of the fields
  /// Default border width is 2.0
  final double borderWidth;

  /// Border radius of the fields
  final BorderRadius? borderRadius;

  /// Border color of the fields
  /// Default border color is Colors.grey
  final Color borderColor;

  /// Border color of the active pin code field
  /// Default active border color is Colors.blue
  final Color activeBorderColor;

  /// Border styles of the fields
  /// Default border style is FieldBorderStyle.bottom
  final FieldBorderStyle fieldBorderStyle;

  /// Background color of the fields
  /// Default background color is Colors.transparent
  final Color fieldBackgroundColor;

  /// Background color of the active pin code field
  /// Default active background color is Colors.transparent
  final Color activeBackgroundColor;

  /// Enable/ disable editing the fields
  /// Default is true
  final bool enabled;

  /// Adjust the size of the fields automatically to the available space
  /// Default is true
  final bool responsive;

  /// Enable/ disable autofocus
  /// Default is false
  final bool autofocus;

  /// Custom text style
  final TextStyle textStyle;

  /// Obscure text in the fields
  /// Default is false
  final bool obscureText;

  /// Character to obscure the fields with.
  /// Default obscureCharacter is "*"
  final String obscureCharacter;

  /// Keyboard type for the fields
  /// Default keyboard type is TextInputType.visiblePassword
  final TextInputType keyboardType;

  /// Input formatters for the fields
  final List<TextInputFormatter>? inputFormatters;

  /// Auto hide keyboard on complete
  /// Default is true
  final bool autoHideKeyboard;

  /// Animation for the text inside the fields
  /// Default animation is fade
  final Animations animation;

  /// Duration of the animation
  /// Default duration is Duration(milliseconds: 150)
  final Duration animationDuration;

  /// Animation curve
  /// Default is Curves.easeInOut
  final Curve animationCurve;

  /// Switch in animation curve
  /// Default is Curves.easeIn
  final Curve switchInAnimationCurve;

  /// Switch out animation curve
  /// /// Default is Curves.easeOut
  final Curve switchOutAnimationCurve;

  /// Text editing controller
  final TextEditingController? controller;

  /// Focus node
  final FocusNode? focusNode;

  /// Callback that returns text on change
  final ValueChanged<String>? onChange;

  /// Callback that return text on complete
  @required
  final ValueChanged<String> onComplete;

  PinCodeFields({
    this.length = 4,
    this.margin = const EdgeInsets.all(5.0),
    this.padding = const EdgeInsets.only(bottom: 5.0),
    this.fieldHeight,
    this.fieldWidth,
    this.borderWidth = 2.0,
    this.borderRadius,
    this.borderColor = Colors.grey,
    this.activeBorderColor = Colors.blue,
    this.fieldBorderStyle = FieldBorderStyle.bottom,
    this.fieldBackgroundColor = Colors.transparent,
    this.activeBackgroundColor = Colors.transparent,
    this.enabled = true,
    this.responsive = true,
    this.autofocus = false,
    this.textStyle = const TextStyle(
      fontSize: 20.0,
    ),
    this.obscureText = false,
    this.obscureCharacter = "*",
    this.keyboardType = TextInputType.visiblePassword,
    this.inputFormatters,
    this.autoHideKeyboard = true,
    this.animation = Animations.fade,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.switchInAnimationCurve = Curves.easeIn,
    this.switchOutAnimationCurve = Curves.easeOut,
    this.controller,
    this.focusNode,
    this.onChange,
    required this.onComplete,
  });

  @override
  PinCodeFieldsState createState() => PinCodeFieldsState();
}
