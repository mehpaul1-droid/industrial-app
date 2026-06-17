import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://iran-protein-farm.onrender.com";

  static Future<Map<String, dynamic>> optimizeRation({
    required String animal,
    required int age,
    required String goal,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/ai/optimize-ration"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "animal": animal,
        "age": age,
        "goal": goal,
        "available": []
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.body}");
    }
  }
}
static Future<List<dynamic>> getHistory() async {
  final res = await http.get(Uri.parse("$baseUrl/ai/history"));
  final data = jsonDecode(res.body);
  return data["data"];
}
