import 'package:otplessauthentication/resendotp.dart';
import 'package:otplessauthentication/sendotp.dart';
import 'package:otplessauthentication/verifyotp.dart';

void authenticateUser(String phoneNumber, String otp) async {
  // Send OTP
  SendOTPResult sendResult = await SendOTP.sendOTP(phoneNumber, "sms");
  if (sendResult.orderId != null) {
    print("OTP sent successfully. Order ID: ${sendResult.orderId}");
    
    // Verify OTP
    VerifyOTPResult verifyResult = await VerifyOTP.verifyOTP(sendResult.orderId!, otp, phoneNumber);
    if (verifyResult.success) {
      print("OTP verified successfully.");
    } else {
      print("OTP verification failed: ${verifyResult.errorMessage}");
    }
  } else {
    print("Failed to send OTP: ${sendResult.otpErrorMessage}");
  }
}

void resendOTP(String orderId) async {
  ResendOTPResult resendResult = await ResendOTP.resendOTP(orderId);
  if (resendResult.success) {
    print("OTP resent successfully.");
  } else {
    print("Failed to resend OTP: ${resendResult.errorMessage}");
  }
}
