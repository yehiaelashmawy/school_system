import 'package:school_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/widgets/custom_snack_bar.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_details_view_body.dart';

class LessonDetailsView extends StatefulWidget {
  const LessonDetailsView({super.key, this.lessonId});
  static const String routeName = '/lesson_details';
  final String? lessonId;

  @override
  State<LessonDetailsView> createState() => _LessonDetailsViewState();
}

class _LessonDetailsViewState extends State<LessonDetailsView> {
  Future<void> _deleteLesson() async {
    final lessonId = widget.lessonId;
    if (lessonId == null || lessonId.trim().isEmpty) {
      CustomSnackBar.showError(context, 'Lesson ID is missing');
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lesson'),
        content: const Text('Are you sure you want to delete this lesson?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final response = await ApiService().delete('/api/Lessons/$lessonId');
      final isSuccess = response is Map<String, dynamic> &&
          (response['success'] == true || response['data'] == true);

      if (!mounted) return;

      if (isSuccess) {
        CustomSnackBar.showSuccess(context, 'Lesson deleted successfully');
        Navigator.pop(context, true);
      } else {
        CustomSnackBar.showError(context, 'Failed to delete lesson');
      }
    } catch (_) {
      if (!mounted) return;
      CustomSnackBar.showError(context, 'Failed to delete lesson');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Lesson Details',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.black),
            onPressed: _deleteLesson,
          ),
        ],
      ),
      body: LessonDetailsViewBody(lessonId: widget.lessonId),
    );
  }
}
