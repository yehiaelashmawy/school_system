import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/custom_snack_bar.dart';
import 'package:school_system/features/teacher/data/repos/homework_details_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/homework_details_cubit/homework_details_cubit.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_details_view_body.dart';

class HomeworkDetailsView extends StatelessWidget {
  final String homeworkId;
  const HomeworkDetailsView({super.key, required this.homeworkId});

  static const String routeName = '/homework_details';

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Homework',
          style: AppTextStyle.bold18.copyWith(color: AppColors.black),
        ),
        content: Text(
          'Are you sure you want to delete this homework? This action cannot be undone.',
          style: AppTextStyle.regular14.copyWith(color: AppColors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel', style: TextStyle(color: AppColors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<HomeworkDetailsCubit>().deleteHomework(homeworkId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeworkDetailsCubit(HomeworkDetailsRepo(ApiService()))
            ..getHomeworkDetails(homeworkId),
      child: BlocConsumer<HomeworkDetailsCubit, HomeworkDetailsState>(
        listener: (context, state) {
          if (state is HomeworkDeleteSuccess) {
            CustomSnackBar.showSuccess(context, state.message);
            Navigator.pop(context, true); // return true so list can refresh
          } else if (state is HomeworkDeleteFailure) {
            CustomSnackBar.showError(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          final isDeleting = state is HomeworkDeleteLoading;

          return Scaffold(
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
              actions: [
                if (isDeleting)
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: 'Delete Homework',
                    onPressed: () => _confirmDelete(context),
                  ),
              ],
            ),
            body: const HomeworkDetailsViewBody(),
          );
        },
      ),
    );
  }
}
