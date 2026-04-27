import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/student/data/repos/student_lessons_repo.dart';
import 'package:school_system/features/student/presentation/manager/student_lesson_detail_cubit/student_lesson_detail_state.dart';

class StudentLessonDetailCubit extends Cubit<StudentLessonDetailState> {
  final StudentLessonsRepo studentLessonsRepo;

  StudentLessonDetailCubit(this.studentLessonsRepo)
      : super(StudentLessonDetailInitial());

  Future<void> fetchLesson(String lessonId) async {
    emit(StudentLessonDetailLoading());
    final result = await studentLessonsRepo.fetchLessonDetails(lessonId);

    result.fold(
      (failure) => emit(StudentLessonDetailFailure(failure)),
      (lesson) => emit(StudentLessonDetailSuccess(lesson)),
    );
  }
}
