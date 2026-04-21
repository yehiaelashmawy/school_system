import 'package:school_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_list_item.dart';

class LessonsListBody extends StatelessWidget {
  final List<TeacherLessonModel> lessons;

  const LessonsListBody({super.key, this.lessons = const []});

  String _formatDateInfo(String rawDate) {
    if (rawDate.trim().isEmpty) return 'Date unavailable';
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    final monthNames = const [
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
    final hour24 = parsed.hour;
    final minute = parsed.minute.toString().padLeft(2, '0');
    final isPm = hour24 >= 12;
    final hour12 = hour24 == 0
        ? 12
        : hour24 > 12
        ? hour24 - 12
        : hour24;
    final amPm = isPm ? 'PM' : 'AM';
    return '${monthNames[parsed.month - 1]} ${parsed.day}, ${parsed.year} - ${hour12.toString().padLeft(2, '0')}:$minute $amPm';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: lessons.isEmpty
                ? Center(
                    child: Text(
                      'No lessons found for this class.',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: lessons.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return LessonListItem(
                        title: lesson.title.isNotEmpty
                            ? lesson.title
                            : 'Untitled Lesson',
                        dateInfo: _formatDateInfo(lesson.date),
                        image: 'assets/images/lesson1.png',
                        lessonId: lesson.oid,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
