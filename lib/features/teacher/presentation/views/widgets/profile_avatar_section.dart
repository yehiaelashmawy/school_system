import 'dart:io';
import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({
    super.key,
    required this.name,
    required this.title,
    this.pickedImagePath,
    required this.onPickPhoto,
  });

  final String name;
  final String title;
  final String? pickedImagePath;
  final VoidCallback onPickPhoto;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 65,
                backgroundColor: Colors.transparent,
                backgroundImage: pickedImagePath != null
                    ? FileImage(File(pickedImagePath!)) as ImageProvider
                    : const AssetImage('assets/images/profile_photo.png'),
              ),
              Positioned(
                bottom: 0,
                right: 4,
                child: GestureDetector(
                  onTap: onPickPhoto,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: AppTextStyle.bold16.copyWith(
              color: AppColors.darkBlue,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyle.regular14.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
