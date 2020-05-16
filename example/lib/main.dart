import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Code Fields Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pin Code Fields Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Custom Pincode Fields',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
//            PinCodeFields(
//              length: 4,
//              controller: newTextEditingController,
//              focusNode: focusNode,
//              onComplete: (result) {
//                // Your logic with code
//                print(result);
//              },
//            ),
//            SizedBox(
//              height: 50.0,
//            ),
//            Text(
//              'Custom Pincode Fields',
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                fontSize: 18,
//                fontWeight: FontWeight.bold,
//              ),
//            ),
//            SizedBox(
//              height: 10.0,
//            ),
            PinCodeFields(
              length: 6,
              obscureText: true,
              obscureCharacter: '❌',
              onComplete: (text) {
                // Your logic with pin code
                print(text);
              },
            ),
          ],
        ));
  }
}
