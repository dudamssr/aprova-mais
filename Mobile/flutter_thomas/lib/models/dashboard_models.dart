class WeeklyPoint {
  final String label; // Seg, Ter, Qua...
  final double value;
 
  const WeeklyPoint(this.label, this.value);
}
 
/// Representa um evento da agenda
class AgendaEvent {
  final String day; // "08"
  final String month; // "AGO."
  final String title;
  final String time;
 
  const AgendaEvent({
    required this.day,
    required this.month,
    required this.title,
    required this.time,
  });
}
 
/// Representa uma matéria em andamento
class SubjectProgress {
  final String name;
  final double progress; // 0.0 a 1.0
 
  const SubjectProgress({required this.name, required this.progress});
}
 
/// Dados mockados que alimentam o dashboard.
/// Depois isso pode virar uma chamada de repositório/API.
class DashboardMockData {
  static const String userName = 'Thomas';
  static const double weeklyGoalPercent = 0.68;
  static const String goalHoursDone = '3,4h';
  static const String goalHoursTotal = '5h';
 
  static const List<WeeklyPoint> weeklyEvolution = [
    WeeklyPoint('Seg', 28),
    WeeklyPoint('Ter', 22),
    WeeklyPoint('Qua', 38),
    WeeklyPoint('Qui', 30),
    WeeklyPoint('Sex', 42),
    WeeklyPoint('Sáb', 48),
    WeeklyPoint('Dom', 18),
  ];
 
  static const List<AgendaEvent> upcomingEvents = [
    AgendaEvent(
      day: '08',
      month: 'AGO.',
      title: 'Simulado de Matemática',
      time: '09:00h',
    ),
    AgendaEvent(
      day: '09',
      month: 'AGO.',
      title: 'Entrega da Redação',
      time: '23:59h',
    ),
    AgendaEvent(
      day: '10',
      month: 'AGO.',
      title: 'Revisão de Física',
      time: '15:00h',
    ),
    AgendaEvent(
      day: '11',
      month: 'AGO.',
      title: 'Aula de Química Orgânica',
      time: '10:00h',
    ),
  ];
 
  static const List<SubjectProgress> subjectsInProgress = [
    SubjectProgress(name: 'Matemática', progress: 0.68),
    SubjectProgress(name: 'Português', progress: 0.75),
    SubjectProgress(name: 'História', progress: 0.52),
  ];
}