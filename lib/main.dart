import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otplessauthentication/phonenumberinput.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OTP Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhoneNumberInput(),
    );
  }
}
