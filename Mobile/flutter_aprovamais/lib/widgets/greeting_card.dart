import 'package:flutter/material.dart';

class GreetingCard extends StatelessWidget {
  final String greeting;
  final String userName;
  final double goalPercent;
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
        color: Colors.white, // fundo branco
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE7EDF3),
        ), // borda azul bem clara
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saudação
          Row(
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  color: Color(0xFF299FD6), // azul claro
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Text('👋', style: TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 6),

          // Nome do usuário
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF102F55), // azul escuro
                height: 1.25,
              ),
              children: [TextSpan(text: '$userName, vamos estudar\nhoje!')],
            ),
          ),
          const SizedBox(height: 10),

          // Meta semanal
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF8290A2),
                fontSize: 14,
              ), // cinza claro
              children: [
                const TextSpan(text: 'Você está a '),
                TextSpan(
                  text: '${(goalPercent * 100).round()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF299FD6), // azul claro em destaque
                  ),
                ),
                const TextSpan(text: ' da sua meta semanal. Continue assim!'),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Botão IA
          Material(
            color: const Color(0xFFEAF4FB), // azul bem claro
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
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF2457C5), // azul médio
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Tirar dúvida com IA',
                        style: TextStyle(
                          color: Color(0xFF2457C5), // azul médio
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

          // Meta diária
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meta diária',
                style: TextStyle(color: Color(0xFF8290A2), fontSize: 13),
              ),
              Text(
                '${(goalPercent * 100).round()}% • $hoursDone de $hoursTotal',
                style: const TextStyle(color: Color(0xFF8290A2), fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Barra de progresso
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: goalPercent,
              minHeight: 8,
              backgroundColor: const Color(0xFFEDF2F5), // azul bem claro
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF299FD6),
              ), // azul claro
            ),
          ),
        ],
      ),
    );
  }
}
