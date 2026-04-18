import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/teacher/data/repos/teacher_classes_repo.dart';
import 'teacher_classes_state.dart';

class TeacherClassesCubit extends Cubit<TeacherClassesState> {
  final TeacherClassesRepo teacherClassesRepo;

  TeacherClassesCubit(this.teacherClassesRepo) : super(TeacherClassesInitial());

  Future<void> fetchClasses() async {
    emit(TeacherClassesLoading());
    final result = await teacherClassesRepo.getTeacherClasses();
    result.fold(
      (error) => emit(TeacherClassesFailure(error)),
      (classes) => emit(TeacherClassesSuccess(classes)),
    );
  }
}
