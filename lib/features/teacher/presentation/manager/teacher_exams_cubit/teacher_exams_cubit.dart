import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/teacher_exams_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_exams_cubit/teacher_exams_state.dart';

class TeacherExamsCubit extends Cubit<TeacherExamsState> {
  final TeacherExamsRepo repo;

  TeacherExamsCubit(this.repo) : super(TeacherExamsInitial());

  Future<void> fetchExams() async {
    emit(TeacherExamsLoading());
    final result = await repo.getTeacherExams();
    result.fold(
      (error) => emit(TeacherExamsFailure(error)),
      (exams) => emit(TeacherExamsSuccess(exams)),
    );
  }
}
