import 'package:flutter/material.dart';

import '../style/app_thema.dart';
import 'contredsenha.dart';

class RedefinirSenhaPage extends StatelessWidget {
  const RedefinirSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo claro
      backgroundColor: AppColors.background,

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(24),
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

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Endereço de email',
                    hintText: 'você@exemplo.com',
                    prefixIcon: const Icon(
                      Icons.mail_outline,
                      color: AppColors.primaryBlue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const RedefinirSenhaConfirmacaoPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Enviar link de redefinição',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    // Volta para o Login
                    Navigator.pop(context);
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
