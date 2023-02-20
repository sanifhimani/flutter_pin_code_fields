import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pinCode = "...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinCodeFields(
              obscureText: true,
              obscureCharacter: "❌",
              animation: Animations.rotateRight,
              animationDuration: Duration(milliseconds: 250),
              animationCurve: Curves.bounceInOut,
              switchInAnimationCurve: Curves.bounceIn,
              switchOutAnimationCurve: Curves.bounceOut,
              onComplete: (code) {
                setState(() {
                  pinCode = code;
                });
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "pin code: $pinCode",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
