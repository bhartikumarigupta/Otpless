import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:otplessauthentication/constants.dart';

class SendOTPResult {
  final String? orderId;
  final String? otpErrorMessage;

  SendOTPResult({this.orderId, this.otpErrorMessage});
}

class SendOTP {
  static Future<SendOTPResult> sendOTP(String phoneNumber, String channel) async {
    Map<String, String> headers = {
      'clientId': Constants.ClientId,
      'clientSecret': Constants.ClientSecret,
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> data = {
      "sendTo": "91" + phoneNumber,
      "otpLength": Constants.OTPLength,
      "channel": channel,
    };
    log(data.toString());	

    String jsonBody = json.encode(data);
    log(jsonBody);

    try {
      var response = await http.post(
        Uri.parse(Constants.SendOTPEnpoint),
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse = json.decode(response.body);
        String orderId = parsedResponse['orderId'];
        return SendOTPResult(orderId: orderId);
      } else {
        log(response.statusCode.toString());
        return SendOTPResult(
          otpErrorMessage: 'Failed to send OTP. Please check the phone number.',
          
        );
      }
      
    } catch (e) {
      print('Error sending OTP: $e');
      return SendOTPResult(
        otpErrorMessage: 'Error sending OTP. Please check the phone number.',
      );
    }
  }
}

const String SendOTPEnpoint = 'https://auth.otpless.app/auth/otp/send';
