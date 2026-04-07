import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/custom_text_field.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/field_label.dart';

class HomeworkDueDateTimeSection extends StatefulWidget {
  const HomeworkDueDateTimeSection({super.key});

  @override
  State<HomeworkDueDateTimeSection> createState() =>
      _HomeworkDueDateTimeSectionState();
}

class _HomeworkDueDateTimeSectionState
    extends State<HomeworkDueDateTimeSection> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
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

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null && mounted) {
      setState(() {
        _timeController.text = time.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Due Date'),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'mm/dd/yyyy',
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FieldLabel(label: 'Due Time'),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: '--:-- --',
                controller: _timeController,
                readOnly: true,
                onTap: _pickTime,
                suffixIcon: Icon(Icons.access_time, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
