import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/question_card.dart';

class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  // Lista simulada com várias questões de vestibulares e ENEM
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Banco de Questões',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pratique com filtros avançados e acompanhe seu desempenho',
            style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip('Todas', isSelected: true),
                _buildCategoryChip('Favoritas'),
                _buildCategoryChip('Erradas'),
                _buildCategoryChip('Respondidas'),
              ],
            ),
          ),
          const SizedBox(height: 16),
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
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list, color: Color(0xFF1E3A8A)),
                label: const Text(
                  'Filtros',
                  style: TextStyle(color: Color(0xFF1E293B)),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${questions.length} questão(ões) encontrada(s)',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          ...questions.map(
            (q) => QuestionCard(
              question: q,
              onFavoriteToggle: () {
                setState(() {
                  q.isFavorite = !q.isFavorite;
                });
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
