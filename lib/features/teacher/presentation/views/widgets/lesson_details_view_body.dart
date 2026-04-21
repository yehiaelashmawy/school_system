import 'package:flutter/material.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/learning_objectives_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_details_header.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_file_card.dart';

class LessonDetailsViewBody extends StatelessWidget {
  const LessonDetailsViewBody({super.key, this.lessonId});
  final String? lessonId;

  Future<Map<String, dynamic>> _fetchLessonData() async {
    if (lessonId == null || lessonId!.trim().isEmpty) {
      return {
        'description': 'No lesson selected.',
        'materials': const <Map<String, dynamic>>[],
      };
    }

    final response = await ApiService().get('/api/Lessons/$lessonId');
    final data = response is Map<String, dynamic>
        ? response['data'] as Map<String, dynamic>?
        : null;
    final description = data?['description']?.toString() ?? '';
    final materialsRaw = data?['materials'];
    final materials = materialsRaw is List
        ? materialsRaw
              .whereType<Map>()
              .map((item) => item.cast<String, dynamic>())
              .toList()
        : <Map<String, dynamic>>[];

    return {
      'description': description.isNotEmpty
          ? description
          : 'No description available.',
      'materials': materials,
    };
  }

  String _formatFileSize(dynamic bytesRaw) {
    final bytes = (bytesRaw as num?)?.toDouble() ?? 0;
    if (bytes <= 0) return 'Unknown size';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(0)} KB';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  bool _isPdf(String fileType, String fileName) {
    final lowerType = fileType.toLowerCase();
    final lowerName = fileName.toLowerCase();
    return lowerType.contains('pdf') || lowerName.endsWith('.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchLessonData(),
      builder: (context, snapshot) {
        String description = 'Loading lesson description...';
        List<Map<String, dynamic>> materials = const [];
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            description = 'Failed to load lesson description.';
          } else {
            final result = snapshot.data ?? const <String, dynamic>{};
            description =
                result['description']?.toString() ?? 'No description available.';
            final rawMaterials = result['materials'];
            if (rawMaterials is List<Map<String, dynamic>>) {
              materials = rawMaterials;
            }
          }
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LessonDetailsHeader(),

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
                      description,
                      style: AppTextStyle.regular16.copyWith(
                        color: AppColors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const LearningObjectivesSection(),

                    const SizedBox(height: 32),

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
                          '${materials.length} Files',
                          style: TextStyle(
                            color: Color(0xff0F52BD),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (materials.isEmpty)
                      Text(
                        'No materials available.',
                        style: AppTextStyle.regular16.copyWith(
                          color: AppColors.grey,
                        ),
                      )
                    else
                      ...materials.asMap().entries.map((entry) {
                        final index = entry.key;
                        final material = entry.value;
                        final fileName =
                            material['name']?.toString() ?? 'Unknown file';
                        final fileType =
                            material['fileType']?.toString() ?? 'File';
                        final isPdf = _isPdf(fileType, fileName);
                        final fileInfo =
                            '${_formatFileSize(material['fileSize'])} • ${isPdf ? 'PDF Document' : 'Image'}';

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == materials.length - 1 ? 0 : 12,
                          ),
                          child: LessonFileCard(
                            fileName: fileName,
                            fileInfo: fileInfo,
                            iconColor: isPdf
                                ? const Color(0xffFEE2E2)
                                : const Color(0xffDBEAFE),
                            iconData: isPdf ? Icons.picture_as_pdf : Icons.image,
                            iconWidgetColor: isPdf
                                ? const Color(0xffDC2626)
                                : const Color(0xff2563EB),
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
      },
    );
  }
}
