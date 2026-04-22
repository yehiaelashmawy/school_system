import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/student/data/repos/student_grades_repo.dart';
import 'student_grades_state.dart';

class StudentGradesCubit extends Cubit<StudentGradesState> {
  final StudentGradesRepo _repo;

  StudentGradesCubit(this._repo) : super(StudentGradesInitial());

  Future<void> fetchGradesDashboard() async {
    emit(StudentGradesLoading());
    final result = await _repo.fetchGradesDashboard();
    result.fold(
      (error) => emit(StudentGradesFailure(error)),
      (data) => emit(StudentGradesSuccess(data)),
    );
  }
}
