import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/app_drawer.dart';
import '../simuladoTelas/simulado.resultado.dart';

class SimuladoExecucaoPage extends StatefulWidget {
  final String modo;
  final String materia;
  final bool usarCronometro;

  const SimuladoExecucaoPage({
    super.key,
    required this.modo,
    required this.materia,
    required this.usarCronometro,
  });

  @override
  State<SimuladoExecucaoPage> createState() => _SimuladoExecucaoPageState();
}

class _SimuladoExecucaoPageState extends State<SimuladoExecucaoPage> {
  int questaoAtual = 0;
  int segundosRestantes = 30 * 60;
  Timer? timer;
  bool finalizado = false;

  final Set<int> questoesRevisao = {};
  final List<String?> respostas = List<String?>.filled(10, null);

  final List<Map<String, dynamic>> questoes = [
    {
      'materia': 'Matemática',
      'enunciado': 'Qual dos números abaixo é irracional?',
      'alternativas': ['3,14', '√9', '√2', '1/4', '0,5'],
      'correta': '√2',
      'resolucao':
          '√2 não pode ser expresso como fração de inteiros, portanto é irracional.',
      'dificuldade': 'fácil',
    },
    {
      'materia': 'Matemática',
      'enunciado': 'A função f(x) = 2x + 6 tem raiz igual a:',
      'alternativas': ['2', '−3', '3', '−6', '0'],
      'correta': '−3',
      'resolucao':
          'A raiz ocorre quando f(x) = 0. Então, 2x + 6 = 0, logo x = −3.',
      'dificuldade': 'médio',
    },
    {
      'materia': 'Português',
      'enunciado': 'Assinale a frase com erro de concordância:',
      'alternativas': [
        'Houve problemas',
        'Existem problemas',
        'Ocorreram problemas',
        'Aconteceram problemas',
        'Houveram problemas',
      ],
      'correta': 'Houveram problemas',
      'resolucao':
          'O verbo haver, no sentido de existir, é impessoal e fica no singular: “Houve problemas”.',
      'dificuldade': 'difícil',
    },
    {
      'materia': 'História',
      'enunciado': 'Em que ano ocorreu a Independência do Brasil?',
      'alternativas': ['1500', '1789', '1822', '1889', '1922'],
      'correta': '1822',
      'resolucao':
          'A Independência do Brasil foi proclamada em 7 de setembro de 1822.',
      'dificuldade': 'fácil',
    },
    {
      'materia': 'Geografia',
      'enunciado': 'Qual é o maior bioma brasileiro em extensão territorial?',
      'alternativas': [
        'Cerrado',
        'Caatinga',
        'Mata Atlântica',
        'Amazônia',
        'Pantanal',
      ],
      'correta': 'Amazônia',
      'resolucao':
          'A Amazônia é o maior bioma brasileiro em extensão territorial.',
      'dificuldade': 'fácil',
    },
    {
      'materia': 'Biologia',
      'enunciado':
          'Qual organela celular é responsável pela respiração celular?',
      'alternativas': [
        'Ribossomo',
        'Mitocôndria',
        'Lisossomo',
        'Complexo de Golgi',
        'Núcleo',
      ],
      'correta': 'Mitocôndria',
      'resolucao':
          'A mitocôndria é responsável pela maior parte da produção de ATP na respiração celular.',
      'dificuldade': 'médio',
    },
    {
      'materia': 'Química',
      'enunciado': 'Qual é a fórmula química da água?',
      'alternativas': ['CO2', 'O2', 'H2O', 'NaCl', 'H2'],
      'correta': 'H2O',
      'resolucao':
          'A molécula de água é formada por dois átomos de hidrogênio e um de oxigênio.',
      'dificuldade': 'fácil',
    },
    {
      'materia': 'Física',
      'enunciado':
          'Qual é a unidade de medida da força no Sistema Internacional?',
      'alternativas': ['Joule', 'Watt', 'Pascal', 'Newton', 'Volt'],
      'correta': 'Newton',
      'resolucao':
          'A força é medida em newtons (N) no Sistema Internacional de Unidades.',
      'dificuldade': 'médio',
    },
    {
      'materia': 'Inglês',
      'enunciado': 'Qual é a tradução correta de “book”?',
      'alternativas': ['Mesa', 'Livro', 'Caderno', 'Caneta', 'Janela'],
      'correta': 'Livro',
      'resolucao': 'A palavra inglesa “book” significa “livro” em português.',
      'dificuldade': 'fácil',
    },
    {
      'materia': 'Sociologia',
      'enunciado': 'O que significa desigualdade social?',
      'alternativas': [
        'Distribuição igual de renda',
        'Ausência de diferenças culturais',
        'Diferenças no acesso a recursos e oportunidades',
        'Fim dos problemas econômicos',
        'Igualdade de condições para todos',
      ],
      'correta': 'Diferenças no acesso a recursos e oportunidades',
      'resolucao':
          'A desigualdade social envolve diferenças no acesso à renda, educação, saúde e outras oportunidades.',
      'dificuldade': 'difícil',
    },
  ];

  String? get respostaSelecionada => respostas[questaoAtual];

