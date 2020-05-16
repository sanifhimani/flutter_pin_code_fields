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
    onComplete: (result) {
        // Your logic with pin code
        print(result);
    },
),
```
![Default Example](screenshots/default.gif "Default Example"){:width="250px"}