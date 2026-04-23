import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';
import 'package:school_system/features/teacher/data/repos/homework_details_repo.dart';

abstract class HomeworkDetailsState {}

class HomeworkDetailsInitial extends HomeworkDetailsState {}

class HomeworkDetailsLoading extends HomeworkDetailsState {}

class HomeworkDetailsSuccess extends HomeworkDetailsState {
  final TeacherHomeworkModel homework;
  HomeworkDetailsSuccess(this.homework);
}

class HomeworkDetailsFailure extends HomeworkDetailsState {
  final String errorMessage;
  HomeworkDetailsFailure(this.errorMessage);
}

class HomeworkDeleteLoading extends HomeworkDetailsState {}

class HomeworkDeleteSuccess extends HomeworkDetailsState {
  final String message;
  HomeworkDeleteSuccess(this.message);
}

class HomeworkDeleteFailure extends HomeworkDetailsState {
  final String errorMessage;
  HomeworkDeleteFailure(this.errorMessage);
}

class HomeworkDetailsCubit extends Cubit<HomeworkDetailsState> {
  final HomeworkDetailsRepo repo;

  HomeworkDetailsCubit(this.repo) : super(HomeworkDetailsInitial());

  Future<void> getHomeworkDetails(String homeworkId) async {
    emit(HomeworkDetailsLoading());
    final result = await repo.getHomeworkDetails(homeworkId);
    result.fold(
      (error) => emit(HomeworkDetailsFailure(error.errorMessage)),
      (homework) => emit(HomeworkDetailsSuccess(homework)),
    );
  }

  Future<void> deleteHomework(String homeworkId) async {
    emit(HomeworkDeleteLoading());
    final result = await repo.deleteHomework(homeworkId);
    result.fold(
      (error) => emit(HomeworkDeleteFailure(error.errorMessage)),
      (message) => emit(HomeworkDeleteSuccess(message)),
    );
  }
}
