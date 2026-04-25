import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/dashed_upload_button.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_file_card.dart';

class ExamAttachmentsSection extends StatefulWidget {
  final ValueChanged<List<PlatformFile>> onFilesChanged;

  const ExamAttachmentsSection({super.key, required this.onFilesChanged});

  @override
  State<ExamAttachmentsSection> createState() => _ExamAttachmentsSectionState();
}

class _ExamAttachmentsSectionState extends State<ExamAttachmentsSection> {
  final List<PlatformFile> _attachedFiles = [];

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _attachedFiles.addAll(result.files);
      });
      widget.onFilesChanged(_attachedFiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: DashedUploadButton(
            title: 'Upload PDF, DOCX or Images',
            icon: Icons.cloud_upload_outlined,
            onTap: _pickFiles,
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'MAX SIZE: 10MB',
            style: AppTextStyle.bold12.copyWith(color: AppColors.grey),
          ),
        ),
        if (_attachedFiles.isNotEmpty) ...[
          const SizedBox(height: 16),
          ..._attachedFiles.map((file) {
            final isPdf = file.extension?.toLowerCase() == 'pdf';
            final kbSize = file.size / 1024;
            final mbSize = kbSize / 1024;
            final sizeStr = mbSize > 1
                ? '${mbSize.toStringAsFixed(1)} MB'
                : '${kbSize.toStringAsFixed(0)} KB';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LessonFileCard(
                fileName: file.name,
                fileInfo: sizeStr,
                iconColor: const Color(0xffFEE2E2),
                iconData: isPdf
                    ? Icons.picture_as_pdf
                    : Icons.insert_drive_file,
                iconWidgetColor: const Color(0xffDC2626),
              ),
            );
          }),
        ],
      ],
    );
  }
}
