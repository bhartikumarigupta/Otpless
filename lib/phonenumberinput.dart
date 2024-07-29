import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otplessauthentication/otpverification.dart';
import 'package:otplessauthentication/sendotp.dart';

class PhoneNumberInput extends StatefulWidget {
  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String _orderId = '';

  void _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    SendOTPResult result = await SendOTP.sendOTP(_phoneController.text, "sms");

    setState(() {
      _isLoading = false;
      _orderId = result.orderId ?? '';
    });

    if (_orderId.isNotEmpty) {
      Get.to(() => OtpVerification(orderId: _orderId, phoneNumber: _phoneController.text));
    } else {
      Get.snackbar('Error', result.otpErrorMessage ?? 'Failed to send OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _sendOTP,
                    child: Text('Send OTP'),
                  ),
          ],
        ),
      ),
    );
  }
}
