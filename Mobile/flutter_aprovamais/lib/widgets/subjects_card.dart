import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../style/app_thema.dart';
import 'dashboard_card.dart';

class SubjectsCard extends StatelessWidget {
  final List<SubjectProgress> subjects;
  final VoidCallback? onSeeAll;

  const SubjectsCard({super.key, required this.subjects, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      icon: Icons.menu_book_outlined,
      title: 'Matérias em andamento',
      trailing: TextButton(
        onPressed: onSeeAll,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ver todas',
              style: TextStyle(
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            Icon(Icons.chevron_right, size: 16, color: AppColors.accentBlue),
          ],
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < subjects.length; i++) ...[
            _SubjectTile(subject: subjects[i]),
            if (i != subjects.length - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _SubjectTile extends StatelessWidget {
  final SubjectProgress subject;

  const _SubjectTile({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  subject.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            Text(
              '${(subject.progress * 100).round()}%',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.textMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: subject.progress,
            minHeight: 7,
            backgroundColor: AppColors.progressTrack,
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
          ),
        ),
      ],
    );
  }
}
