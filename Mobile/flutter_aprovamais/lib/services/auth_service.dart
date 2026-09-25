import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/usuario_model.dart';

class AuthService {
  // Alterna dinamicamente o IP consoante o ambiente (Web vs Emulador Android)
  String get baseUrl {
    final envUrl = dotenv.env['API_URL'];
    if (envUrl != null && envUrl.isNotEmpty) return envUrl;

    if (kIsWeb) {
      return 'http://localhost:3000';
    }
    return 'http://10.0.2.2:3000';
  }

  // Realizar Login
  Future<Map<String, dynamic>> login(String email, String senha) async {
    final url = Uri.parse('$baseUrl/usuario/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      final Map<String, dynamic> dados = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final usuario = dados['usuario'] != null
            ? Usuario.fromJson(dados['usuario'])
            : null;

        return {
          'sucesso': true,
          'mensagem': dados['mensagem'] ?? 'Login realizado com sucesso!',
          'usuario': usuario,
          'token': dados['token'], // Opcional, caso o backend retorne
        };
      } else {
        return {
          'sucesso': false,
          'mensagem': dados['erro'] ?? 'E-mail ou senha incorretos.',
        };
      }
    } catch (e) {
      return {'sucesso': false, 'mensagem': 'Erro ao conectar ao servidor: $e'};
    }
  }

  // Cadastrar Novo Usuário
  Future<Map<String, dynamic>> cadastrar({
    required String nome,
    required String email,
    required String senha,
    String tipo = 'ALUNO',
  }) async {
    final url = Uri.parse('$baseUrl/usuario/adicionar');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nome': nome,
          'email': email,
          'senha': senha,
          'tipo': tipo,
        }),
      );

      final Map<String, dynamic> dados = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {
          'sucesso': true,
          'mensagem': dados['mensagem'] ?? 'Usuário cadastrado com sucesso!',
        };
      } else {
        return {
          'sucesso': false,
          'mensagem': dados['erro'] ?? 'Erro ao cadastrar usuário.',
        };
      }
    } catch (e) {
      return {'sucesso': false, 'mensagem': 'Erro ao conectar ao servidor: $e'};
    }
  }
}
