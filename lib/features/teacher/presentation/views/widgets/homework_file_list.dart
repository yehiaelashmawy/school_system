import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/lesson_file_card.dart';

class HomeworkFileList extends StatelessWidget {
  const HomeworkFileList({
    super.key,
    required this.attachedFiles,
  });

  final List<PlatformFile> attachedFiles;

  @override
  Widget build(BuildContext context) {
    if (attachedFiles.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: 16),
        ...attachedFiles.map((file) {
          final isPdf = file.extension?.toLowerCase() == 'pdf';
          final isDoc = file.extension?.toLowerCase() == 'doc' ||
              file.extension?.toLowerCase() == 'docx';
          final kbSize = file.size / 1024;
          final mbSize = kbSize / 1024;
          final sizeStr = mbSize > 1
              ? '${mbSize.toStringAsFixed(1)} MB'
              : '${kbSize.toStringAsFixed(0)} KB';

          var iconData = Icons.insert_drive_file;
          var bgColor = const Color(0xffF3F4F6); // neutral grey
          var fColor = const Color(0xff4B5563);

          if (isPdf) {
            iconData = Icons.picture_as_pdf;
            bgColor = const Color(0xffFEE2E2);
            fColor = const Color(0xffDC2626);
          } else if (!isDoc) {
            // assume image
            iconData = Icons.image;
            bgColor = const Color(0xffDBEAFE);
            fColor = const Color(0xff2563EB);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: LessonFileCard(
              fileName: file.name,
              fileInfo:
                  '$sizeStr • ${isPdf ? 'PDF Document' : (isDoc ? 'Word Document' : 'Image')}',
              iconColor: bgColor,
              iconData: iconData,
              iconWidgetColor: fColor,
            ),
          );
        }),
      ],
    );
  }
}
