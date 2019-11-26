class FetchException implements Exception {
  String cause;
  FetchException(this.cause);
}

class UnauthorizedException implements Exception {
  String cause;
  UnauthorizedException(this.cause);
}

