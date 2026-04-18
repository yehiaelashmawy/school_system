import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/core/utils/theme_manager.dart';
import 'package:school_system/core/widgets/messages/manager/messages_cubit.dart';
import 'package:school_system/core/widgets/messages/manager/messages_state.dart';
import 'message_item.dart';

class MessagesViewBody extends StatelessWidget {
  const MessagesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeManager.isDarkMode
                  ? AppColors.darkBlue
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: ThemeManager.isDarkMode
                  ? Border.all(
                      color: AppColors.lightGrey.withValues(alpha: 0.5),
                    )
                  : Border.all(color: const Color(0xffE2E8F0)),
              boxShadow: ThemeManager.isDarkMode
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search conversations',
                hintStyle: AppTextStyle.regular14.copyWith(
                  color: AppColors.grey,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ),

        // TabBar
        TabBar(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.grey,
          labelStyle: AppTextStyle.bold16,
          unselectedLabelStyle: AppTextStyle.semiBold16,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          dividerColor: ThemeManager.isDarkMode
              ? AppColors.lightGrey
              : const Color(0xffE2E8F0),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Teachers'),
            Tab(text: 'Students'),
            Tab(text: 'Parents'),
          ],
        ),

        // Lists
        Expanded(
          child: BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MessagesFailure) {
                return Center(
                  child: Text(
                    state.errMessage,
                    style: AppTextStyle.bold16.copyWith(color: Colors.red),
                  ),
                );
              } else if (state is MessagesSuccess) {
                final allMessages = state.messages;

                return TabBarView(
                  children: [
                    // All
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allMessages.length,
                      itemBuilder: (context, index) =>
                          MessageItem(message: allMessages[index]),
                    ),
                    // Teachers
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allMessages
                          .where((m) => m.role == '(Teacher)')
                          .length,
                      itemBuilder: (context, index) {
                        final teachers = allMessages
                            .where((m) => m.role == '(Teacher)')
                            .toList();
                        return MessageItem(message: teachers[index]);
                      },
                    ),
                    // Students
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allMessages
                          .where((m) => m.role == '(Student)')
                          .length,
                      itemBuilder: (context, index) {
                        final students = allMessages
                            .where((m) => m.role == '(Student)')
                            .toList();
                        return MessageItem(message: students[index]);
                      },
                    ),
                    // Parents
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allMessages
                          .where((m) => m.role == '(Parent)')
                          .length,
                      itemBuilder: (context, index) {
                        final parents = allMessages
                            .where((m) => m.role == '(Parent)')
                            .toList();
                        return MessageItem(message: parents[index]);
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
