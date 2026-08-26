// lib/ui/cadastro.dart
import 'package:flutter/material.dart';
import 'package:flutter_aprovamais/ui/home.dart';

import 'home_screen.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

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
                // Ícone superior
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: azulBotao,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 20),

                // Título
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
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Card de cadastro
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Botão Google
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

                      // Campo de e-mail
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

                      // Campo de senha
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: azulBotao,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Campo confirmar senha
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirme sua senha',
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: azulBotao,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // Botão criar conta
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
                          'Criar uma conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Link para login com navegação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta? ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
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
