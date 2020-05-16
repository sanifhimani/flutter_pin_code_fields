# Flutter Pin Code Fields Example

Example on how to use the flutter_pin_code_fields package.

## Getting Started

Add dependency in __`pubspec.yaml`__ file.
```yaml
dependencies:
    flutter_pin_code_fields: <VERSION>
```

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