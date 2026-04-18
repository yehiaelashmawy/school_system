import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/features/teacher/data/models/teacher_class_model.dart';

abstract class TeacherClassesState {}

class TeacherClassesInitial extends TeacherClassesState {}

class TeacherClassesLoading extends TeacherClassesState {}

class TeacherClassesSuccess extends TeacherClassesState {
  final List<TeacherClassModel> classes;

  TeacherClassesSuccess(this.classes);
}

class TeacherClassesFailure extends TeacherClassesState {
  final ApiErrors error;

  TeacherClassesFailure(this.error);
}
