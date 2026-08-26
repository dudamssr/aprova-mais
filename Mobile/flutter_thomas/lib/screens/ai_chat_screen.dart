import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../theme/app_theme.dart';
import '../widgets/chat_bubble.dart';
 
class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});
 
  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}
 
class _AiChatScreenState extends State<AiChatScreen> {
  // Sem histórico: a conversa sempre começa vazia.
  final List<ChatMessage> _messages = [];
 
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;
 
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
 
  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || _isSending) return;
 
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isSending = true;
    });
    _controller.clear();
    _scrollToBottom();
 
    
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _messages.add(
          const ChatMessage(
            text: 'Entendi sua dúvida! Assim que a integração com a IA '
                'estiver pronta, vou responder de verdade por aqui.',
            isUser: false,
          ),
        );
        _isSending = false;
      });
      _scrollToBottom();
    });
  }
 
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _ChatHeader(),
            Expanded(
              child: _messages.isEmpty
                  ? const _EmptyState()
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      itemCount: _messages.length + (_isSending ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _messages.length) {
                          return const _TypingIndicator();
                        }
                        return ChatBubble(message: _messages[index]);
                      },
                    ),
            ),
            _ChatInputBar(
              controller: _controller,
              onSend: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}
 
class _ChatHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'IA para Dúvidas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Seu tutor de estudos com Inteligência Artificial',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textMedium,
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
 
class _EmptyState extends StatelessWidget {
  const _EmptyState();
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.primaryBlue,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Envie sua primeira dúvida',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Pergunte qualquer coisa sobre suas matérias de estudo.',
              style: TextStyle(fontSize: 13, color: AppColors.textMedium),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
 
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();
 
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const SizedBox(
          width: 24,
          height: 12,
          child: Center(
            child: SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 
class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
 
  const _ChatInputBar({required this.controller, required this.onSend});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.progressTrack),
              ),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: const InputDecoration(
                  hintText: 'Escreva sua dúvida...',
                  hintStyle: TextStyle(color: AppColors.textLight, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: AppColors.primaryBlue,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onSend,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}