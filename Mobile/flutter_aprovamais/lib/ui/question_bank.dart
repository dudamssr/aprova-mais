import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/question_card.dart';
import '../widgets/app_drawer.dart';

class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  final List<Question> questions = [
    Question(
      id: '1',
      subject: 'Matemática',
      topic: 'Conjuntos Numéricos',
      difficulty: 'fácil',
      yearAndExam: '2023 • ENEM',
      questionText: 'Qual dos números abaixo é irracional?',
      options: [
        QuestionOption(letter: 'a', text: '3,14'),
        QuestionOption(letter: 'b', text: '√9'),
        QuestionOption(letter: 'c', text: '√2'),
        QuestionOption(letter: 'd', text: '1/4'),
        QuestionOption(letter: 'e', text: '0,5'),
      ],
    ),
    Question(
      id: '2',
      subject: 'Matemática',
      topic: 'Funções do 1º Grau',
      difficulty: 'média',
      yearAndExam: '2022 • ENEM',
      questionText: 'A função f(x) = 2x + 6 tem raiz igual a:',
      options: [
        QuestionOption(letter: 'a', text: 'x = 3'),
        QuestionOption(letter: 'b', text: 'x = -3'),
        QuestionOption(letter: 'c', text: 'x = 6'),
        QuestionOption(letter: 'd', text: 'x = -6'),
        QuestionOption(letter: 'e', text: 'x = 0'),
      ],
    ),
    Question(
      id: '3',
      subject: 'Biologia',
      topic: 'Ecologia',
      difficulty: 'fácil',
      yearAndExam: '2023 • ENEM',
      questionText:
          'Qual das seguintes relações ecológicas é considerada harmônica e interespecífica?',
      options: [
        QuestionOption(letter: 'a', text: 'Canibalismo'),
        QuestionOption(letter: 'b', text: 'Predatismo'),
        QuestionOption(letter: 'c', text: 'Mutualismo'),
        QuestionOption(letter: 'd', text: 'Competição'),
        QuestionOption(letter: 'e', text: 'Parasitismo'),
      ],
    ),
    Question(
      id: '4',
      subject: 'Física',
      topic: 'Cinemática',
      difficulty: 'média',
      yearAndExam: '2024 • FUVEST',
      questionText:
          'Um automóvel desloca-se a uma velocidade constante de 72 km/h. Qual é a sua velocidade expressa em metros por segundo (m/s)?',
      options: [
        QuestionOption(letter: 'a', text: '10 m/s'),
        QuestionOption(letter: 'b', text: '15 m/s'),
        QuestionOption(letter: 'c', text: '20 m/s'),
        QuestionOption(letter: 'd', text: '25 m/s'),
        QuestionOption(letter: 'e', text: '30 m/s'),
      ],
    ),
  ];

  static const Color azul = Color(0xFF1E3A8A);
  static const Color azulMedio = Color(0xFF356DB8);
  static const Color fundo = Color(0xFFF0F7FD);
  static const Color borda = Color(0xFFD4E7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      drawer: const AppDrawer(selectedLabel: 'Banco de Questões'),
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
                    'assets/logo2.png', // 🟦 Caminho da sua logo
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
                'Banco de Questões',
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
            'Pratique com filtros avançados e acompanhe seu desempenho',
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              color: Color(0xFF5275A6),
            ),
          ),
          const SizedBox(height: 26),
          _buildFilterSection(),
          const SizedBox(height: 20),
          Text(
            '${questions.length} questão(ões) encontrada(s)',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5275A6),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          ...questions.map(
            (q) => QuestionCard(
              question: q,
              onFavoriteToggle: () {
                setState(() => q.isFavorite = !q.isFavorite);
              },
              onOptionSelected: (selectedLetter) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selecionou a alternativa ($selectedLetter)'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
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
            'Filtros',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: azul,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar questão...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF94A3B8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borda),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borda),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, color: azulMedio),
                label: const Text('Filtros', style: TextStyle(color: azul)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: borda),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              _buildCategoryChip('Todas', isSelected: true),
              _buildCategoryChip('Favoritas'),
              _buildCategoryChip('Erradas'),
              _buildCategoryChip('Respondidas'),
            ],
          ),
        ],
      ),
    );
  }

   Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: const Color(0xFF60A5FA),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF334155),
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
          ),
        ),
        onSelected: (val) {},
      ),
    );
  }
}