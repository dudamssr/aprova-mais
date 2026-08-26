import 'package:flutter/material.dart';
import '../style/app_thema.dart';

/// Tela temporária usada para itens do menu que ainda não têm
/// uma tela real implementada. Troque pela tela definitiva
/// assim que ela for criada.
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 56, color: AppColors.textLight),
            const SizedBox(height: 16),
            Text(
              '$title em construção',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
