class AddHomeworkState {}

class AddHomeworkInitial extends AddHomeworkState {}

class AddHomeworkLoading extends AddHomeworkState {}

class AddHomeworkSuccess extends AddHomeworkState {
  final String message;

  AddHomeworkSuccess(this.message);
}

class AddHomeworkFailure extends AddHomeworkState {
  final String errorMessage;

  AddHomeworkFailure(this.errorMessage);
}
