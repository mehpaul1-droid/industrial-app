import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; 
  // اگر روی گوشی واقعی تست کردی بعداً IP عوض می‌شود

  // ارسال OTP
  static Future<Map<String, dynamic>> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/send-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    return jsonDecode(response.body);
  }

  // تایید OTP
  static Future<Map<String, dynamic>> verifyOtp(
      String phone, String otp) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/verify-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "otp": otp,
      }),
    );

    return jsonDecode(response.body);
  }

  // گرفتن جیره
  static Future<Map<String, dynamic>> getRation(
      String animal, int age) async {
    final response = await http.get(
      Uri.parse("$baseUrl/ai/ration?animal=$animal&avg=$age"),
    );

    return jsonDecode(response.body);
  }
}
static Future<Map<String, dynamic>> getDashboard() async {
  final response = await http.get(
    Uri.parse("$baseUrl/dashboard/summary"),
  );

  return jsonDecode(response.body);
}
static Future<List<dynamic>> getFarms() async {
  final res = await http.get(Uri.parse("$baseUrl/farms/list"));
  return jsonDecode(res.body)["farms"];
}

static Future<void> createFarm(String name, String type) async {
  await http.post(
    Uri.parse("$baseUrl/farms/create"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "name": name,
      "type": type,
    }),
  );
}
static Future<Map<String, dynamic>> analyzeFarm(String name, String type) async {
  final res = await http.post(
    Uri.parse("$baseUrl/ai/farm-analysis"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "farm_name": name,
      "type": type,
      "goal": "growth"
    }),
  );

  return jsonDecode(res.body);
}
static Future<List<dynamic>> getReports() async {
  final res = await http.get(Uri.parse("$baseUrl/reports/list"));
  return jsonDecode(res.body)["reports"];
}

static Future<void> addReport(Map<String, dynamic> data) async {
  await http.post(
    Uri.parse("$baseUrl/reports/add"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(data),
  );
}
