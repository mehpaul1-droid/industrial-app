import 'package:flutter/material.dart';
import 'api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  bool otpSent = false;

  String message = "";

  void sendOtp() async {
    final res = await ApiService.sendOtp(phoneController.text);
    setState(() {
      otpSent = true;
      message = res["message"] ?? "";
    });
  }

  void verifyOtp() async {
    final res = await ApiService.verifyOtp(
      phoneController.text,
      otpController.text,
    );

    setState(() {
      message = res.toString();
    });

    if (res["access_token"] != null) {
      Navigator.pushReplacementNamed(context, "/dashboard");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ورود به سیستم")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "شماره موبایل"),
            ),
            if (!otpSent)
              ElevatedButton(
                onPressed: sendOtp,
                child: Text("دریافت کد"),
              ),
            if (otpSent) ...[
              TextField(
                controller: otpController,
                decoration: InputDecoration(labelText: "کد OTP"),
              ),
              ElevatedButton(
                onPressed: verifyOtp,
                child: Text("تایید"),
              ),
            ],
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }
}
