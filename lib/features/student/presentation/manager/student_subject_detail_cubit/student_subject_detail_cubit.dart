import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_system/features/student/data/repos/student_my_subjects_repo.dart';
import 'student_subject_detail_state.dart';

class StudentSubjectDetailCubit extends Cubit<StudentSubjectDetailState> {
  final StudentMySubjectsRepo _repo;

  StudentSubjectDetailCubit(this._repo) : super(StudentSubjectDetailInitial());

  Future<void> fetchSubjectDetail(String subjectId) async {
    emit(StudentSubjectDetailLoading());
    final result = await _repo.fetchSubjectDetail(subjectId);
    result.fold(
      (error) => emit(StudentSubjectDetailFailure(error)),
      (data) => emit(StudentSubjectDetailSuccess(data)),
    );
  }
}
