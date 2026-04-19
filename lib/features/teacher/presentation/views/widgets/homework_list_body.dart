import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/views/homework_details_view.dart';
import 'package:school_system/features/teacher/presentation/views/review_submissions_view.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_list_item.dart';

class HomeworkListBody extends StatelessWidget {
  final List<TeacherHomeworkModel> homeworks;

  const HomeworkListBody({super.key, this.homeworks = const []});

  String _formatDate(String rawDate) {
    if (rawDate.trim().isEmpty) return 'Date unavailable';
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[parsed.month - 1]} ${parsed.day}, ${parsed.year}';
  }

  _HomeworkUiState _mapStatus(String status, String dueDate) {
    final normalized = status.trim().toLowerCase();
    final parsedDue = DateTime.tryParse(dueDate);
    final isPastDue = parsedDue != null && parsedDue.isBefore(DateTime.now());

    if (normalized == 'grading') {
      return _HomeworkUiState(
        label: 'GRADING',
        badgeColor: Color(0xFFDBEAFE),
        badgeTextColor: Color(0xFF1E40AF),
        buttonText: 'Review Submissions',
        buttonColor: Color(0xFFF1F5F9),
        buttonTextColor: Color(0xFF475569),
        isOverdue: false,
      );
    }
    if (normalized == 'completed') {
      return _HomeworkUiState(
        label: 'COMPLETED',
        badgeColor: Color(0xFFE2E8F0),
        badgeTextColor: Color(0xFF334155),
        buttonText: 'View Details',
        buttonColor: Color(0xFFEFF6FF),
        buttonTextColor: AppColors.primaryColor,
        isOverdue: false,
      );
    }
    if (isPastDue) {
      return _HomeworkUiState(
        label: 'OVERDUE',
        badgeColor: Color(0xFFFEE2E2),
        badgeTextColor: Color(0xFF991B1B),
        buttonText: 'Review Submissions',
        buttonColor: Color(0xFFF1F5F9),
        buttonTextColor: Color(0xFF475569),
        isOverdue: true,
      );
    }
    return _HomeworkUiState(
      label: 'ACTIVE',
      badgeColor: Color(0xFFD1FAE5),
      badgeTextColor: Color(0xFF065F46),
      buttonText: 'View Details',
      buttonColor: AppColors.primaryColor,
      buttonTextColor: Colors.white,
      isOverdue: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              style: AppTextStyle.regular14.copyWith(color: AppColors.darkBlue),
              decoration: InputDecoration(
                hintText: 'Search homework tasks...',
                hintStyle: AppTextStyle.regular14.copyWith(
                  color: AppColors.grey.withValues(alpha: 0.7),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.grey.withValues(alpha: 0.7),
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: AppColors.lightGrey.withValues(alpha: 0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: AppColors.lightGrey.withValues(alpha: 0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: homeworks.isEmpty
                ? Center(
                    child: Text(
                      'No homework found for this class.',
                      style: AppTextStyle.semiBold16.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: homeworks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final homework = homeworks[index];
                      final ui = _mapStatus(homework.status, homework.dueDate);
                      return HomeworkItemCard(
                        title: homework.title.isNotEmpty
                            ? homework.title
                            : 'Untitled Homework',
                        subtitle: 'Class ${homework.status}',
                        statusText: ui.label,
                        badgeColor: ui.badgeColor,
                        badgeTextColor: ui.badgeTextColor,
                        dueDate: _formatDate(homework.dueDate),
                        submissions: homework.grade != null
                            ? 'Grade: ${homework.grade!.toStringAsFixed(0)}'
                            : '--',
                        progress: homework.grade != null
                            ? (homework.grade!.clamp(0, 100) / 100)
                            : null,
                        buttonText: ui.buttonText,
                        buttonColor: ui.buttonColor,
                        buttonTextColor: ui.buttonTextColor,
                        isOverdue: ui.isOverdue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ui.label == 'GRADING'
                                  ? const ReviewSubmissionsView()
                                  : const HomeworkDetailsView(),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _HomeworkUiState {
  final String label;
  final Color badgeColor;
  final Color badgeTextColor;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final bool isOverdue;

  const _HomeworkUiState({
    required this.label,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.isOverdue,
  });
}
