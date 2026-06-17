import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ اگر روی Render هست، اینو عوض نکن
  static const String baseUrl = "https://iran-protein-farm.onrender.com";

  // ---------------- AI OPTIMIZATION ----------------
  static Future<Map<String, dynamic>> optimizeRation({
    required String animal,
    required int age,
    required String goal,
    required List<String> available,
  }) async {
    final url = Uri.parse("$baseUrl/ai/optimize-ration");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "animal": animal,
        "age": age,
        "goal": goal,
        "available": available,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("AI request failed: ${response.body}");
    }
  }

  // ---------------- HISTORY ----------------
  static Future<List<dynamic>> getHistory() async {
    final url = Uri.parse("$baseUrl/ai/history");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["data"];
    } else {
      throw Exception("Failed to load history: ${response.body}");
    }
  }
}
