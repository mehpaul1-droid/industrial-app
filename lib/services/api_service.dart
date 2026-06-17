import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ اگر روی Render هست، اینو عوض کن
  static const String baseUrl = "https://iran-protein-farm.onrender.com";

  // ---------------- AI OPTIMIZE ----------------
  static Future<Map<String, dynamic>> optimizeRation({
    required String animal,
    required int age,
    required String goal,
    List<String>? available,
  }) async {
    final url = Uri.parse("$baseUrl/ai/optimize-ration");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "animal": animal,
        "age": age,
        "goal": goal,
        "available": available ?? [],
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.body}");
    }
  }
}
