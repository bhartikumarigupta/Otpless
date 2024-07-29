import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otplessauthentication/resendotp.dart';
import 'package:otplessauthentication/verifyotp.dart';

class OtpVerification extends StatefulWidget {
  final String orderId;
  final String phoneNumber;

  OtpVerification({required this.orderId, required this.phoneNumber});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    VerifyOTPResult result = await VerifyOTP.verifyOTP(widget.orderId, _otpController.text, widget.phoneNumber);

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      Get.snackbar('Success', 'OTP verified successfully');
      // Navigate to the next screen or perform any other action
    } else {
      Get.snackbar('Error', result.errorMessage);
    }
  }

  void _resendOTP() async {
    setState(() {
      _isLoading = true;
    });

    ResendOTPResult result = await ResendOTP.resendOTP(widget.orderId);

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      Get.snackbar('Success', 'OTP resent successfully');
    } else {
      Get.snackbar('Error', result.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _verifyOTP,
                        child: Text('Verify OTP'),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: _resendOTP,
                        child: Text('Resend OTP'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
