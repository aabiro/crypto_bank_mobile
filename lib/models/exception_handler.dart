class ExceptionHandler implements Exception {
  final String msg;

  ExceptionHandler(this.msg);

  @override
  String toString() {
    return msg;
  }
}