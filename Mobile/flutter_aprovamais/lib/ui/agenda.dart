import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../widgets/app_drawer.dart';

class AgendaDeEstudosPage extends StatefulWidget {
  const AgendaDeEstudosPage({super.key});

  @override
  State<AgendaDeEstudosPage> createState() => _AgendaDeEstudosPageState();
}

class _AgendaDeEstudosPageState extends State<AgendaDeEstudosPage> {
  List tarefas = [];
  bool carregando = true;
  bool erro = false;
  DateTime diaSelecionado = DateTime.now();

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    setState(() {
      carregando = true;
      erro = false;
    });

    try {
      final baseUrl = dotenv.env['API_URL'] ?? 'http://10.0.2.2:3000';

      final response = await http.get(
        Uri.parse('$baseUrl/agenda/listar'),
        headers: {'Content-Type': 'application/json'},
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          tarefas = jsonDecode(response.body);
          carregando = false;
        });
      } else {
        setState(() {
          erro = true;
          carregando = false;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = true;
        carregando = false;
      });
    }
  }

  Future<void> _cadastrarTarefa() async {
    final messenger = ScaffoldMessenger.of(context);
    final hoje = DateTime.now();

    final dataFormatada =
        "${hoje.year.toString().padLeft(4, '0')}-"
        "${hoje.month.toString().padLeft(2, '0')}-"
        "${hoje.day.toString().padLeft(2, '0')}";

    try {
      final baseUrl = dotenv.env['API_URL'] ?? 'http://10.0.2.2:3000';

      final response = await http.post(
        Uri.parse('$baseUrl/agenda/adicionar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'titulo': 'Nova tarefa de ${hoje.day}/${hoje.month}',
          'data': dataFormatada,
          'horario': '10:00',
          'materia': 'Matemática',
          'tipo': 'Estudo',
          'prioridade': 'Alta',
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Tarefa cadastrada com sucesso!')),
        );

        await _carregarTarefas();
      } else {
        String erroMsg = 'Erro ao cadastrar.';

        try {
          erroMsg = jsonDecode(response.body)['erro'] ?? erroMsg;
        } catch (_) {}

        messenger.showSnackBar(SnackBar(content: Text(erroMsg)));
      }
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        const SnackBar(content: Text('Erro de conexão com o servidor.')),
      );
    }
  }

  List _tarefasDoDia(DateTime dia) {
    final dataFormatada =
        "${dia.year.toString().padLeft(4, '0')}-"
        "${dia.month.toString().padLeft(2, '0')}-"
        "${dia.day.toString().padLeft(2, '0')}";

    return tarefas.where((t) {
      final data = t['data']?.toString() ?? '';
      return data.startsWith(dataFormatada);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const Color azul = Color(0xFF1E40AF);
    const Color fundo = Color(0xFFF8FBFF);

    final hoje = DateTime.now();

    final inicioSemana = hoje.subtract(Duration(days: hoje.weekday % 7));

    final diasSemana = List.generate(
      7,
      (i) => inicioSemana.add(Duration(days: i)),
    );

    final tarefasDia = _tarefasDoDia(diaSelecionado);

    return Scaffold(
      backgroundColor: fundo,
      drawer: const AppDrawer(selectedLabel: 'Agenda'),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 72,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: azul,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: azul.withValues(alpha: 0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    'assets/logo2.png',
                    width: 26,
                    height: 26,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.school_rounded, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              const Flexible(
                child: Text(
                  'Agenda de Estudos',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: azul,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        actions: [
          IconButton(
            onPressed: _cadastrarTarefa,
            icon: const Icon(Icons.add_circle_outline, color: azul),
            tooltip: 'Nova tarefa',
          ),

          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: azul),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Organize sua rotina',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 5),

            const Text(
              'Agenda de Estudos',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),

            const SizedBox(height: 24),

            // Checklist de tarefas
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.checklist, color: azul),

                            SizedBox(width: 10),

                            Text(
                              'Checklist',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            '${tarefasDia.length} tarefas',
                            style: const TextStyle(color: azul),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    if (carregando)
                      const CircularProgressIndicator(color: azul)
                    else if (erro)
                      const Text(
                        'Erro ao carregar tarefas.',
                        style: TextStyle(color: Colors.grey),
                      )
                    else if (tarefasDia.isEmpty)
                      const Text(
                        'Nenhuma tarefa encontrada.',
                        style: TextStyle(color: Colors.grey),
                      )
                    else
                      Column(
                        children: tarefasDia.map((tarefa) {
                          return ListTile(
                            leading: const Icon(Icons.task_alt, color: azul),

                            title: Text(tarefa['titulo'] ?? 'Sem título'),

                            subtitle: Text(tarefa['materia'] ?? ''),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Seleção dos dias da semana
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: diasSemana.map((dia) {
                final isSelected =
                    dia.day == diaSelecionado.day &&
                    dia.month == diaSelecionado.month &&
                    dia.year == diaSelecionado.year;

                final isHoje =
                    dia.day == hoje.day &&
                    dia.month == hoje.month &&
                    dia.year == hoje.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      diaSelecionado = dia;
                    });
                  },

                  child: Container(
                    width: 50,
                    height: 70,

                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEFF6FF)
                          : Colors.transparent,

                      border: Border.all(
                        color: isSelected ? azul : Colors.transparent,
                      ),

                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _abreviacaoDia(dia.weekday),
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 5),

                        CircleAvatar(
                          radius: 15,

                          backgroundColor: isHoje
                              ? azul
                              : const Color(0xFFDCE6F9),

                          child: Text(
                            '${dia.day}',

                            style: TextStyle(
                              color: isHoje ? Colors.white : Colors.black,

                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _abreviacaoDia(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Seg';

      case DateTime.tuesday:
        return 'Ter';

      case DateTime.wednesday:
        return 'Qua';

      case DateTime.thursday:
        return 'Qui';

      case DateTime.friday:
        return 'Sex';

      case DateTime.saturday:
        return 'Sáb';

      default:
        return 'Dom';
    }
  }
}
