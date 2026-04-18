import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepo.getProfile();
      emit(ProfileSuccess(profile));
    } catch (e) {
      // Remove 'Exception: ' prefix if present
      String errorMsg = e.toString();
      if (errorMsg.startsWith('Exception: ')) {
        errorMsg = errorMsg.substring('Exception: '.length);
      }
      emit(ProfileFailure(errorMsg));
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String phone,
    required String department,
    required String position,
    String? avatar,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      final successMsg = await profileRepo.updateProfile(
        fullName: fullName,
        phone: phone,
        department: department,
        position: position,
        avatar: avatar,
      );
      emit(ProfileUpdateSuccess(successMsg));
      // Re-fetch profile to update local state if needed
      await fetchProfile();
    } catch (e) {
      String errorMsg = e.toString();
      if (errorMsg.startsWith('Exception: ')) {
        errorMsg = errorMsg.substring('Exception: '.length);
      }
      emit(ProfileUpdateFailure(errorMsg));
      // Re-fetch to return to the original loaded state instead of being stuck in a failure that doesn't hold the profile model
      await fetchProfile();
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());
    try {
      final successMsg = await profileRepo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(ChangePasswordSuccess(successMsg));
      // Re-fetch in case we want to reset to generic loaded state
      await fetchProfile();
    } catch (e) {
      String errorMsg = e.toString();
      if (errorMsg.startsWith('Exception: ')) {
        errorMsg = errorMsg.substring('Exception: '.length);
      }
      emit(ChangePasswordFailure(errorMsg));
      await fetchProfile();
    }
  }
}
