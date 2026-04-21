import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/lesson_details_view.dart';

class LessonListItem extends StatelessWidget {
  const LessonListItem({
    super.key,
    required this.title,
    required this.dateInfo,
    required this.image,
    required this.lessonId,
    this.onLessonDeleted,
  });

  final String title;
  final String dateInfo;
  final String image;
  final String lessonId;
  final ValueChanged<String>? onLessonDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffE2E8F0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: AppColors.grey),
              const SizedBox(width: 6),
              Text(
                dateInfo,
                style: TextStyle(fontSize: 12, color: AppColors.grey),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xffE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            // We use a placeholder container here for the image banner since we don't have the specific assets.
            // The user had placeholder images in the design.
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xffE2E8F0),
                  child: Center(
                    child: Icon(Icons.image_outlined, color: AppColors.grey),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                final deleted = await Navigator.pushNamed(
                  context,
                  LessonDetailsView.routeName,
                  arguments: lessonId,
                );
                if (deleted == true) {
                  onLessonDeleted?.call(lessonId);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0F52BD),
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                minimumSize: const Size(0, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Details',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
