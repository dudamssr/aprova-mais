import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import '../simulado.dart';

class SimuladoResultadoPage extends StatelessWidget {
  final String modo;
  final String materia;
  final bool usarCronometro;
  final List<Map<String, dynamic>> questoes;
  final List<String?> respostas;

  const SimuladoResultadoPage({
    super.key,
    required this.modo,
    required this.materia,
    required this.usarCronometro,
    required this.questoes,
    required this.respostas,
  });

  int get acertos {
    int total = 0;

    for (int i = 0; i < questoes.length; i++) {
      if (respostas[i] == questoes[i]['correta']) {
        total++;
      }
    }

    return total;
  }

  String get nomeModo {
    switch (modo) {
      case 'completo':
        return 'Simulado Completo';
      case 'materia':
        return 'Matéria: $materia';
      case 'personalizado':
        return 'Simulado Personalizado';
      default:
        return 'Simulado';
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentual = questoes.isEmpty
        ? 0
        : (acertos / questoes.length * 100).round();

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F8),
      drawer: const AppDrawer(selectedLabel: 'Simulado'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        title: const Text(
          'Resultado',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E3A8A),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF223A63), Color(0xFF3E6296)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 54,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Simulado finalizado!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  nomeModo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 22),
                Text(
                  '$percentual%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'de aproveitamento',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _resumoCard(
                  titulo: 'Acertos',
                  valor: '$acertos',
                  cor: Colors.green,
                  icone: Icons.check_circle_outline,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _resumoCard(
                  titulo: 'Erros',
                  valor: '${questoes.length - acertos}',
                  cor: Colors.red,
                  icone: Icons.cancel_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Correção das questões',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF102F55),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(questoes.length, (index) {
            final questao = questoes[index];
            final respostaCorreta = questao['correta'] as String;
            final respostaUsuario = respostas[index];
            final acertou = respostaUsuario == respostaCorreta;

            return Card(
              color: Colors.white,
              elevation: 1,
              margin: const EdgeInsets.only(bottom: 14),
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
                          acertou ? Icons.check_circle : Icons.cancel,
                          color: acertou ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Questão ${index + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      questao['enunciado'] as String,
                      style: const TextStyle(
                        color: Color(0xFF102F55),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sua resposta: ${respostaUsuario ?? 'Não respondida'}',
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Resposta correta: $respostaCorreta',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF3F8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        questao['resolucao'] as String,
                        style: const TextStyle(
                          color: Color(0xFF102F55),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const SimuladoPage()),
                  (route) => route.isFirst,
                );
              },
              icon: const Icon(Icons.settings_outlined),
              label: const Text(
                'Voltar às configurações',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E6296),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumoCard({
    required String titulo,
    required String valor,
    required Color cor,
    required IconData icone,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icone, color: cor, size: 28),
          const SizedBox(height: 8),
          Text(
            valor,
            style: TextStyle(
              color: cor,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            titulo,
            style: const TextStyle(color: Color(0xFF5275A6), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
