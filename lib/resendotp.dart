import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otplessauthentication/constants.dart';

class ResendOTPResult {
  final bool success;
  final String errorMessage;

  ResendOTPResult({required this.success, required this.errorMessage});
}

class ResendOTP {
  static Future<ResendOTPResult> resendOTP(String orderId) async {
    Map<String, String> headers = {
      'clientId': Constants.ClientId,
      'clientSecret': Constants.ClientSecret,
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> data = {
      "orderId": orderId,
    };

    String jsonBody = json.encode(data);

    try {
      var response = await http.post(
        Uri.parse(Constants.ResendOTPEndpoint),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        return ResendOTPResult(success: true, errorMessage: '');
      } else {
        return ResendOTPResult(success: false, errorMessage: 'Failed to resend OTP. Please try again.');
      }
    } catch (e) {
      print('Error resending OTP: $e');
      return ResendOTPResult(success: false, errorMessage: 'Error resending OTP. Please try again.');
    }
  }
}

const String ResendOTPEndpoint = 'https://auth.otpless.app/auth/otp/resend';
