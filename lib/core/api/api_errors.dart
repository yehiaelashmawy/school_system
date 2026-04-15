class ApiErrors {
  final String errorMessage;

  ApiErrors({required this.errorMessage});
  @override
  String toString() {
    return 'error message : $errorMessage';
  }
}
