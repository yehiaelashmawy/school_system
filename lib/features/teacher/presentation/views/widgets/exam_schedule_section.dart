import 'package:flutter/material.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';

class ExamScheduleSection extends StatefulWidget {
  const ExamScheduleSection({super.key});

  @override
  State<ExamScheduleSection> createState() => _ExamScheduleSectionState();
}

class _ExamScheduleSectionState extends State<ExamScheduleSection> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        _dateController.text =
            "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}";
      });
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null && mounted) {
      setState(() {
        if (isStart) {
          _startTimeController.text = time.format(context);
        } else {
          _endTimeController.text = time.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(label: 'Exam Date'),
        const SizedBox(height: 8),
        CustomTextField(
          hintText: 'mm/dd/yyyy',
          controller: _dateController,
          readOnly: true,
          onTap: _pickDate,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel(label: 'Start Time'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: '--:-- --',
                    controller: _startTimeController,
                    readOnly: true,
                    onTap: () => _pickTime(true),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel(label: 'End Time'),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: '--:-- --',
                    controller: _endTimeController,
                    readOnly: true,
                    onTap: () => _pickTime(false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
