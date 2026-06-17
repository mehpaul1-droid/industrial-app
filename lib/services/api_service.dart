import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      "https://iran-protein-farm.onrender.com";

  // ---------------- AI OPTIMIZATION ----------------

  static Future<Map<String, dynamic>> optimizeRation({
    required String animal,
    required int age,
    required String goal,
    List<String>? available,
  }) async {

    final response = await http.post(
      Uri.parse("$baseUrl/ai/optimize-ration"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "animal": animal,
        "age": age,
        "goal": goal,
        "available": available ?? [],
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      "AI Error: ${response.body}",
    );
  }

  // ---------------- HISTORY ----------------

  static Future<List<dynamic>> getHistory() async {

    final response = await http.get(
      Uri.parse("$baseUrl/ai/history"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return data["data"] ?? [];
    }

    throw Exception(
      "History Error: ${response.body}",
    );
  }

  // ---------------- DASHBOARD STATS ----------------

  static Future<Map<String, dynamic>> getDashboardStats() async {

    final response = await http.get(
      Uri.parse("$baseUrl/dashboard/stats"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      "Stats Error: ${response.body}",
    );
  }
}
// ---------------- AUTH ----------------

static Future<Map<String, dynamic>> sendOtp(String phone) async {
  final response = await http.post(
    Uri.parse("$baseUrl/auth/send-otp"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"phone": phone}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception("Send OTP Error: ${response.body}");
}

static Future<Map<String, dynamic>> verifyOtp({
  required String phone,
  required String otp,
}) async {
  final response = await http.post(
    Uri.parse("$baseUrl/auth/verify-otp"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "phone": phone,
      "otp": otp,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception("Verify OTP Error: ${response.body}");
}
