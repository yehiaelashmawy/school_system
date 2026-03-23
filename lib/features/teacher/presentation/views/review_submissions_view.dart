import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/review_submissions_view_body.dart';

class ReviewSubmissionsView extends StatelessWidget {
  const ReviewSubmissionsView({super.key});
  static const String routeName = '/review_submissions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submissions: Photosynthesis Lab',
              style: AppTextStyle.bold16.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 4),
            Text(
              'Biology 101 • Section B',
              style: AppTextStyle.regular12.copyWith(color: AppColors.grey),
            ),
          ],
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const ReviewSubmissionsViewBody(),
    );
  }
}
