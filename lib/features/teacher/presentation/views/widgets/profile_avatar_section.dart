import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';
import 'package:school_system/core/utils/app_constants.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({
    super.key,
    required this.name,
    required this.title,
    this.pickedImagePath,
    this.networkImageUrl,
    required this.onPickPhoto,
  });

  final String name;
  final String title;
  final String? pickedImagePath;
  final String? networkImageUrl;
  final VoidCallback onPickPhoto;

  Widget _buildAvatar() {
    String url = networkImageUrl?.trim() ?? '';
    if (url.startsWith('/')) {
      url = '${AppConstants.apiBaseUrl}$url';
    }
    if (!kIsWeb && Platform.isAndroid && url.startsWith('https://localhost')) {
      url = url.replaceFirst('https://localhost', 'https://10.0.2.2');
    }
    final token = SharedPrefsHelper.token;
    final headers = (token != null && token.isNotEmpty)
        ? {'Authorization': 'Bearer $token'}
        : const <String, String>{};

    return ClipOval(
      child: SizedBox(
        width: 130,
        height: 130,
        child: pickedImagePath != null
            ? Image.file(
                File(pickedImagePath!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/profile_photo.png',
                    fit: BoxFit.cover,
                  );
                },
              )
            : (url.isNotEmpty
                ? Image.network(
                    url,
                    headers: headers,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/profile_photo.png',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/profile_photo.png',
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              _buildAvatar(),
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
