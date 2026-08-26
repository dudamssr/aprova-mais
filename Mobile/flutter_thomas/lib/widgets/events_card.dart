import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';
import 'dashboard_card.dart';
 
class EventsCard extends StatelessWidget {
  final List<AgendaEvent> events;
 
  const EventsCard({super.key, required this.events});
 
  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      icon: Icons.calendar_today_outlined,
      title: 'Próximos eventos',
      subtitle: 'Sua agenda',
      child: Column(
        children: [
          for (int i = 0; i < events.length; i++) ...[
            _EventTile(event: events[i]),
            if (i != events.length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
 
class _EventTile extends StatelessWidget {
  final AgendaEvent event;
 
  const _EventTile({required this.event});
 
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                event.day,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.primaryBlue,
                ),
              ),
              Text(
                event.month,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                event.time,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}