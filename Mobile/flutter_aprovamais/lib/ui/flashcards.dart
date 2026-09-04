import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../widgets/app_drawer.dart';
import '../widgets/flashcard.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> {
  String filtro = 'Todas';
  String materiaSelecionada = 'Todas as matérias';

  final List<Map<String, dynamic>> flashcards = [
    {
      'subject': 'Matemática',
      'question': 'O que é uma função?',
      'answer':
          'É uma relação que associa cada elemento de um conjunto a exatamente um elemento de outro conjunto.',
      'explanation':
          'No ENEM, funções aparecem bastante em situações do cotidiano, como gráficos, preços, tarifas e crescimento.',
      'aprendido': false,
      'favorito': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtrados = flashcards
        .where((card) {
          if (filtro == 'Revisões pendentes') return !card['aprendido'];
          if (filtro == 'Favoritas') return card['favorito'];
          return true;
        })
        .where((card) {
          if (materiaSelecionada == 'Todas as matérias') return true;
          return card['subject'] == materiaSelecionada;
        })
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(selectedLabel: 'Flashcards'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _TopBar(),
            const SizedBox(height: 16),

            const Text(
              'Sistema de revisão inteligente com flashcards',
              style: TextStyle(color: textDark, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Estatísticas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatCard(
                  label: 'Total',
                  value: '${flashcards.length}',
                  icon: Icons.layers,
                ),
                _StatCard(
                  label: 'Aprendidos',
                  value: '${flashcards.where((c) => c['aprendido']).length}',
                  icon: Icons.check_circle,
                ),
                _StatCard(
                  label: 'Pendentes',
                  value: '${flashcards.where((c) => !c['aprendido']).length}',
                  icon: Icons.refresh,
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Filtros
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _FilterChip(
                  label: 'Todas',
                  selected: filtro == 'Todas',
                  onTap: () => setState(() => filtro = 'Todas'),
                ),
                _FilterChip(
                  label: 'Revisões pendentes',
                  selected: filtro == 'Revisões pendentes',
                  onTap: () => setState(() => filtro = 'Revisões pendentes'),
                ),
                _FilterChip(
                  label: 'Favoritas',
                  selected: filtro == 'Favoritas',
                  onTap: () => setState(() => filtro = 'Favoritas'),
                ),
                _DropdownFilter(
                  value: materiaSelecionada,
                  onChanged: (v) => setState(() => materiaSelecionada = v!),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Lista de flashcards filtrados
            if (filtrados.isEmpty)
              const Center(
                child: Text(
                  'Nenhum flashcard neste filtro.',
                  style: TextStyle(color: textDark, fontSize: 16),
                ),
              )
            else
              for (final card in filtrados) ...[
                Flashcard(
                  subject: card['subject'],
                  question: card['question'],
                  answer: card['answer'],
                  explanation: card['explanation'],
                  favorito: card['favorito'],
                  textColor: textDark,
                  onFavoritar: () =>
                      setState(() => card['favorito'] = !card['favorito']),
                ),
                const SizedBox(height: 10),
                if (!card['aprendido'])
                  ElevatedButton.icon(
                    onPressed: () => setState(() => card['aprendido'] = true),
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Marcar como aprendido'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: textDark,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 6),
                        Text(
                          'Aprendido',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
              ],
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: primaryColor, // voltou para o azul original da logo
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
              'Flashcards',
              style: TextStyle(
                color: Color(0xFF2457C5), // azul médio para o título
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color(0xFF102F55),
            ), // azul escuro para o menu
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
    );
  }
}

// COMPONENTES DE UI
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF299FD6), size: 24), // azul claro
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          Text(label, style: const TextStyle(fontSize: 13, color: textMedium)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Color(0xFF299FD6), // azul claro
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : textDark,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => onTap(),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const _DropdownFilter({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: const [
            DropdownMenuItem(
              value: 'Todas as matérias',
              child: Text('Todas as matérias'),
            ),
            DropdownMenuItem(value: 'Matemática', child: Text('Matemática')),
            DropdownMenuItem(value: 'Português', child: Text('Português')),
            DropdownMenuItem(value: 'História', child: Text('História')),
            DropdownMenuItem(value: 'Geografia', child: Text('Geografia')),
            DropdownMenuItem(value: 'Biologia', child: Text('Biologia')),
            DropdownMenuItem(value: 'Física', child: Text('Física')),
            DropdownMenuItem(value: 'Química', child: Text('Química')),
            DropdownMenuItem(value: 'Literatura', child: Text('Literatura')),
            DropdownMenuItem(value: 'Redação', child: Text('Redação')),
            DropdownMenuItem(value: 'Filosofia', child: Text('Filosofia')),
            DropdownMenuItem(value: 'Sociologia', child: Text('Sociologia')),
          ],
          onChanged: onChanged,
          style: const TextStyle(
            color: Color(0xFF102F55), // azul escuro para texto
            fontSize: 15,
          ),
          dropdownColor: Colors.white, // fundo branco no menu
          iconEnabledColor: Color(0xFF299FD6), // ícone da setinha em azul claro
        ),
      ),
    );
  }
}
