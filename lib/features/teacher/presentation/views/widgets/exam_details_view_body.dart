import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/data/models/teacher_exam_model.dart';
import 'package:school_system/features/teacher/data/repos/teacher_exams_repo.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/section_header.dart';

class ExamDetailsViewBody extends StatelessWidget {
  const ExamDetailsViewBody({super.key, this.examId});
  final String? examId;

  Future<TeacherExamModel?> _fetchExamDetails() async {
    if (examId == null || examId!.trim().isEmpty) return null;
    final repo = TeacherExamsRepo(ApiService());
    final result = await repo.getExamDetails(examId!);
    return result.fold(
      (failure) => null,
      (exam) => exam,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TeacherExamModel?>(
      future: _fetchExamDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text(
              'Failed to load exam details.',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final exam = snapshot.data!;
        return _buildContent(exam);
      },
    );
  }

  Widget _buildContent(TeacherExamModel exam) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopCard(exam),
          const SizedBox(height: 24),
          const SectionHeader(
            icon: Icons.info_outline,
            title: 'Instructions for Students',
          ),
          const SizedBox(height: 16),
          _buildInstructionsList(exam.instructions),
          const SizedBox(height: 24),
          if (exam.materials.isNotEmpty) ...[
            const SectionHeader(
              icon: Icons.description_outlined,
              title: 'Reference Materials',
            ),
            const SizedBox(height: 16),
            ...exam.materials.map((material) {
              final matMap = material as Map<String, dynamic>;
              final isPdf = matMap['fileType']?.toString().contains('pdf') ?? false;
              final sizeInKb = ((matMap['fileSize'] as num?) ?? 0) / 1024;
              final sizeText = sizeInKb > 1024
                  ? '${(sizeInKb / 1024).toStringAsFixed(1)} MB'
                  : '${sizeInKb.toStringAsFixed(1)} KB';
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildReferenceCard(
                  matMap['name']?.toString() ?? 'Material',
                  '$sizeText • ${isPdf ? 'PDF Document' : 'Document'}',
                  isPdf,
                ),
              );
            }),
            const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }

  Widget _buildTopCard(TeacherExamModel exam) {
    final parsedDate = DateTime.tryParse(exam.date);
    final dateStr = parsedDate != null
        ? DateFormat('MMM dd, yyyy').format(parsedDate)
        : exam.date;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.edit_document,
                  color: Color(0xff2563EB),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.name,
                      style: AppTextStyle.bold18.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${exam.subjectName} ${exam.className} • ${exam.type}',
                      style: AppTextStyle.regular14.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  Icons.calendar_today_outlined,
                  'DATE',
                  dateStr,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoBox(Icons.access_time, 'TIME', exam.startTime),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  Icons.hourglass_empty,
                  'DURATION',
                  '${exam.duration} Minutes',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoBox(
                  Icons.location_on_outlined,
                  'LOCATION',
                  exam.room.isNotEmpty ? exam.room : 'N/A',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.secondaryColor),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyle.semiBold14.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsList(String instructionsStr) {
    final instructions =
        instructionsStr.split('\n').where((s) => s.trim().isNotEmpty).toList();

    if (instructions.isEmpty) {
      return const Text('No specific instructions provided.',
          style: TextStyle(color: Colors.grey));
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: instructions.map((text) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text.trim(),
                    style: AppTextStyle.regular14.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReferenceCard(String title, String subtitle, bool isPdf) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: isPdf ? const Color(0xffFEE2E2) : const Color(0xffDBEAFE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf : Icons.article,
              color: isPdf ? const Color(0xffDC2626) : const Color(0xff2563EB),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.semiBold14.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyle.regular12.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.file_download_outlined,
              color: AppColors.secondaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
