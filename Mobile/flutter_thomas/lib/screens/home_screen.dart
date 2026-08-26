import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';
import '../widgets/greeting_card.dart';
import '../widgets/weekly_chart_card.dart';
import '../widgets/events_card.dart';
import '../widgets/subjects_card.dart';
import '../widgets/app_drawer.dart';
import 'ai_chat_screen.dart';
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  /// Retorna a saudação de acordo com o horário atual.
  String _greetingForNow() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bom dia, bem-vindo de volta';
    if (hour < 18) return 'Boa tarde, bem-vindo de volta';
    return 'Boa noite, bem-vindo de volta';
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(selectedLabel: 'Início'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _TopBar(),
            const SizedBox(height: 16),
            GreetingCard(
              greeting: _greetingForNow(),
              userName: DashboardMockData.userName,
              goalPercent: DashboardMockData.weeklyGoalPercent,
              hoursDone: DashboardMockData.goalHoursDone,
              hoursTotal: DashboardMockData.goalHoursTotal,
              onAskAI: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AiChatScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            WeeklyChartCard(data: DashboardMockData.weeklyEvolution),
            const SizedBox(height: 16),
            EventsCard(events: DashboardMockData.upcomingEvents),
            const SizedBox(height: 16),
            SubjectsCard(
              subjects: DashboardMockData.subjectsInProgress,
              onSeeAll: () {
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
 
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: AppColors.heroGradientStart,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textDark),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }
}