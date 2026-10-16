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
          'No ENEM, funções aparecem em situações do cotidiano, como gráficos, preços e crescimento.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Português',
      'question': 'O que é uma oração?',
      'answer':
          'É um enunciado organizado em torno de um verbo ou locução verbal.',
      'explanation':
          'Identificar os verbos ajuda a reconhecer orações e analisar períodos simples e compostos.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'História',
      'question': 'Quando ocorreu a Independência do Brasil?',
      'answer': 'Em 7 de setembro de 1822.',
      'explanation':
          'Dom Pedro proclamou a Independência, rompendo os vínculos políticos com Portugal.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Geografia',
      'question': 'O que é globalização?',
      'answer':
          'É o processo de integração econômica, cultural, social e tecnológica entre países.',
      'explanation':
          'No ENEM, aparece em questões sobre comércio internacional, tecnologia e desigualdade.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Biologia',
      'question': 'Qual é a função da mitocôndria?',
      'answer':
          'Produzir a maior parte do ATP utilizado pela célula na respiração celular.',
      'explanation':
          'O ATP fornece energia para diversas atividades celulares.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Química',
      'question': 'O que é uma ligação covalente?',
      'answer':
          'É uma ligação química formada pelo compartilhamento de pares de elétrons.',
      'explanation':
          'Ocorre geralmente entre átomos de elementos não metálicos.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Inglês',
      'question': 'O que são cognatos?',
      'answer':
          'São palavras de idiomas diferentes que possuem origem e significado semelhantes.',
      'explanation':
          'Exemplo: “important”, em inglês, e “importante”, em português.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Literatura',
      'question': 'Qual é uma característica do Modernismo brasileiro?',
      'answer':
          'A valorização da identidade nacional e a liberdade de expressão artística.',
      'explanation':
          'A Semana de Arte Moderna de 1922 foi um marco do Modernismo no Brasil.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Redação',
      'question': 'Quais são as partes básicas de uma redação do ENEM?',
      'answer': 'Introdução, desenvolvimento e conclusão.',
      'explanation':
          'A conclusão deve apresentar uma proposta de intervenção que respeite os direitos humanos.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Filosofia',
      'question': 'O que é ética?',
      'answer':
          'É a reflexão sobre os princípios e valores que orientam as ações humanas.',
      'explanation':
          'Questões de ética envolvem responsabilidade, justiça, liberdade e convivência social.',
      'aprendido': false,
      'favorito': false,
    },
    {
      'subject': 'Sociologia',
      'question': 'O que é desigualdade social?',
      'answer':
          'É a distribuição desigual de recursos, direitos e oportunidades na sociedade.',
      'explanation':
          'Pode envolver diferenças de renda e de acesso à educação, saúde e moradia.',
      'aprendido': false,
      'favorito': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtrados = flashcards.where((card) {
      if (filtro == 'Revisões pendentes' && card['aprendido']) {
        return false;
      }

      if (filtro == 'Favoritas' && !card['favorito']) {
        return false;
      }

      if (materiaSelecionada != 'Todas as matérias' &&
          card['subject'] != materiaSelecionada) {
        return false;
      }

      return true;
    }).toList();

    final aprendidos = flashcards
        .where((card) => card['aprendido'] == true)
        .length;

    final pendentes = flashcards
        .where((card) => card['aprendido'] == false)
        .length;

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
              children: [
                Expanded(
                  child: _StatCard(
                    label: 'Total',
                    value: '${flashcards.length}',
                    icon: Icons.layers,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatCard(
                    label: 'Aprendidos',
                    value: '$aprendidos',
                    icon: Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _StatCard(
                    label: 'Pendentes',
                    value: '$pendentes',
                    icon: Icons.refresh,
                  ),
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
                  onTap: () {
                    setState(() {
                      filtro = 'Todas';
                    });
                  },
                ),
                _FilterChip(
                  label: 'Revisões pendentes',
                  selected: filtro == 'Revisões pendentes',
                  onTap: () {
                    setState(() {
                      filtro = 'Revisões pendentes';
                    });
                  },
                ),
                _FilterChip(
                  label: 'Favoritas',
                  selected: filtro == 'Favoritas',
                  onTap: () {
                    setState(() {
                      filtro = 'Favoritas';
                    });
                  },
                ),
                _DropdownFilter(
                  value: materiaSelecionada,
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        materiaSelecionada = v;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Lista de flashcards
            if (filtrados.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    'Nenhum flashcard neste filtro.',
                    style: TextStyle(color: textDark, fontSize: 16),
                  ),
                ),
              )
            else
              for (final card in filtrados) ...[
                Flashcard(
                  subject: card['subject'] as String,
                  question: card['question'] as String,
                  answer: card['answer'] as String,
                  explanation: card['explanation'] as String,
                  favorito: card['favorito'] as bool,
                  textColor: textDark,
                  onFavoritar: () {
                    setState(() {
                      card['favorito'] = !(card['favorito'] as bool);
                    });
                  },
                ),
                const SizedBox(height: 10),

                if (!(card['aprendido'] as bool))
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        card['aprendido'] = true;
                      });
                    },
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

// BARRA SUPERIOR
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
              'Flashcards',
              style: TextStyle(
                color: Color(0xFF2457C5),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF102F55)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
    );
  }
}

// CARD DE ESTATÍSTICAS
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF299FD6), size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: textMedium),
          ),
        ],
      ),
    );
  }
}

// FILTRO
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
      selectedColor: const Color(0xFF299FD6),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : textDark,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => onTap(),
    );
  }
}

// FILTRO POR MATÉRIA
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
          isExpanded: false,
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
            DropdownMenuItem(value: 'Química', child: Text('Química')),
            DropdownMenuItem(value: 'Inglês', child: Text('Inglês')),
            DropdownMenuItem(value: 'Literatura', child: Text('Literatura')),
            DropdownMenuItem(value: 'Redação', child: Text('Redação')),
            DropdownMenuItem(value: 'Filosofia', child: Text('Filosofia')),
            DropdownMenuItem(value: 'Sociologia', child: Text('Sociologia')),
          ],
          onChanged: onChanged,
          style: const TextStyle(color: Color(0xFF102F55), fontSize: 15),
          dropdownColor: Colors.white,
          iconEnabledColor: const Color(0xFF299FD6),
        ),
      ),
    );
  }
}
