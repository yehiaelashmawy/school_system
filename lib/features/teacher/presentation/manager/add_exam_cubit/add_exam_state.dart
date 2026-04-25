abstract class AddExamState {}

class AddExamInitial extends AddExamState {}

class AddExamLoading extends AddExamState {}

class AddExamSuccess extends AddExamState {
  final String examId;
  AddExamSuccess(this.examId);
}

class AddExamFailure extends AddExamState {
  final String errorMessage;
  AddExamFailure(this.errorMessage);
}
