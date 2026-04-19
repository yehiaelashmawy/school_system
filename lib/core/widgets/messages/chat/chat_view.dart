import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/theme_manager.dart';
import 'package:school_system/core/widgets/messages/message_model.dart';
import 'chat_view_body.dart';
import 'widgets/chat_app_bar_title.dart';

class ChatView extends StatelessWidget {
  final Object? conversation;

  const ChatView({super.key, this.conversation});
  static const String routeName = 'chat_view';

  @override
  Widget build(BuildContext context) {
    final message = conversation is MessageModel ? conversation as MessageModel : null;

    return Scaffold(
      backgroundColor: ThemeManager.isDarkMode
          ? AppColors.backgroundColor
          : AppColors.white,
      appBar: AppBar(
        backgroundColor: ThemeManager.isDarkMode
            ? AppColors.backgroundColor
            : AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ThemeManager.isDarkMode ? Colors.white : AppColors.darkBlue,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: ChatAppBarTitle(
          title: message?.senderName.isNotEmpty == true
              ? message!.senderName
              : (message?.name ?? 'Chat'),
          subtitle: message?.senderRoleRaw.isNotEmpty == true
              ? message!.senderRoleRaw
              : 'Online',
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.videocam_outlined,
              color: ThemeManager.isDarkMode
                  ? Colors.white
                  : AppColors.darkBlue,
              size: 28,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: ThemeManager.isDarkMode
                  ? Colors.white
                  : AppColors.darkBlue,
              size: 26,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: ThemeManager.isDarkMode
                ? AppColors.lightGrey.withValues(alpha: 0.3)
                : const Color(0xffE2E8F0),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(child: ChatViewBody(conversation: message)),
    );
  }
}
