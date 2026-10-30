import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(String optionLetter)? onOptionSelected;
  final VoidCallback? onFavoriteToggle;

const QuestionCard({
  super.key,
  required this.question,
  this.onOptionSelected,
  this.onFavoriteToggle,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildBadge(
                      text: question.subject,
                      backgroundColor: const Color(0xFFE0F2FE),
                      textColor: const Color(0xFF0369A1),
                    ),
                    _buildBadge(
                      text: question.topic,
                      backgroundColor: const Color(0xFFE0F2FE),
                      textColor: const Color(0xFF0369A1),
                    ),
                    _buildBadge(
                      text: question.difficulty,
                      backgroundColor: const Color(0xFFDCFCE7),
                      textColor: const Color(0xFF15803D),
                    ),
                    _buildBadge(
                      text: question.yearAndExam,
                      backgroundColor: const Color(0xFFF1F5F9),
                      textColor: const Color(0xFF475569),
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  question.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: question.isFavorite
                      ? Colors.amber
                      : const Color(0xFF64748B),
                  size: 24,
                ),
                onPressed: onFavoriteToggle,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            question.questionText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    if (onOptionSelected != null) {
                      onOptionSelected!(option.letter);
                    }
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              option.letter,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475569),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
