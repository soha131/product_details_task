import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = "https://task-two-plum-44.vercel.app/api";

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

}
