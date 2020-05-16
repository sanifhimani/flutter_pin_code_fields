# Flutter Pin Code Fields

A flutter package which will help you generate customizable pin code fields. Can be used for login pins or OTP.

# Installation

## 1. Add Dependency
Add this to your `pubspec.yaml` file:
```yaml
dependencies:
    flutter_pin_code_fields: <VERSION>
```
## 2. Install
Install the package from command line either using FLutter or Pub:

Using Pub:
```shell
$ pub get
```
Using Flutter:
```shell
$ flutter packages get
```
## 3. Import Package
Import the package in the `Dart` file to use it:
```dart
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
```

# Properties
Name | Type | Description
| --- |---|---|
length | int | Total number of pin code fields. This property is __`required`__.
controller | TextEditingController | Text editing controller for the fields.
focusNode | FocusNode | Focus node for the fields.
autofocus | bool | Enable/ disable autofocus on the field. Default is __`false`__.
fieldHeight | double | Height of the pin code fields.
fieldWidth | double | Width of the pin code fields.
enabled | bool | Enable/ disable editing on the fields. Default is __`true`__.
responsive | bool | Automatically adjusts fields to the size of the screen or provided space. Default is __`true`__.
obscureText | bool | Hides the input text of the user. Default is __`false`__.
obscureCharacter | String | Character that replaces the user's input when __`obscureText`__ is __`true`__. Default is __`'*'`__.
margin | EdgeInsets | Provides margin between fields. Default is __`EdgeInsets.all(5.0)`__.
padding | EdgeInsets | Provides padding within the fields. Default is __`EdgeInsets.only(bottom: 5.0)`__.
fieldBorderStyle | FieldBorderStyle | Border style of the field. Default is __`FieldBorderStyle.Bottom`__. FieldBorderStyle contains: __`Square`__, __`Top`__, __`Bottom`__, __`Left`__, __`Right`__, __`TopBottom`__ and __`LeftRight`__.
borderWidth | double | Border width of the field. Default is __`2.0`__.
borderRadius | BorderRadius | Border radius of the field. Default is __`BorderRadius.zero`__.
borderColor | Color | Color of the border. Default is __`Colors.grey`__.
activeBorderColor | Color | Border color of the active/ highlighted field.
fieldBackgroundColor | Color | Background color of the fields.
activeBackgroundColor | Color | Background color of the active/ highlighted field.
textStyle | TextStyle | Style of the text in the fields.
keyboardType | TextInputType | Type of keyboard to use for the fields. Default is __`TextInputType.visiblePassword`__.
autoHideKeyboard | bool | Automatically hide keyboard when the user reaches the last field or the first field (by delete). Default is __`true`__.
onChange | Function(String) | Callback that returns text on input.
onComplete | Function(String) | Callback that returns text on filling all the fields. This property is __`required`__.

# Examples
## Default Usage
```dart
PinCodeFields(
    length: 4,
    onComplete: (output) {
        // Your logic with pin code
        print(output);
    },
),
```

<a href="https://raw.githubusercontent.com/sanifhimani/flutter_pin_code_fields/master/screenshots/default.gif">
<img src="https://raw.githubusercontent.com/sanifhimani/flutter_pin_code_fields/master/screenshots/default.gif" alt="Default Example" title="Default Example" width="50%">
</a>

## Obscure Fields
```dart
PinCodeFields(
    length: 6,
    obscureText: true,
    obscureCharacter: '❌',
    onComplete: (output) {
        // Your logic with pin code
        print(output);
    },
),
```

<a href="https://raw.githubusercontent.com/sanifhimani/flutter_pin_code_fields/master/screenshots/obscure.gif">
<img src="https://raw.githubusercontent.com/sanifhimani/flutter_pin_code_fields/master/screenshots/obscure.gif" alt="Obscure Example" title="Obscure Example" width="50%">
</a>

## Customized Fields
```dart
PinCodeFields(
    length: 4,
    fieldBorderStyle: FieldBorderStyle.Square,
    responsive: false,
    fieldHeight: 130.0,
    fieldWidth: 130.0,
    borderWidth: 5.0,
    activeBorderColor: Colors.teal,
    activeBackgroundColor: Colors.tealAccent,
    borderRadius: BorderRadius.circular(20.0),
    keyboardType: TextInputType.number,
    autoHideKeyboard: false,
    fieldBackgroundColor: Colors.lightGreenAccent,
    borderColor: Colors.lightGreen,
    textStyle: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
    ),
    onComplete: (output) {
        // Your logic with pin code
        print(output);
    },
),
```

<a href="https://raw.githubusercontent.com/sanifhimani/flutter_pin_code_fields/master/screenshots/custom.gif">
<img src="https://raw.githubusercontent.com/sanifhimani/flutter_pin_code_fields/master/screenshots/custom.gif" alt="Custom Example" title="Custom Example" width="50%">
</a>

For complete example, refer `example/lib/main.dart`.

# Contribute
Star ⭐️ to show support!

#### Have a new feature to add to this?

1. Fork it.
2. Create a branch for your feature (git checkout -b your-feature).
3. Commit your changes (git commit -m "Feature Description").
4. Push to the branch (git push origin your-feature).
5. Create new pull request.
