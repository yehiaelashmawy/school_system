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
}
