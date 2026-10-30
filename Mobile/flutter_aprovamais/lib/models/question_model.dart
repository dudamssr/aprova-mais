class QuestionOption {
  final String letter;
  final String text;

  QuestionOption({
    required this.letter,
    required this.text,
  });
}

class Question {
  final String id;
  final String subject;
  final String topic;
  final String difficulty;
  final String yearAndExam;
  final String questionText;
  final List<QuestionOption> options;
  bool isFavorite;

  Question({
    required this.id,
    required this.subject,
    required this.topic,
    required this.difficulty,
    required this.yearAndExam,
    required this.questionText,
    required this.options,
    this.isFavorite = false,
  });
}