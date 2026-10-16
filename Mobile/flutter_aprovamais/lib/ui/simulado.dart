import 'package:flutter/material.dart';
import 'simuladoTelas/simulado_execucao.dart';
import '../widgets/app_drawer.dart';

class SimuladoPage extends StatefulWidget {
  const SimuladoPage({super.key});

  @override
  State<SimuladoPage> createState() => _SimuladoPageState();
}

class _SimuladoPageState extends State<SimuladoPage> {
  String selectedMode = '';
  String selectedSubject = '';
  bool useTimer = true;

  static const Color azul = Color(0xFF1E3A8A);
  static const Color azulMedio = Color(0xFF356DB8);
  static const Color fundo = Color(0xFFF0F7FD);
  static const Color borda = Color(0xFFD4E7FA);
  static const Color azulSelecionado = Color(0xFFE5F2FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      drawer: const AppDrawer(selectedLabel: 'Simulado'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 72,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
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
              const SizedBox(width: 10),
              const Text(
                'Simulados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: azul,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              padding: const EdgeInsets.only(right: 20),
              icon: const Icon(Icons.menu, color: azul, size: 26),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: borda),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        children: [
          const Text(
            'Escolha o tipo de simulado e comece quando estiver pronto',
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              color: Color(0xFF5275A6),
            ),
          ),
          const SizedBox(height: 26),
          _buildCard(
            'Simulado Completo',
            'Todas as matérias',
            'completo',
            Icons.description_outlined,
          ),
          _buildCard(
            'Por Matéria',
            'Escolha uma disciplina',
            'materia',
            Icons.bar_chart,
          ),
          _buildCard(
            'Personalizado',
            'Você seleciona',
            'personalizado',
            Icons.tune,
          ),
          if (selectedMode == 'materia') ...[
            const SizedBox(height: 8),
            _buildSubjectSelector(),
          ],
          const SizedBox(height: 12),
          _buildTimerSection(),
          const SizedBox(height: 26),
          SizedBox(
            height: 68,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [azul, azulMedio],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: azul.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _iniciarSimulado,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Iniciar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, String mode, IconData icon) {
    final selected = selectedMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = mode;
          if (mode != 'materia') {
            selectedSubject = '';
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.fromLTRB(22, 23, 18, 22),
        decoration: BoxDecoration(
          color: selected ? azulSelecionado : Colors.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: selected ? azulMedio : borda,
            width: selected ? 2 : 1.5,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: azul.withValues(alpha: 0.12),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: selected ? null : const Color(0xFFE8F2FC),
                gradient: selected
                    ? const LinearGradient(
                        colors: [Color(0xFF4A79BA), Color(0xFF91BCE9)],
                      )
                    : null,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: selected ? Colors.white : const Color(0xFF52729D),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: azul,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Color(0xFF5275A6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectSelector() {
    const subjects = [
      'Matemática',
      'Português',
      'História',
      'Geografia',
      'Biologia',
      'Física',
      'Química',
      'Literatura',
      'Redação',
      'Filosofia',
      'Sociologia',
      'Inglês',
      'Espanhol',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Escolha a matéria',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: azul,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: subjects.map((subject) {
              final selected = selectedSubject == subject;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedSubject = subject);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? azul : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: selected ? azul : borda),
                  ),
                  child: Text(
                    subject,
                    style: TextStyle(
                      fontSize: 14,
                      color: selected ? Colors.white : azul,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borda),
        boxShadow: [
          BoxShadow(
            color: azul.withValues(alpha: 0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFE3F1FC),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.timer_outlined,
                  color: azulMedio,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Cronômetro',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: azul,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildTimerOption(
                  icon: Icons.timer_outlined,
                  title: 'Com\ncronômetro',
                  subtitle: '30 minutos',
                  selected: useTimer,
                  onTap: () => setState(() => useTimer = true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTimerOption(
                  icon: Icons.access_time,
                  title: 'Sem\ncronômetro',
                  subtitle: 'No seu ritmo',
                  selected: !useTimer,
                  onTap: () => setState(() => useTimer = false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: const BoxConstraints(minHeight: 140),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEEF6FD) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? azulMedio : borda,
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? azulMedio : const Color(0xFF52729D),
              size: 28,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.25,
                color: azul,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Color(0xFF5275A6)),
            ),
          ],
        ),
      ),
    );
  }

  void _iniciarSimulado() {
    if (selectedMode.isEmpty) {
      _mostrarMensagem('Escolha um tipo de simulado para continuar.');
      return;
    }

    if (selectedMode == 'materia' && selectedSubject.isEmpty) {
      _mostrarMensagem('Escolha uma matéria para continuar.');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SimuladoExecucaoPage(
          modo: selectedMode,
          materia: selectedSubject,
          usarCronometro: useTimer,
        ),
      ),
    );
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }
}
