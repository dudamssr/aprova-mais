import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  // Pega a URL da API do .env, com fallback para localhost
  static final String baseUrl =
      dotenv.env['API_URL'] ?? "http://localhost:3000";

  static Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse("$baseUrl/usuarios/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "senha": senha}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erro ao fazer login: ${response.body}");
    }
  }
}
