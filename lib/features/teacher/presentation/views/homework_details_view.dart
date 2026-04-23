import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/repos/homework_details_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/homework_details_cubit/homework_details_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_view_body.dart';

class HomeworkDetailsView extends StatelessWidget {
  final String homeworkId;
  const HomeworkDetailsView({super.key, required this.homeworkId});

  static const String routeName = '/homework_details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeworkDetailsCubit(HomeworkDetailsRepo(ApiService()))..getHomeworkDetails(homeworkId),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Homework Details',
            style: AppTextStyle.bold18.copyWith(color: AppColors.black),
          ),
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const HomeworkDetailsViewBody(),
      ),
    );
  }
}
