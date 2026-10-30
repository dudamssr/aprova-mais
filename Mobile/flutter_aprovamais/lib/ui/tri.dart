import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class TriCalculoScreen extends StatefulWidget {
  const TriCalculoScreen({super.key});

  @override
  State<TriCalculoScreen> createState() => _TriCalculoScreenState();
}

class _TriCalculoScreenState extends State<TriCalculoScreen> {
  static const Color azul = Color(0xFF1E3A8A);
  static const Color azulMedio = Color(0xFF356DB8);
  static const Color fundo = Color(0xFFF0F7FD);
  static const Color borda = Color(0xFFD4E7FA);

  String areaSelecionada = 'Linguagens e Códigos';
  double acertosTotais = 0;
  double faceis = 0;
  double medias = 0;
  double dificeis = 0;
  double metaNota = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fundo,
      drawer: const AppDrawer(selectedLabel: 'TRI'),
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
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Cálculo da TRI',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildDadosProva()),
            const SizedBox(width: 20),
            Expanded(child: _buildGraficoTri()),
          ],
        ),
      ),
    );
  }

  Widget _buildDadosProva() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dados da sua prova',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: azul,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              _buildAreaChip('Linguagens e Códigos'),
              _buildAreaChip('Ciências Humanas'),
              _buildAreaChip('Ciências da Natureza'),
              _buildAreaChip('Matemática'),
            ],
          ),
          const SizedBox(height: 20),
          _buildSlider(
            'Acertos totais',
            acertosTotais,
            0,
            45,
            (v) => setState(() => acertosTotais = v),
          ),
          const SizedBox(height: 10),
          _buildSlider(
            'Fáceis',
            faceis,
            0,
            15,
            (v) => setState(() => faceis = v),
            cor: Colors.green,
          ),
          _buildSlider(
            'Médias',
            medias,
            0,
            15,
            (v) => setState(() => medias = v),
            cor: Colors.orange,
          ),
          _buildSlider(
            'Difíceis',
            dificeis,
            0,
            15,
            (v) => setState(() => dificeis = v),
            cor: Colors.red,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meta de nota',
                style: TextStyle(color: azul, fontWeight: FontWeight.w600),
              ),
              Text(
                metaNota.toStringAsFixed(0),
                style: const TextStyle(
                  color: azulMedio,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [azul, azulMedio],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Calcular TRI estimada',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaChip(String label) {
    final selecionado = areaSelecionada == label;
    return GestureDetector(
      onTap: () => setState(() => areaSelecionada = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selecionado ? azul : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: selecionado ? azul : borda),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: selecionado ? Colors.white : azul,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String titulo,
    double valor,
    double min,
    double max,
    ValueChanged<double> onChanged, {
    Color cor = azulMedio,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(color: azul, fontWeight: FontWeight.w600),
        ),
        Slider(
          value: valor,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          activeColor: cor,
          label: valor.toStringAsFixed(0),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildGraficoTri() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evolução da TRI estimada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: azul,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/grafico_exemplo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Text(
                  'Gráfico da TRI aparecerá aqui',
                  style: TextStyle(color: Color(0xFF5275A6)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Preencha os dados e clique em "Calcular" para ver sua estimativa.',
            style: TextStyle(color: Color(0xFF5275A6), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
