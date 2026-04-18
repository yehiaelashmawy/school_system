import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/teacher_subjects_repo.dart';
import 'package:school_system/features/teacher/presentation/manager/teacher_subjects_cubit/teacher_subjects_state.dart';

class TeacherSubjectsCubit extends Cubit<TeacherSubjectsState> {
  final TeacherSubjectsRepo teacherSubjectsRepo;

  TeacherSubjectsCubit(this.teacherSubjectsRepo) : super(TeacherSubjectsInitial());

  Future<void> fetchSubjects() async {
    emit(TeacherSubjectsLoading());
    final result = await teacherSubjectsRepo.getTeacherSubjects();
    
    result.fold(
      (error) => emit(TeacherSubjectsFailure(error)),
      (subjects) => emit(TeacherSubjectsSuccess(subjects)),
    );
  }
}