  bool get marcadaRevisao => questoesRevisao.contains(questaoAtual);

  String get nomeModo {
    switch (widget.modo) {
      case 'completo':
        return 'Simulado Completo';
      case 'materia':
        return 'Matéria: ${widget.materia}';
      case 'personalizado':
        return 'Simulado Personalizado';
      default:
        return 'Simulado';
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.usarCronometro) {
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (!mounted || finalizado) {
          t.cancel();
          return;
        }

        if (segundosRestantes <= 1) {
          t.cancel();
          setState(() => segundosRestantes = 0);
          _finalizarSimulado();
        } else {
          setState(() => segundosRestantes--);
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get tempoFormatado {
    final minutos = segundosRestantes ~/ 60;
    final segundos = segundosRestantes % 60;

    return '${minutos.toString().padLeft(2, '0')}:'
        '${segundos.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final questao = questoes[questaoAtual];
    final alternativas = questao['alternativas'] as List<String>;
    final dificuldade = questao['dificuldade'] as String;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF3F8),
      drawer: const AppDrawer(selectedLabel: 'Simulado'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        title: Text(
          nomeModo,
          style: const TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          if (widget.usarCronometro)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  tempoFormatado,
                  style: const TextStyle(
                    color: Color(0xFF1E3A8A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Seu progresso',
                    style: TextStyle(
                      color: Color(0xFF102F55),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${questaoAtual + 1} de ${questoes.length}',
                    style: const TextStyle(
                      color: Color(0xFF3E6296),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (questaoAtual + 1) / questoes.length,
                  minHeight: 8,
                  color: const Color(0xFF5B8DEF),
                  backgroundColor: const Color(0xFFDCE6F3),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAF1FF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    questao['materia'] as String,
                                    style: const TextStyle(
                                      color: Color(0xFF1E3A8A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: dificuldade == 'fácil'
                                      ? const Color(0xFFDFF8E1)
                                      : dificuldade == 'médio'
                                      ? const Color(0xFFFFF4E5)
                                      : const Color(0xFFFFE5E5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  dificuldade.toUpperCase(),
                                  style: TextStyle(
                                    color: dificuldade == 'fácil'
                                        ? const Color(0xFF2E7D32)
                                        : dificuldade == 'médio'
                                        ? const Color(0xFFEF6C00)
                                        : const Color(0xFFD32F2F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            questao['enunciado'] as String,
                            style: const TextStyle(
                              color: Color(0xFF102F55),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ...alternativas.map((alternativa) {
                            final selecionada =
                                respostaSelecionada == alternativa;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () {
                                  setState(() {
                                    respostas[questaoAtual] = alternativa;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 13,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selecionada
                                        ? const Color(0xFFEAF1FF)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: selecionada
                                          ? const Color(0xFF5B8DEF)
                                          : const Color(0xFFE0E7F0),
                                      width: selecionada ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 34,
                                        height: 34,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: selecionada
                                              ? const Color(0xFF3E6296)
                                              : const Color(0xFFEFF3F8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          String.fromCharCode(
                                            65 +
                                                alternativas.indexOf(
                                                  alternativa,
                                                ),
                                          ),
                                          style: TextStyle(
                                            color: selecionada
                                                ? Colors.white
                                                : const Color(0xFF1E3A8A),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          alternativa,
                                          style: const TextStyle(
                                            color: Color(0xFF102F55),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        selecionada
                                            ? Icons.check_circle
                                            : Icons.circle_outlined,
                                        color: selecionada
                                            ? const Color(0xFF3E6296)
                                            : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    color: marcadaRevisao
                        ? Colors.red
                        : const Color(0xFF3E6296),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (marcadaRevisao) {
                          questoesRevisao.remove(questaoAtual);
                        } else {
                          questoesRevisao.add(questaoAtual);
                        }
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            marcadaRevisao
                                ? 'Questão marcada para revisão.'
                                : 'Questão desmarcada da revisão.',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      marcadaRevisao ? 'Revisar depois' : 'Marcar revisão',
                      style: const TextStyle(color: Color(0xFF3E6296)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: questaoAtual > 0
                          ? () {
                              setState(() {
                                questaoAtual--;
                              });
                            }
                          : null,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3E6296),
                        minimumSize: const Size(0, 50),
                        side: const BorderSide(color: Color(0xFF3E6296)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Anterior'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _proximaOuFinalizar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E6296),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 50),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        questaoAtual < questoes.length - 1
                            ? 'Próxima'
                            : 'Finalizar',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _proximaOuFinalizar() {
    if (respostaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecione uma alternativa antes de continuar.'),
        ),
      );
      return;
    }

    if (questaoAtual < questoes.length - 1) {
      setState(() {
        questaoAtual++;
      });
    } else {
      _finalizarSimulado();
    }
  }

  void _finalizarSimulado() {
    if (finalizado || !mounted) return;

    finalizado = true;
    timer?.cancel();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SimuladoResultadoPage(
          modo: widget.modo,
          materia: widget.materia,
          usarCronometro: widget.usarCronometro,
          questoes: questoes,
          respostas: List<String?>.from(respostas),
        ),
      ),
    );
  }
}
