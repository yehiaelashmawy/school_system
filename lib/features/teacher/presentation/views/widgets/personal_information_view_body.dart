import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/personal_information_action_buttons.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/profile_avatar_section.dart';
import 'package:school_system/features/teacher/presentation/views/widgets/profile_field_section.dart';

import '../../manager/profile_cubit/profile_cubit.dart';
import '../../manager/profile_cubit/profile_state.dart';

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
  String _displayName = 'Loading...';
  String _displayTitle = 'Loading...';

  @override
  void initState() {
    super.initState();
    // Default empty fields since we fetch from API
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
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _experienceController.clear();
    _pickedImagePath = null;
    // Re-trigger fetch or reset from initial?
    context.read<ProfileCubit>().fetchProfile();
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
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ProfileSuccess) {
          final profile = state.profile;
          _nameController.text = profile.fullName ?? '';
          _emailController.text = profile.email ?? '';
          _phoneController.text = profile.phone ?? '';
          _subjectController.text = profile.department ?? '';
          _experienceController.text = profile.employeeId ?? '';
          
          setState(() {
            _displayName = profile.fullName ?? 'Unknown';
            _displayTitle = profile.position ?? 'Unknown Title';
          });
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
           return const Center(child: CircularProgressIndicator());
        }
        
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileAvatarSection(
                name: _displayName,
                title: _displayTitle,
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
                label: 'Department',
                controller: _subjectController,
                suffixIcon: Icons.school_outlined,
              ),
              
              const SizedBox(height: 16),
              
              ProfileFieldSection(
                label: 'Employee ID',
                controller: _experienceController,
                suffixIcon: Icons.badge_outlined,
              ),
              
              const SizedBox(height: 32),
              
              PersonalInformationActionButtons(
                onSave: _saveChanges,
                onReset: () {
                  _resetDefaults();
                },
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
