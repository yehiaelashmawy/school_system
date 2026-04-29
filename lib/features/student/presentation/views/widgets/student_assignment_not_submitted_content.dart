import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class StudentAssignmentNotSubmittedContent extends StatelessWidget {
  final String? description;

  const StudentAssignmentNotSubmittedContent({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description != null) ...[
          Text(
            description!,
            style: AppTextStyle.medium12.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
