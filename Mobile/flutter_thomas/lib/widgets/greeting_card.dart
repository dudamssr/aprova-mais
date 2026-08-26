import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
 
class GreetingCard extends StatelessWidget {
  final String greeting; // "Boa tarde, bem-vindo de volta"
  final String userName;
  final double goalPercent; // 0.0 - 1.0
  final String hoursDone;
  final String hoursTotal;
  final VoidCallback? onAskAI;
 
  const GreetingCard({
    super.key,
    required this.greeting,
    required this.userName,
    required this.goalPercent,
    required this.hoursDone,
    required this.hoursTotal,
    this.onAskAI,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.heroGradientStart, AppColors.heroGradientEnd],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  color: AppColors.white70,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 4),
              const Text('👋', style: TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.25,
              ),
              children: [
                TextSpan(text: '$userName, vamos estudar\nhoje!'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AppColors.white70,
                fontSize: 14,
              ),
              children: [
                const TextSpan(text: 'Você está a '),
                TextSpan(
                  text: '${(goalPercent * 100).round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const TextSpan(text: ' da sua meta semanal. Continue assim!'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Material(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onAskAI,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Tirar dúvida com IA',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meta diária',
                style: TextStyle(color: AppColors.white70, fontSize: 13),
              ),
              Text(
                '${(goalPercent * 100).round()}% • $hoursDone de $hoursTotal',
                style: const TextStyle(color: AppColors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: goalPercent,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.18),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}