import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../widgets/app_drawer.dart';

class IaChatScreen extends StatefulWidget {
  const IaChatScreen({super.key});

  @override
  State<IaChatScreen> createState() => _IaChatScreenState();
}

class _IaChatScreenState extends State<IaChatScreen> {
  final TextEditingController _mensagemController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _mensagens = [
    {
      'sender': 'ia',
      'text':
          'Olá! Que bom ter você por aqui. Qual dúvida de estudo você tem hoje para o ENEM ou vestibulares? Pode perguntar!',
    },
  ];

  bool _carregando = false;

  Future<void> _enviarDuvida() async {
    final texto = _mensagemController.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _mensagens.add({'sender': 'user', 'text': texto});
      _carregando = true;
    });

    _mensagemController.clear();
    _rolarParaFinal();

    try {
      final baseUrl = dotenv.env['API_URL'] ?? 'http://10.0.2.2:3000';
      final response = await http.post(
        Uri.parse('$baseUrl/ia/duvida'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'duvida': texto}),
      );

      if (response.statusCode == 200) {
        final dados = jsonDecode(response.body);
        final respostaIa = dados['resposta'] ?? 'Sem resposta da IA.';
        setState(() => _mensagens.add({'sender': 'ia', 'text': respostaIa}));
      } else {
        setState(
          () => _mensagens.add({
            'sender': 'ia',
            'text': 'Erro ao processar a dúvida. (${response.statusCode})',
          }),
        );
      }
    } catch (e) {
      setState(
        () => _mensagens.add({
          'sender': 'ia',
          'text':
              'Erro de conexão com o servidor. Verifique se o backend está rodando.',
        }),
      );
    } finally {
      setState(() => _carregando = false);
      _rolarParaFinal();
    }
  }

  void _rolarParaFinal() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color azul = Color(0xFF1E3A8A);
    const Color azulClaro = Color(0xFFF0F7FD);
    const Color borda = Color(0xFFD4E7FA);

    return Scaffold(
      backgroundColor: azulClaro,
      drawer: const AppDrawer(selectedLabel: 'IA'),
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
                    'assets/logo2.png', // 🟦 sua logo
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
                'IA para Dúvidas',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seu tutor de estudos com Inteligência Artificial para te ajudar em qualquer matéria.',
              style: TextStyle(color: Color(0xFF5275A6), fontSize: 15),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borda),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(20),
                        itemCount: _mensagens.length,
                        itemBuilder: (context, index) {
                          final msg = _mensagens[index];
                          final isIa = msg['sender'] == 'ia';
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isIa)
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: azulClaro,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      color: azul,
                                      size: 18,
                                    ),
                                  ),
                                if (isIa) const SizedBox(width: 10),
                                Expanded(
                                  child: Align(
                                    alignment: isIa
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: isIa
                                            ? const Color(0xFFF8FAFC)
                                            : azul,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        msg['text']!,
                                        style: TextStyle(
                                          color: isIa
                                              ? Colors.black87
                                              : Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (_carregando)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(color: azul),
                      ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                        border: Border(top: BorderSide(color: borda)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _mensagemController,
                              onSubmitted: (_) => _enviarDuvida(),
                              style: const TextStyle(
                                color: Color(
                                  0xFF1E3A8A,
                                ), // 🔵 texto azul escuro
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    'Escreva sua dúvida sobre qualquer matéria...',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: borda),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: azul),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: azul,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.send, color: Colors.white),
                              onPressed: _enviarDuvida,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
