import 'package:flutter/material.dart';
import 'package:foodly_app/common/app_style.dart';
import 'package:foodly_app/constants/constants.dart';
import 'package:phone_otp_verification/phone_verification.dart';


class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PhoneVerification(
      isFirstPage: false,
      enableLogo: false,
      themeColor: kPrimary,
      backgroundColor: kLightWhite,
      initialPageText: "Verify Phone Number",
      initialPageTextStyle: appStyle(12, kDark, FontWeight.bold),
      textColor: kDark,
      onSend: (String value) {
        print('Phone number: $value');
      },
      onVerification: (String value) {
        print('OTP: $value');
      },
    );
  }
}