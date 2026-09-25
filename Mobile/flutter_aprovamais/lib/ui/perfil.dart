import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_drawer.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Map<String, dynamic>? perfil;

  bool carregando = true;
  String erro = '';

  File? fotoPerfil;

  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    carregarPerfil();
    carregarFotoPerfil();
  }

  // ============================================================
  // CARREGAR PERFIL
  // ============================================================

  Future<void> carregarPerfil() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final usuarioId = prefs.getInt('usuarioId');

      if (usuarioId == null) {
        if (!mounted) return;

        setState(() {
          erro = 'Nenhum usuário logado.';
          carregando = false;
        });

        return;
      }

      final baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

      final url = Uri.parse('$baseUrl/usuario/perfil/$usuarioId');

      final response = await http.get(url);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          perfil = Map<String, dynamic>.from(data);
          carregando = false;
        });
      } else {
        try {
          final data = jsonDecode(response.body);

          setState(() {
            erro =
                data['erro']?.toString() ??
                'Erro ao carregar perfil (${response.statusCode})';

            carregando = false;
          });
        } catch (_) {
          setState(() {
            erro = 'Erro ao carregar perfil (${response.statusCode})';

            carregando = false;
          });
        }
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Falha na conexão: $e';
        carregando = false;
      });
    }
  }

  // ============================================================
  // CARREGAR FOTO SALVA
  // ============================================================

  Future<void> carregarFotoPerfil() async {
    final prefs = await SharedPreferences.getInstance();

    final caminho = prefs.getString('fotoPerfil');

    if (caminho == null || caminho.isEmpty) {
      return;
    }

    final arquivo = File(caminho);

    if (!await arquivo.exists()) {
      return;
    }

    if (!mounted) return;

    setState(() {
      fotoPerfil = arquivo;
    });
  }

  // ============================================================
  // ESCOLHER FOTO
  // ============================================================

  Future<void> escolherFoto() async {
    final opcao = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Alterar foto de perfil',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE8F0FE),
                    child: Icon(Icons.photo_library, color: Color(0xFF1A73E8)),
                  ),
                  title: const Text('Escolher da galeria'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                ),

                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE8F0FE),
                    child: Icon(Icons.camera_alt, color: Color(0xFF1A73E8)),
                  ),
                  title: const Text('Tirar uma foto'),
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );

    if (opcao == null) {
      return;
    }

    final XFile? imagem = await picker.pickImage(
      source: opcao,
      imageQuality: 80,
    );

    if (imagem == null) {
      return;
    }

    if (!mounted) return;

    final arquivo = File(imagem.path);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('fotoPerfil', arquivo.path);

    if (!mounted) return;

    setState(() {
      fotoPerfil = arquivo;
    });
  }

  // ============================================================
  // TELA
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(selectedLabel: 'Perfil'),
      backgroundColor: const Color(0xFFF5F8FF),
      body: SafeArea(
        child: carregando
            ? const Center(child: CircularProgressIndicator())
            : erro.isNotEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(erro, textAlign: TextAlign.center),
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  const _TopBar(),

                  const SizedBox(height: 16),

                  const Text(
                    'Acompanhe sua evolução e conquistas',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  _buildPerfilCard(),

                  const SizedBox(height: 24),

                  _buildStatsGrid(),

                  const SizedBox(height: 24),

                  _buildMetasConcluidas(),

                  const SizedBox(height: 24),

                  _buildConquistas(),
                ],
              ),
      ),
    );
  }

  // ============================================================
  // CARD DO PERFIL
  // ============================================================

  Widget _buildPerfilCard() {
    final nome = perfil?['nome']?.toString() ?? 'Usuário';

    final email = perfil?['email']?.toString() ?? '';

    final diasSequencia = perfil?['diasSequencia']?.toString() ?? '0';

    final nivel = perfil?['nivel']?.toString() ?? 'Nível Avançado';

    final pontosTotais = perfil?['pontosTotais']?.toString() ?? '0';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A3C6E), Color(0xFF1A73E8)],
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
          // ======================================================
          // AVATAR + CÂMERA
          // ======================================================

          Stack(
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: ClipOval(
                  child: fotoPerfil != null
                      ? Image.file(
                          fotoPerfil!,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.person, color: Colors.white, size: 60),
                ),
              ),

              // ==================================================
              // BOTÃO DA CÂMERA
              // ==================================================
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: escolherFoto,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A73E8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ======================================================
          // NOME
          // ======================================================
          Text(
            nome,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          // ======================================================
          // EMAIL
          // ======================================================
          Text(
            email,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),

          const SizedBox(height: 16),

          // ======================================================
          // BADGES
          // ======================================================
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildBadge(
                Icons.local_fire_department,
                '$diasSequencia dias de sequência',
              ),

              _buildBadge(Icons.star, nivel),
            ],
          ),

          const SizedBox(height: 16),

          // ======================================================
          // PONTOS
          // ======================================================
          Text(
            pontosTotais,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const Text(
            'Pontos totais',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BADGE
  // ============================================================

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),

          const SizedBox(width: 6),

          Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }

  // ============================================================
  // ESTATÍSTICAS
  // ============================================================

  Widget _buildStatsGrid() {
    final stats = <Map<String, dynamic>>[
      {'icon': Icons.timer, 'label': 'Tempo estudado', 'value': '138h'},
      {
        'icon': Icons.menu_book,
        'label': 'Conteúdos concluídos',
        'value': '6/26',
      },
      {
        'icon': Icons.question_answer,
        'label': 'Questões respondidas',
        'value': '1.247',
      },
      {'icon': Icons.assignment, 'label': 'Simulados realizados', 'value': '5'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final item = stats[index];

        final IconData icon = item['icon'] as IconData;

        final String value = item['value'].toString();

        final String label = item['label'].toString();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF1A73E8), size: 28),

              const SizedBox(height: 8),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // METAS
  // ============================================================

  Widget _buildMetasConcluidas() {
    final metas = <Map<String, dynamic>>[
      {'titulo': 'Resolver 1000 questões', 'progresso': 1.0},
      {'titulo': 'Concluir 20 conteúdos', 'progresso': 0.75},
      {'titulo': 'Nota 700+ no simulado', 'progresso': 1.0},
      {'titulo': 'Enviar 5 redações', 'progresso': 0.8},
    ];

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
          const Text(
            'Metas concluídas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          for (final meta in metas)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meta['titulo'].toString(),
                    style: const TextStyle(color: Colors.black87),
                  ),

                  const SizedBox(height: 6),

                  LinearProgressIndicator(
                    value: meta['progresso'] as double,
                    color: const Color(0xFF1A73E8),
                    backgroundColor: const Color(0xFFE8F0FE),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // CONQUISTAS
  // ============================================================

  Widget _buildConquistas() {
    final conquistas = <Map<String, dynamic>>[
      {
        'icon': Icons.emoji_events,
        'titulo': 'Primeira questão',
        'descricao': 'Você respondeu sua primeira questão!',
      },
      {
        'icon': Icons.school,
        'titulo': 'Primeiro conteúdo',
        'descricao': 'Você concluiu seu primeiro conteúdo!',
      },
      {
        'icon': Icons.assignment_turned_in,
        'titulo': 'Primeiro simulado',
        'descricao': 'Você realizou seu primeiro simulado!',
      },
    ];

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
          const Text(
            'Conquistas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          for (final conquista in conquistas)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A73E8).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      conquista['icon'] as IconData,
                      color: const Color(0xFF1A73E8),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conquista['titulo'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Text(
                          conquista['descricao'].toString(),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ================================================================
// TOP BAR
// ================================================================

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
                color: Color(0xFF1A73E8),
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
                color: Color(0xFF1A73E8),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),

        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF1A73E8)),
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
