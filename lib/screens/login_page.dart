import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  bool otpSent = false;
  bool loading = false;

  String message = "";

  Future<void> sendOtp() async {
    setState(() {
      loading = true;
      message = "";
    });

    try {
      final res = await ApiService.sendOtp(phoneController.text);

      setState(() {
        otpSent = true;
        message = res["message"] ?? "کد ارسال شد";
      });
    } catch (e) {
      setState(() {
        message = "خطا در ارسال کد: $e";
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> verifyOtp() async {
    setState(() {
      loading = true;
      message = "";
    });

    try {
      final res = await ApiService.verifyOtp(
        phone: phoneController.text,
        otp: otpController.text,
      );

      setState(() {
        message = res.toString();
      });

      if (res["access_token"] != null) {
        Navigator.pushReplacementNamed(context, "/dashboard");
      }
    } catch (e) {
      setState(() {
        message = "خطا در تایید کد: $e";
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ورود به سیستم"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "شماره موبایل",
              ),
            ),

            const SizedBox(height: 12),

            if (!otpSent)
              ElevatedButton(
                onPressed: loading ? null : sendOtp,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("دریافت کد"),
              ),

            if (otpSent) ...[
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "کد OTP",
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: loading ? null : verifyOtp,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("تایید"),
              ),
            ],

            const SizedBox(height: 20),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
