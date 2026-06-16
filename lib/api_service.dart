import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // ⚠️ اینو بعداً باید IP یا لینک سرورت کنی
  final String baseUrl = "http://YOUR_API_IP:8000";

  Future analyze(List<double> values) async {
    final response = await http.post(
      Uri.parse("$baseUrl/ai/analyze"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(values),
    );

    return jsonDecode(response.body);
  }

  Future predict(List<double> values) async {
    final response = await http.post(
      Uri.parse("$baseUrl/ai/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(values),
    );

    return jsonDecode(response.body);
  }
}
