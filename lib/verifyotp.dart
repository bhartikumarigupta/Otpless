import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otplessauthentication/constants.dart';

class VerifyOTPResult {
  final bool success;
  final String errorMessage;

  VerifyOTPResult({required this.success, required this.errorMessage});
}

class VerifyOTP {
  static Future<VerifyOTPResult> verifyOTP(String orderId, String otp, String phoneNumber) async {
    Map<String, String> headers = {
      'clientId': Constants.ClientId,
      'clientSecret': Constants.ClientSecret,
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> verifyData = {
      "orderId": orderId,
      "otp": otp,
      "sendTo": phoneNumber,
    };

    String jsonBody = json.encode(verifyData);

    try {
      var response = await http.post(
        Uri.parse(Constants.OTPVerifyEndpoint),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        bool isOTPVerified = responseData['isOTPVerified'];

        if (isOTPVerified) {
          return VerifyOTPResult(success: true, errorMessage: '');
        } else {
          return VerifyOTPResult(success: false, errorMessage: 'Invalid OTP, please try again.');
        }
      } else {
        return VerifyOTPResult(success: false, errorMessage: 'Invalid OTP, please try again.');
      }
    } catch (e) {
      return VerifyOTPResult(success: false, errorMessage: 'Error verifying OTP, please try again.');
    }
  }
}

const String OTPVerifyEndpoint = 'https://auth.otpless.app/auth/otp/verify';
