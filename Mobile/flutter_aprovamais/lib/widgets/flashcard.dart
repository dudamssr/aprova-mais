import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../style/colors.dart';

class Flashcard extends StatelessWidget {
  final String subject;
  final String question;
  final String answer;
  final String explanation;
  final Color textColor;
  final bool favorito;
  final VoidCallback onFavoritar;

  const Flashcard({
    super.key,
    required this.subject,
    required this.question,
    required this.answer,
    required this.explanation,
    this.textColor = Colors.black,
    this.favorito = false,
    required this.onFavoritar,
  });

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: _buildCard(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cabeçalho com matéria e estrela
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: paleBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    subject,
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    favorito ? Icons.star : Icons.star_border,
                    color: favorito ? Colors.amber : Colors.grey,
                  ),
                  onPressed: onFavoritar,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Clique para virar',
              style: TextStyle(color: textColor.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
      back: _buildCard(
        backgroundColor: paleBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              answer,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                explanation,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor.withValues(alpha: 0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Color backgroundColor, required Widget child}) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: backgroundColor,
      child: SizedBox(
        width: double.infinity,
        height: 240,
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }
}
