import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/personal_information_action_buttons.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/profile_avatar_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/profile_field_section.dart';

class PersonalInformationViewBody extends StatefulWidget {
  const PersonalInformationViewBody({super.key});

  @override
  State<PersonalInformationViewBody> createState() => _PersonalInformationViewBodyState();
}

class _PersonalInformationViewBodyState extends State<PersonalInformationViewBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  String? _pickedImagePath;

  @override
  void initState() {
    super.initState();
    _resetDefaults();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _resetDefaults() {
    _nameController.text = 'Alex Johnson';
    _emailController.text = 'alex.johnson@edusmart.com';
    _phoneController.text = '+1 (555) 123-4567';
    _subjectController.text = 'Mathematics';
    _experienceController.text = '12';
    _pickedImagePath = null;
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Changes saved successfully!'),
        backgroundColor: AppColors.secondaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedImagePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatarSection(
            name: 'Alex Johnson',
            title: 'Senior Mathematics Educator',
            pickedImagePath: _pickedImagePath,
            onPickPhoto: _pickPhoto,
          ),
          
          const SizedBox(height: 32),
          
          Text(
            'Account Details',
            style: AppTextStyle.bold16.copyWith(
               color: AppColors.darkBlue,
              fontSize: 18,
            ),
          ),
          
          const SizedBox(height: 20),
          
          ProfileFieldSection(
            label: 'Full Name',
            controller: _nameController,
            suffixIcon: Icons.edit_outlined,
          ),
          
          const SizedBox(height: 16),
          
          ProfileFieldSection(
            label: 'Email Address',
            controller: _emailController,
            suffixIcon: Icons.mail_outline,
          ),
          
          const SizedBox(height: 16),
          
          ProfileFieldSection(
            label: 'Phone Number',
            controller: _phoneController,
            suffixIcon: Icons.phone_outlined,
          ),
          
          const SizedBox(height: 16),
          
          ProfileFieldSection(
            label: 'Main Subject',
            controller: _subjectController,
            suffixIcon: Icons.school_outlined,
          ),
          
          const SizedBox(height: 16),
          
          ProfileFieldSection(
            label: 'Years of Experience',
            controller: _experienceController,
            suffixIcon: Icons.badge_outlined,
          ),
          
          const SizedBox(height: 32),
          
          PersonalInformationActionButtons(
            onSave: _saveChanges,
            onReset: () {
              setState(() {
                _resetDefaults();
              });
            },
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
