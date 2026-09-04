import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../style/colors.dart';
import '../widgets/app_drawer.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Drawer do aplicativo
      drawer: const AppDrawer(selectedLabel: 'Perfil'),

      backgroundColor: paleBlue,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _TopBar(),

            const SizedBox(height: 16),

            const Text(
              'Acompanhe sua evolução e conquistas',
              style: TextStyle(color: textDark, fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Card do perfil
            _buildPerfilCard(),

            const SizedBox(height: 24),

            // Cards de informações
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildInfoCard(Icons.access_time, '138h', 'Tempo estudado'),
                _buildInfoCard(
                  Icons.menu_book,
                  '26/06',
                  'Conteúdos concluídos',
                ),
                _buildInfoCard(Icons.layers, '1,247', 'Questões respondidas'),
                _buildInfoCard(Icons.assignment, '5', 'Simulados realizados'),
              ],
            ),

            const SizedBox(height: 24),

            // Evolução mensal
            _buildSectionTitle('Evolução mensal'),
            _buildLineChart(),

            // Acertos por matéria
            _buildSectionTitle('Acertos por matéria'),
            _buildRadarChart(),

            // Evolução dos simulados
            _buildSectionTitle('Evolução dos simulados'),
            _buildLineChart(),

            // Evolução das redações
            _buildSectionTitle('Evolução das redações'),
            _buildBarChart(),

            // Metas
            _buildSectionTitle('Metas concluídas'),

            _buildGoalItem('Resolver 1000 questões', 1.0),

            _buildGoalItem('Concluir 20 conteúdos', 0.75),

            _buildGoalItem('Nota 700+ no simulado', 1.0),

            _buildGoalItem('Enviar 5 redações', 0.8),

            const SizedBox(height: 24),

            // Conquistas
            _buildSectionTitle('Conquistas'),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildAchievement(
                  Icons.local_fire_department,
                  'Sequência de 23 dias',
                ),
                _buildAchievement(Icons.layers, 'Mais de 1000'),
                _buildAchievement(Icons.edit, 'Primeira'),
                _buildAchievement(Icons.emoji_events, 'Nota 700+'),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPerfilCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [navyBlue, cobaltBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Foto/logo do perfil
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Text(
                'G',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Gaby Piffer',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const Text(
            'gtpiffer@gmail.com',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Informações do usuário
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                avatar: const Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text('23 dias de sequência'),
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                labelStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Chip(
                avatar: const Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text('Nível Avançado'),
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                labelStyle: const TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            '712',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const Text(
            'Pontos totais',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CARDS DE INFORMAÇÕES
  // =========================================================

  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primaryColor, size: 32),

          const SizedBox(height: 8),

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
            style: const TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TÍTULO DAS SEÇÕES
  // =========================================================

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // =========================================================
  // GRÁFICO DE LINHA
  // =========================================================

  Widget _buildLineChart() {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 160),
                FlSpot(1, 220),
                FlSpot(2, 260),
                FlSpot(3, 300),
                FlSpot(4, 320),
              ],
              isCurved: true,
              color: primaryColor,
              barWidth: 3,
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // GRÁFICO RADAR
  // =========================================================

  Widget _buildRadarChart() {
    return Container(
      height: 230,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              fillColor: primaryColor.withValues(alpha: 0.3),
              borderColor: primaryColor,
              entryRadius: 2,
              dataEntries: const [
                RadarEntry(value: 80),
                RadarEntry(value: 70),
                RadarEntry(value: 65),
                RadarEntry(value: 90),
                RadarEntry(value: 75),
              ],
            ),
          ],
          getTitle: (index, angle) {
            switch (index) {
              case 0:
                return const RadarChartTitle(text: 'Mat');
              case 1:
                return const RadarChartTitle(text: 'Port');
              case 2:
                return const RadarChartTitle(text: 'Hist');
              case 3:
                return const RadarChartTitle(text: 'Ciên');
              case 4:
                return const RadarChartTitle(text: 'Geo');
            }

            return const RadarChartTitle(text: '');
          },
          titleTextStyle: const TextStyle(color: textDark, fontSize: 12),
        ),
      ),
    );
  }

  // =========================================================
  // GRÁFICO DE BARRAS
  // =========================================================

  Widget _buildBarChart() {
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [BarChartRodData(toY: 600, color: primaryColor)],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [BarChartRodData(toY: 650, color: primaryColor)],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [BarChartRodData(toY: 700, color: primaryColor)],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [BarChartRodData(toY: 720, color: primaryColor)],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // METAS
  // =========================================================

  Widget _buildGoalItem(String title, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            progress == 1.0 ? Icons.check_circle : Icons.radio_button_unchecked,
            color: progress == 1.0 ? Colors.green : Colors.grey,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(title, style: const TextStyle(color: textDark)),
          ),

          Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(
              color: progress == 1.0 ? Colors.green : textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CONQUISTAS
  // =========================================================

  Widget _buildAchievement(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accentColor, size: 32),

          const SizedBox(height: 8),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// TOP BAR
// =========================================================

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo + Perfil
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
              'Perfil',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),

        // Botão do menu
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: primaryColor),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ],
    );
  }
}
