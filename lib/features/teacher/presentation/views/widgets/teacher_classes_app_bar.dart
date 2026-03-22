import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:svg_flutter/svg.dart';

class TeacherClassesAppBar extends StatelessWidget {
  const TeacherClassesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
      color: Colors.white,
      child: Row(
        children: [
          SvgPicture.asset('assets/images/my_classes_icon.svg'),
          const SizedBox(width: 12),
          const Text('My Classes', style: AppTextStyle.bold20),
          const Spacer(),
          const Icon(Icons.search, color: AppColors.darkBlue, size: 28),
          const SizedBox(width: 16),
          const Icon(Icons.filter_list, color: AppColors.darkBlue, size: 28),
        ],
      ),
    );
  }
}
