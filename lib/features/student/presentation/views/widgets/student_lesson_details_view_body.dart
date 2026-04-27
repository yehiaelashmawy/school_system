import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:school_system/core/helper/url_helper.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/widgets/custom_snack_bar.dart';
import 'package:school_system/features/student/data/models/student_lesson_detail_model.dart';
import 'package:school_system/features/student/presentation/manager/student_lesson_detail_cubit/student_lesson_detail_cubit.dart';
import 'package:school_system/features/student/presentation/manager/student_lesson_detail_cubit/student_lesson_detail_state.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_details_header.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_file_card.dart';

class StudentLessonDetailsViewBody extends StatelessWidget {
  const StudentLessonDetailsViewBody({super.key});

  Future<void> _openOrDownloadFile({
    required BuildContext context,
    required StudentLessonMaterial material,
    required bool showSavedMessage,
  }) async {
    final fileName = material.name.isNotEmpty ? material.name : 'lesson_file';
    final rawUrl = material.fileUrl;
    if (rawUrl.trim().isEmpty) {
      CustomSnackBar.showError(context, 'File URL is missing');
      return;
    }

    final fileUrl = UrlHelper.getFullImageUrl(rawUrl);
    if (fileUrl.trim().isEmpty) {
      CustomSnackBar.showError(context, 'Invalid file URL');
      return;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';

      await Dio().download(fileUrl, filePath);
      await OpenFilex.open(filePath);
      if (!context.mounted) return;

      if (showSavedMessage) {
        CustomSnackBar.showSuccess(context, 'File downloaded successfully');
      }
    } catch (_) {
      if (!context.mounted) return;
      CustomSnackBar.showError(context, 'Failed to open/download file');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentLessonDetailCubit, StudentLessonDetailState>(
      builder: (context, state) {
        if (state is StudentLessonDetailInitial ||
            state is StudentLessonDetailLoading) {
          return _buildSkeleton(context);
        }

        if (state is StudentLessonDetailFailure) {
          return _buildError(context, state.error.errorMessage);
        }

        if (state is StudentLessonDetailSuccess) {
          return _buildContent(context, state.lesson);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, StudentLessonDetailModel lesson) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LessonDetailsHeader(
            subjectName: lesson.subjectName.isNotEmpty
                ? lesson.subjectName
                : 'Subject',
            lessonName: lesson.title.isNotEmpty ? lesson.title : 'Lesson',
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DESCRIPTION',
                  style: AppTextStyle.bold16.copyWith(
                    color: AppColors.primaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  lesson.description?.isNotEmpty == true
                      ? lesson.description!
                      : 'No description available.',
                  style: AppTextStyle.regular16.copyWith(
                    color: AppColors.grey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                if (lesson.objectives.isNotEmpty) ...[
                  _StudentLearningObjectivesSection(
                    objectives: lesson.objectives,
                  ),
                  const SizedBox(height: 32),
                ],

                // Lesson Files Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lesson Files',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${lesson.materials.length} Files',
                      style: const TextStyle(
                        color: Color(0xff0F52BD),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (lesson.materials.isEmpty)
                  Text(
                    'No materials available.',
                    style: AppTextStyle.regular16.copyWith(
                      color: AppColors.grey,
                    ),
                  )
                else
                  ...lesson.materials.asMap().entries.map((entry) {
                    final index = entry.key;
                    final material = entry.value;
                    final isPdf = material.isPdf;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == lesson.materials.length - 1 ? 0 : 12,
                      ),
                      child: LessonFileCard(
                        fileName: material.name,
                        fileInfo:
                            '${material.formattedSize} • ${isPdf ? 'PDF Document' : 'Image'}',
                        iconColor: isPdf
                            ? const Color(0xffFEE2E2)
                            : const Color(0xffDBEAFE),
                        iconData: isPdf ? Icons.picture_as_pdf : Icons.image,
                        iconWidgetColor: isPdf
                            ? const Color(0xffDC2626)
                            : const Color(0xff2563EB),
                        onTap: () => _openOrDownloadFile(
                          context: context,
                          material: material,
                          showSavedMessage: false,
                        ),
                        onDownloadTap: () => _openOrDownloadFile(
                          context: context,
                          material: material,
                          showSavedMessage: true,
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: _buildContent(
        context,
        StudentLessonDetailModel(
          oid: '',
          title: 'Loading Lesson',
          description: 'Loading lesson description...',
          status: 'Upcoming',
          type: 'Lecture',
          className: 'Class',
          subjectName: 'Subject',
          teacherName: 'Teacher',
          duration: 60,
          materialsCount: 1,
          objectivesCount: 2,
          hasHomework: false,
          objectives: [
            StudentLessonObjective(
              oid: '',
              description: 'Loading objective 1',
              order: 1,
            ),
            StudentLessonObjective(
              oid: '',
              description: 'Loading objective 2',
              order: 2,
            ),
          ],
          materials: [
            StudentLessonMaterial(
              oid: '',
              name: 'Loading_file.pdf',
              fileUrl: '',
              fileType: 'pdf',
              fileSize: 1024,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.grey.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.medium14.copyWith(color: AppColors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  context.read<StudentLessonDetailCubit>().fetchLesson(''),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentLearningObjectivesSection extends StatelessWidget {
  final List<StudentLessonObjective> objectives;

  const _StudentLearningObjectivesSection({required this.objectives});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE8F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.fact_check_outlined,
                color: AppColors.darkBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Learning Objectives',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...objectives.map(
            (obj) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildObjectiveItem(obj.description),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObjectiveItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Icon(
            Icons.check_circle_outline,
            color: Color(0xff0F52BD),
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: AppColors.grey, fontSize: 13, height: 1.4),
          ),
        ),
      ],
    );
  }
}
