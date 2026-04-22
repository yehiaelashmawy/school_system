import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/student/data/repos/student_homework_repo.dart';
import 'student_homework_state.dart';

class StudentHomeworkCubit extends Cubit<StudentHomeworkState> {
  final StudentHomeworkRepo _repo;

  StudentHomeworkCubit(this._repo) : super(StudentHomeworkInitial());

  Future<void> fetchHomeworks() async {
    emit(StudentHomeworkLoading());
    final result = await _repo.fetchHomeworks();
    result.fold(
      (error) => emit(StudentHomeworkFailure(error)),
      (data) => emit(StudentHomeworkSuccess(data)),
    );
  }
}
