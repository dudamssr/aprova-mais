import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';

class SimuladoCorrecaoPage extends StatelessWidget {
  const SimuladoCorrecaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final correcao = [
      QuestaoCorrecao(
        enunciado: 'Questão 1: Enunciado...',
        respostaUsuario: 'A',
        respostaCorreta: 'B',
        resolucao: 'Explicação detalhada da questão.',
        acertou: false,
      ),
      QuestaoCorrecao(
        enunciado: 'Questão 2: Enunciado...',
        respostaUsuario: 'C',
        respostaCorreta: 'C',
        resolucao: 'Explicação detalhada da questão.',
        acertou: true,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F8),
      drawer: const AppDrawer(selectedLabel: 'Simulado'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/logo2.png',
                  width: 22,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 22,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Correção',
              style: TextStyle(
                color: Color(0xFF1E3A8A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF1E3A8A)),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: correcao.length,
        itemBuilder: (context, index) {
          final q = correcao[index];

          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        q.acertou ? Icons.check_circle : Icons.cancel,
                        color: q.acertou ? Colors.green : Colors.red,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          q.enunciado,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sua resposta: ${q.respostaUsuario}',
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Resposta correta: ${q.respostaCorreta}',
                    style: TextStyle(
                      color: q.acertou ? Colors.green : Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline_rounded,
                              color: Color(0xFF3E6296),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Resolução',
                              style: TextStyle(
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          q.resolucao,
                          style: const TextStyle(
                            color: Colors.black87,
                            height: 1.5,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuestaoCorrecao {
  final String enunciado;
  final String respostaUsuario;
  final String respostaCorreta;
  final String resolucao;
  final bool acertou;

  const QuestaoCorrecao({
    required this.enunciado,
    required this.respostaUsuario,
    required this.respostaCorreta,
    required this.resolucao,
    required this.acertou,
  });
}
