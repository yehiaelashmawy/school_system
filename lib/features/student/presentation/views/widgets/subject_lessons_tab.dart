import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/student/data/models/student_my_subjects_model.dart';
import 'package:school_system/features/student/presentation/views/student_lesson_details_view.dart';
import 'package:school_system/features/student/presentation/views/widgets/subject_empty_state.dart';

class SubjectLessonsTab extends StatelessWidget {
  final List<StudentMyLesson> lessons;
  final bool isLoading;

  const SubjectLessonsTab({
    super.key,
    required this.lessons,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        child: Column(
          children: List.generate(
            3,
            (_) => SubjectLessonCard(
              lesson: StudentMyLesson(
                lessonId: '',
                title: 'Loading Lesson Title Here',
                status: 'Upcoming',
                materialsCount: 0,
                date: DateTime.now(),
                startTime: DateTime.now(),
                endTime: DateTime.now(),
              ),
            ),
          ),
        ),
      );
    }

    if (lessons.isEmpty) {
      return const SubjectEmptyState(
        icon: Icons.menu_book_outlined,
        message: 'No lessons available for this subject yet.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Lessons',
              style: AppTextStyle.bold16.copyWith(
                color: AppColors.darkBlue,
                fontSize: 18,
              ),
            ),
            Text(
              '${lessons.length} lessons',
              style: AppTextStyle.medium12.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...lessons.map((l) => SubjectLessonCard(lesson: l)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class SubjectLessonCard extends StatelessWidget {
  final StudentMyLesson lesson;

  const SubjectLessonCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final isCompleted = lesson.isCompleted;
    final statusColor = isCompleted
        ? AppColors.secondaryColor
        : const Color.fromARGB(255, 9, 33, 247);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Box
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.play_lesson_outlined,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: AppTextStyle.bold16.copyWith(
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${lesson.formattedDate}${lesson.formattedTimeRange.isNotEmpty ? ' • ${lesson.formattedTimeRange}' : ''}',
                      style: AppTextStyle.medium12.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            lesson.status.toUpperCase(),
                            style: AppTextStyle.bold12.copyWith(
                              color: statusColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        if (lesson.materialsCount > 0) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.attach_file,
                            size: 13,
                            color: AppColors.grey,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${lesson.materialsCount} materials',
                            style: AppTextStyle.medium12.copyWith(
                              color: AppColors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action Button
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    StudentLessonDetailsView.routeName,
                    arguments: lesson.lessonId,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xff0F52BD,
                  ), // Dark blue from image
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                icon: const Icon(Icons.remove_red_eye_outlined, size: 18),
                label: const Text(
                  'View',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
