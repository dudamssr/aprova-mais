import 'package:flutter/material.dart';
import '../style/colors.dart';
import '../widgets/app_drawer.dart';

class MateriasScreen extends StatefulWidget {
  const MateriasScreen({super.key});

  @override
  State<MateriasScreen> createState() => _MateriasScreenState();
}

class _MateriasScreenState extends State<MateriasScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  final List<Map<String, dynamic>> materias = [
    {
      "nome": "Matemática",
      "tempo": "42h 30min",
      "progresso": 0.68,
      "aulas": "1/5 aulas",
    },
    {
      "nome": "Português",
      "tempo": "38h 15min",
      "progresso": 0.75,
      "aulas": "1/4 aulas",
    },
    {
      "nome": "História",
      "tempo": "25h 10min",
      "progresso": 0.52,
      "aulas": "1/3 aulas",
    },
    {
      "nome": "Geografia",
      "tempo": "22h 40min",
      "progresso": 0.60,
      "aulas": "1/3 aulas",
    },
    {
      "nome": "Biologia",
      "tempo": "18h 20min",
      "progresso": 0.45,
      "aulas": "0/2 aulas",
    },
    {
      "nome": "Física",
      "tempo": "15h 50min",
      "progresso": 0.40,
      "aulas": "0/2 aulas",
    },
    {
      "nome": "Química",
      "tempo": "12h 30min",
      "progresso": 0.35,
      "aulas": "0/1 aulas",
    },
    {
      "nome": "Literatura",
      "tempo": "14h 00min",
      "progresso": 0.58,
      "aulas": "1/1 aulas",
    },
    {
      "nome": "Redação",
      "tempo": "10h 00min",
      "progresso": 0.50,
      "aulas": "0/1 aulas",
    },
    {
      "nome": "Filosofia",
      "tempo": "6h 00min",
      "progresso": 0.30,
      "aulas": "0/1 aulas",
    },
    {
      "nome": "Sociologia",
      "tempo": "5h 30min",
      "progresso": 0.32,
      "aulas": "0/1 aulas",
    },
    {
      "nome": "Inglês",
      "tempo": "8h 00min",
      "progresso": 0.70,
      "aulas": "1/1 aulas",
    },
    {
      "nome": "Espanhol",
      "tempo": "7h 00min",
      "progresso": 0.65,
      "aulas": "0/1 aulas",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // aplica filtro
    final filtradas = materias.where((m) {
      final nome = (m["nome"] as String).toLowerCase();
      return nome.contains(_searchText.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const AppDrawer(selectedLabel: 'Matérias'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _TopBar(),
            const SizedBox(height: 24),

            const Text(
              'Explore todo o conteúdo por disciplina',
              style: TextStyle(color: Color(0xFF8290A2), fontSize: 15),
            ),
            const SizedBox(height: 20),

            // Barra de busca funcional
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE7EDF3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                ), // azul acinzentado
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xFF299FD6)),
                  hintText: 'Buscar matéria...',
                  hintStyle: TextStyle(color: Color(0xFF8290A2)),
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Lista filtrada
            for (final materia in filtradas) ...[
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFFE7EDF3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        materia["nome"] as String,
                        style: const TextStyle(
                          color: Color(0xFF102F55),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "⏱ ${materia["tempo"]} estudados",
                        style: const TextStyle(color: Color(0xFF8290A2)),
                      ),
                      Text(
                        materia["aulas"] as String,
                        style: const TextStyle(color: Color(0xFF8290A2)),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: materia["progresso"] as double,
                        backgroundColor: const Color(0xFFEDF2F5),
                        color: const Color(0xFF299FD6),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Progresso ${(materia["progresso"] * 100).toInt()}%",
                        style: const TextStyle(color: Color(0xFF102F55)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// TOPO IGUAL AO DOS FLASHCARDS
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
              'Matérias',
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
