import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/utils/size_config.dart';
import 'package:school_system/core/utils/theme_manager.dart';
import 'dart:io';
import '../models/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 24.0,
        left: message.isSender ? 64 : 16,
        right: message.isSender ? 16 : 64,
      ),
      child: message.isSender ? _buildSender(context) : _buildReceiver(context),
    );
  }

  Widget _buildSender(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: message.imageUrl == "placeholder"
                        ? Container(
                            height: 150,
                            width: 200,
                            color: const Color(0xffEBB486),
                          )
                        : Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(message.imageUrl!)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                )
              else if (message.attachedFileName != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 200),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.insert_drive_file,
                            color: Colors.white, size: 24),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            message.attachedFileName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.regular14
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (message.text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors
                        .primaryColor, // Replaced hardcoded blue with theme primaryColor
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyle.regular14.copyWith(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: SizeConfig.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              Text(
                message.time,
                style: AppTextStyle.regular12.copyWith(
                  color: AppColors.grey.withOpacity(0.6),
                  fontSize: SizeConfig.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 12,
          backgroundColor: Color(0xffD0A785),
          child: Icon(Icons.person, size: 16, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildReceiver(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CircleAvatar(
          radius: 12,
          backgroundColor: Color(0xffADD8E6),
          child: Icon(Icons.person, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: message.imageUrl == "placeholder"
                        ? Container(
                            height: 150,
                            width: 250,
                            color: const Color(0xffEBB486),
                          )
                        : Container(
                            height: 150,
                            width: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(File(message.imageUrl!)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                )
              else if (message.attachedFileName != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 250),
                    decoration: BoxDecoration(
                      color: ThemeManager.isDarkMode
                          ? AppColors.white
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: ThemeManager.isDarkMode
                          ? Border.all(
                              color: AppColors.lightGrey.withOpacity(0.3),
                            )
                          : Border.all(color: const Color(0xffE2E8F0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.insert_drive_file,
                            color: AppColors.primaryColor, size: 24),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            message.attachedFileName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.regular14.copyWith(
                              color: ThemeManager.isDarkMode
                                  ? Colors.white
                                  : const Color(0xff334155),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (message.text.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ThemeManager.isDarkMode
                        ? AppColors.white
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(16),
                    ),
                    border: ThemeManager.isDarkMode
                        ? Border.all(
                            color: AppColors.lightGrey.withOpacity(0.3),
                          )
                        : Border.all(color: const Color(0xffE2E8F0)),
                    boxShadow: ThemeManager.isDarkMode
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyle.regular14.copyWith(
                      color: ThemeManager.isDarkMode
                          ? Colors.white
                          : const Color(0xff334155),
                      height: 1.5,
                      fontSize: SizeConfig.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 6),
              Text(
                message.time,
                style: AppTextStyle.regular12.copyWith(
                  color: AppColors.grey.withOpacity(0.6),
                  fontSize: SizeConfig.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
