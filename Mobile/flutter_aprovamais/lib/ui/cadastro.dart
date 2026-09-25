import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_aprovamais/ui/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarController = TextEditingController();

  bool carregando = false;
  bool _obscurePassword = true;
  bool _obscureConfirmar = true;

  Future<void> cadastrarUsuario() async {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text;
    final confirmarSenha = confirmarController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );

      return;
    }

    if (senha != confirmarSenha) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem'),
        ),
      );

      return;
    }

    setState(() => carregando = true);

    final baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';
    final url = Uri.parse('$baseUrl/usuario/adicionar');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nome': nome,
          'email': email,
          'senha': senha,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final usuario = data['usuario'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('usuarioId', usuario['id']);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['mensagem'] ?? 'Cadastro realizado!',
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        final erro = jsonDecode(response.body);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro: ${erro['mensagem'] ?? erro['erro'] ?? 'Não foi possível cadastrar'}',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Falha na conexão: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => carregando = false);
      }
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fundoAzulClaro = Color(0xFFE8F0FE);
    const azulBotao = Color(0xFF1A73E8);
    const azulTexto = Color(0xFF1A3C6E);
    const fundoBranco = Colors.white;

    return Scaffold(
      backgroundColor: fundoBranco,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add_alt_1,
                  color: azulBotao,
                  size: 60,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Crie sua conta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: azulTexto,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                const Text(
                  'Cadastre-se para começar',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: nomeController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fundoAzulClaro,
                          labelText: 'Nome',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: azulBotao,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller: emailController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fundoAzulClaro,
                          labelText: 'E-mail',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          hintText: 'voce@exemplo.com',
                          hintStyle: const TextStyle(
                            color: Colors.black54,
                          ),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: azulBotao,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller: senhaController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fundoAzulClaro,
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: azulBotao,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: azulBotao,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller: confirmarController,
                        obscureText: _obscureConfirmar,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fundoAzulClaro,
                          labelText: 'Confirme sua senha',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: azulBotao,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmar
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: azulBotao,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmar = !_obscureConfirmar;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      ElevatedButton(
                        onPressed: carregando ? null : cadastrarUsuario,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: azulBotao,
                          minimumSize: const Size(
                            double.infinity,
                            48,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: carregando
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Criar uma conta',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta? ',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Iniciar sessão',
                              style: TextStyle(
                                color: azulBotao,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}