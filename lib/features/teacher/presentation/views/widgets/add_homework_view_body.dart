import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_attachments_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_due_date_time_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/homework_file_list.dart';

class AddHomeworkViewBody extends StatefulWidget {
  const AddHomeworkViewBody({super.key});

  @override
  State<AddHomeworkViewBody> createState() => _AddHomeworkViewBodyState();
}

class _AddHomeworkViewBodyState extends State<AddHomeworkViewBody> {
  final List<PlatformFile> _attachedFiles = [];
  String? _selectedClass;

  final List<String> _classes = [
    'Class 10A',
    'Class 10B',
    'Class 11A',
    'Class 11B',
    'Class 12A',
    'Class 12B',
  ];

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel(label: 'Select Class'),
          const SizedBox(height: 8),
          CustomDropdownField(
            hintText: 'Choose a class',
            items: _classes,
            value: _selectedClass,
            onChanged: (val) {
              setState(() {
                _selectedClass = val;
              });
            },
          ),
          const SizedBox(height: 20),

          const FieldLabel(label: 'Homework Title'),
          const SizedBox(height: 8),
          const CustomTextField(hintText: 'e.g. Quadratic Equations Practice'),
          const SizedBox(height: 20),

          const FieldLabel(label: 'Description'),
          const SizedBox(height: 8),
          const CustomTextField(
            hintText:
                'Enter homework instructions, references, or specific requirements...',
            minLines: 4,
            maxLines: 6,
          ),
          const SizedBox(height: 20),

          const HomeworkDueDateTimeSection(),
          const SizedBox(height: 20),

          const FieldLabel(label: 'Points / Max Grade'),
          const SizedBox(height: 8),
          const CustomTextField(
            hintText: '100',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),

          const FieldLabel(label: 'Attachments'),
          const SizedBox(height: 12),
          HomeworkAttachmentsSection(onTap: _pickFiles),

          HomeworkFileList(attachedFiles: _attachedFiles),

          const SizedBox(height: 40),

          _buildCreateButton(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(Icons.send_outlined, color: AppColors.white, size: 20),
        label: Text(
          'Create Homework',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
