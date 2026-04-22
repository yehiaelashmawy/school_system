import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';

class StudentListItem extends StatelessWidget {
  const StudentListItem({
    super.key,
    required this.name,
    required this.id,
    required this.isOnline,
    required this.avatar,
  });

  final String name;
  final String id;
  final bool isOnline;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: avatar.isEmpty
                      ? Icon(
                          Icons.person,
                          color: AppColors.black.withValues(alpha: 0.54),
                          size: 28,
                        )
                      : avatar.startsWith('assets')
                          ? Image.asset(avatar, fit: BoxFit.cover)
                          : Image.network(
                              avatar,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.person,
                                color: AppColors.black.withValues(alpha: 0.54),
                                size: 28,
                              ),
                            ),
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: $id',
                  style: TextStyle(fontSize: 14, color: AppColors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.lightGrey),
        ],
      ),
    );
  }
}
