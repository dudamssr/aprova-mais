import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../widgets/app_drawer.dart';

class RedacaoPage extends StatelessWidget {
  const RedacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paleBlue,

      // Menu lateral
      drawer: const AppDrawer(selectedLabel: 'Redações'),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const _TopBar(),

            const SizedBox(height: 16),

            const Text(
              'Escreva, envie e receba correção por IA nas 5 competências',
              style: TextStyle(color: textDark, fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Botões principais
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Escrever'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.history,
                      size: 18,
                      color: primaryColor,
                    ),
                    label: const Text(
                      'Histórico',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Card de nova redação
            _buildCardNovaRedacao(),

            const SizedBox(height: 28),

            // Card das competências
            _buildCardCompetencias(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CARD NOVA REDAÇÃO
  // ============================================================

  Widget _buildCardNovaRedacao() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.edit, color: primaryColor),
              SizedBox(width: 8),
              Text(
                'Nova',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            'Tema',
            style: TextStyle(color: textDark, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            initialValue: 'Os desafios da saúde mental no Brasil',
            items: const [
              DropdownMenuItem(
                value: 'Os desafios da saúde mental no Brasil',
                child: Text(
                  'Os desafios da saúde mental no Brasil',
                  style: TextStyle(color: textDark),
                ),
              ),
              DropdownMenuItem(
                value: 'Impactos da tecnologia na educação',
                child: Text(
                  'Impactos da tecnologia na educação',
                  style: TextStyle(color: textDark),
                ),
              ),
            ],
            onChanged: (value) {},
            decoration: InputDecoration(
              filled: true,
              fillColor: paleBlue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Título (opcional)',
            style: TextStyle(color: textDark, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextField(
            style: const TextStyle(color: textDark),
            decoration: InputDecoration(
              hintText: 'Dê um título à sua redação',
              hintStyle: const TextStyle(color: Colors.black45),
              filled: true,
              fillColor: paleBlue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Sua redação (0 caracteres)',
            style: TextStyle(color: textDark, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 8),

          TextField(
            maxLines: 6,
            style: const TextStyle(color: textDark),
            decoration: InputDecoration(
              hintText:
                  'Escreva sua redação dissertativa-argumentativa aqui...',
              hintStyle: const TextStyle(color: Colors.black45),
              filled: true,
              fillColor: paleBlue,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Enviar para correção'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor.withValues(alpha: 0.9),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Escreva pelo menos 100 caracteres para enviar.',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD DAS COMPETÊNCIAS
  // ============================================================

  Widget _buildCardCompetencias() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.workspace_premium, color: primaryColor),
              SizedBox(width: 8),
              Text(
                'Como 5 competências',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _buildCompetenciaItem('1', 'Domínio da norma culta'),

          _buildCompetenciaItem('2', 'Compreensão da proposta'),

          _buildCompetenciaItem('3', 'Argumentação e repertório'),

          _buildCompetenciaItem('4', 'Coesão e coerência'),

          _buildCompetenciaItem('5', 'Proposta de intervenção'),

          const SizedBox(height: 12),

          const Text(
            'Cada competência vale até 200 pontos. '
            'A IA corrige sua redação e dá feedback detalhado.',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ITEM DA COMPETÊNCIA
  // ============================================================

  Widget _buildCompetenciaItem(String numero, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: primaryColor.withValues(alpha: 0.15),
            child: Text(
              numero,
              style: const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(texto, style: const TextStyle(color: textDark)),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// TOPO DA TELA
// ================================================================

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Logo + título
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
              'Redação',
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
