import 'package:flutter/material.dart';

import 'home.dart';
import '../style/app_thema.dart';

class RedefinirSenhaConfirmacaoPage extends StatelessWidget {
  const RedefinirSenhaConfirmacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo claro
      backgroundColor: AppColors.background,

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 350,
            decoration: BoxDecoration(
              // Card branco
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.email_outlined,
                  size: 64,
                  color: AppColors.primaryBlue,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Redefinir senha',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Enviaremos um link para você redefinir as configurações de segurança.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.textMedium),
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.heroGradientStart,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Se existir uma conta com esse endereço de e-mail, '
                    'você receberá um link para redefinir sua senha em breve.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 24),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    '← Voltar para a página de login',
                    style: TextStyle(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
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
