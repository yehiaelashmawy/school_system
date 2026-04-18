abstract class AddLessonState {}

class AddLessonInitial extends AddLessonState {}

class AddLessonLoading extends AddLessonState {}

class AddLessonSuccess extends AddLessonState {
  final String message;
  AddLessonSuccess(this.message);
}

class AddLessonFailure extends AddLessonState {
  final String errorMessage;
  AddLessonFailure(this.errorMessage);
}
