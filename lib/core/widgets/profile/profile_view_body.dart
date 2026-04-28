import 'package:flutter/material.dart';
import 'package:school_system/core/utils/app_colors.dart';
import 'package:school_system/core/utils/app_text_style.dart';
import 'package:school_system/features/Auth/presentation/views/auth_view.dart';
import 'package:school_system/features/teacher/presentation/views/personal_information_view.dart';
import 'package:school_system/features/teacher/presentation/views/change_password_view.dart';
import 'package:school_system/features/teacher/presentation/views/settings_view.dart';
import 'package:school_system/core/widgets/profile/profile_logout_button.dart';
import 'package:school_system/core/widgets/profile/profile_menu_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/core/widgets/profile/profile_avatar.dart';
import 'package:school_system/core/helper/shared_prefs_helper.dart';

import 'package:school_system/features/teacher/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:school_system/features/teacher/presentation/manager/profile_cubit/profile_state.dart';
import 'package:school_system/features/teacher/data/repos/profile_repo.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
    required this.name,
    required this.roleTitle,
  });

  final String name;
  final String roleTitle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                'Profile',
                style: AppTextStyle.bold16.copyWith(
                  color: AppColors.darkBlue,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocProvider(
              create: (context) => ProfileCubit(ProfileRepo())..fetchProfile(),
              child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            String displayAvatarName = name;
                            String displayAvatarTitle = roleTitle;
                            String? avatarUrl;

                            if (state is ProfileLoading) {
                              displayAvatarName = 'Loading...';
                              displayAvatarTitle = 'Loading...';
                            } else if (state is ProfileSuccess) {
                              displayAvatarName = state.profile.fullName ?? name;
                              displayAvatarTitle =
                                  state.profile.position ?? roleTitle;
                              avatarUrl = state.profile.avatar;
                            }

                            return ProfileAvatar(
                              name: displayAvatarName,
                              title: displayAvatarTitle,
                              networkImageUrl: avatarUrl,
                              onEditTap: () {
                                Navigator.pushNamed(
                                  context,
                                  PersonalInformationView.routeName,
                                ).then((_) {
                                  if (!context.mounted) return;
                                  context.read<ProfileCubit>().fetchProfile();
                                });
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        ProfileMenuTile(
                          title: 'Personal Information',
                          icon: Icons.person_outline,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PersonalInformationView.routeName,
                            ).then((_) {
                              if (!context.mounted) return;
                              context.read<ProfileCubit>().fetchProfile();
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        ProfileMenuTile(
                          title: 'Settings',
                          icon: Icons.settings_outlined,
                          onTap: () {
                            Navigator.pushNamed(context, SettingsView.routeName);
                          },
                        ),
                        const SizedBox(height: 16),
                        ProfileMenuTile(
                          title: 'Change Password',
                          icon: Icons.lock_outline,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ChangePasswordView.routeName,
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        ProfileLogoutButton(
                          onTap: () async {
                            await SharedPrefsHelper.clearAuth();
                            if (!context.mounted) return;
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamedAndRemoveUntil(
                              AuthView.routeName,
                              (route) => false,
                            );
                          },
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
