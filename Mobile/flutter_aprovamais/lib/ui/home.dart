import 'package:flutter/material.dart';

import 'cadastro.dart';
import 'home_screen.dart';
import 'redsenha.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const fundoAzulClaro = Color(0xFFE8F0FE);
    const azulBotao = Color(0xFF3B5998);
    const azulTexto = Color(0xFF1A3C6E);

    return Scaffold(
      backgroundColor: fundoAzulClaro,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/logo2.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Bem vindo de volta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: azulTexto,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                const Text(
                  'Faça login na sua conta.',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Card de login
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
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset('assets/google_icon.png', height: 20),
                        label: const Text(
                          'Continuar com o Google',
                          style: TextStyle(color: Colors.black87),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          side: BorderSide(color: Colors.grey.shade300),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Separador
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'ou',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // E-mail
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'voce@exemplo.com',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: azulBotao,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Senha
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: azulBotao,
                          ),

                          suffixIcon: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RedefinirSenhaPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                color: azulBotao,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: azulBotao,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Conecte-se',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Cadastro
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Não tem uma conta? ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CadastroScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Crie uma.',
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
