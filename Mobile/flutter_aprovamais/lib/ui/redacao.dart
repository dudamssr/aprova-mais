import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../style/colors.dart';
import '../widgets/app_drawer.dart';

class RedacaoScreen extends StatefulWidget {
  const RedacaoScreen({super.key});

  @override
  State<RedacaoScreen> createState() => _RedacaoScreenState();
}

class _RedacaoScreenState extends State<RedacaoScreen> {
  final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  String tema = '';
  String proposta = '';
  bool carregando = false;

  // Lista para armazenar o histórico de temas
  List<Map<String, String>> historicoTemas = [];

  @override
  void initState() {
    super.initState();
    // Tema fixo para testar o histórico
    historicoTemas = [
      {
        'tema': 'Impactos da tecnologia na educação',
        'proposta':
            'Discutir como o uso de ferramentas digitais transforma o aprendizado e os desafios da inclusão digital.',
      },
    ];
  }

  // ============================================================
  // GERAR TEMA COM IA (OpenAI)
  // ============================================================
  Future<void> gerarTema() async {
    if (carregando) return;

    setState(() {
      carregando = true;
    });

    try {
      final resposta = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': '''
Você é um especialista em redação do ENEM.
Crie propostas de redação no estilo ENEM com:
1. Um tema atual e relevante.
2. Uma proposta explicando o problema a ser discutido.
Responda SOMENTE em JSON neste formato:
{
  "tema": "tema da redação",
  "proposta": "proposta de redação"
}
''',
            },
            {
              'role': 'user',
              'content': '''
Gere uma nova proposta de redação para um estudante que está se preparando para o ENEM.
Escolha um assunto relevante da sociedade brasileira.
''',
            },
          ],
          'temperature': 0.9,
        }),
      );

      if (resposta.statusCode == 429) {
        setState(() {
          carregando = false;
          tema = 'Limite de requisições atingido';
          proposta = 'Aguarde alguns segundos antes de tentar novamente.';
        });
        return;
      }

      if (resposta.statusCode == 200) {
        final dados = jsonDecode(resposta.body);
        String conteudo = dados['choices'][0]['message']['content'];

        conteudo = conteudo
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        final resultado = jsonDecode(conteudo);

        if (!mounted) return;

        setState(() {
          tema = resultado['tema'] ?? 'Tema não encontrado';
          proposta = resultado['proposta'] ?? 'Proposta não encontrada';
          carregando = false;

          // Adiciona ao histórico
          historicoTemas.insert(0, {'tema': tema, 'proposta': proposta});
        });
      } else {
        setState(() {
          carregando = false;
          tema = 'Não foi possível gerar o tema';
          proposta = 'Erro ${resposta.statusCode}: ${resposta.reasonPhrase}';
        });
      }
    } catch (erro) {
      if (!mounted) return;
      setState(() {
        carregando = false;
        tema = 'Erro ao gerar o tema';
        proposta = 'Não foi possível conectar com a API. Tente novamente.';
      });
      debugPrint('Erro na API: $erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(selectedLabel: 'Redação'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            // TOPO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/logo2.png',
                        width: 28,
                        height: 28,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Redação',
                      style: TextStyle(
                        color: Color(0xFF2457C5),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF102F55)),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Pratique sua escrita e prepare-se para o ENEM',
              style: TextStyle(color: Color(0xFF8290A2), fontSize: 15),
            ),
            const SizedBox(height: 20),

            // CARD DA IA
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF223A63), Color(0xFF3E6296)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: carregando
                  ? const Column(
                      children: [
                        SizedBox(height: 15),
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 18),
                        Text(
                          'A IA está preparando seu tema...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 22,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Tema gerado pela IA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tema,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Proposta de redação',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          proposta,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 16),

            // BOTÃO NOVO TEMA
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: carregando ? null : gerarTema,
                icon: const Icon(Icons.auto_awesome, color: Color(0xFF2457C5)),
                label: const Text(
                  'Gerar outro tema com IA',
                  style: TextStyle(
                    color: Color(0xFF2457C5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFFE7EDF3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // INFORMAÇÃO
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F8FC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7EDF3)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline, color: Color(0xFF299FD6)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Leia o tema com atenção, organize seus argumentos e desenvolva uma proposta de intervenção.',
                      style: TextStyle(
                        color: Color(0xFF607D8B),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // HISTÓRICO DE TEMAS
            if (historicoTemas.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Histórico de temas gerados',
                    style: TextStyle(
                      color: Color(0xFF2457C5),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...historicoTemas.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F8FC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE7EDF3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['tema'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF0D47A1),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['proposta'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF607D8B),
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
