import 'package:flutter/foundation.dart';
import '../../../data/models/profile_model.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileModel profile;

  ProfileSuccess(this.profile);
}

class ProfileFailure extends ProfileState {
  final String errMessage;

  ProfileFailure(this.errMessage);
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final String successMessage;

  ProfileUpdateSuccess(this.successMessage);
}

class ProfileUpdateFailure extends ProfileState {
  final String errMessage;

  ProfileUpdateFailure(this.errMessage);
}

class ChangePasswordLoading extends ProfileState {}

class ChangePasswordSuccess extends ProfileState {
  final String successMessage;

  ChangePasswordSuccess(this.successMessage);
}

class ChangePasswordFailure extends ProfileState {
  final String errMessage;

  ChangePasswordFailure(this.errMessage);
}
