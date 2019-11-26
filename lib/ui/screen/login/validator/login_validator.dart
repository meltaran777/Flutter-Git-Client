import 'dart:async';

bool isUsernameValid(String email) {
  return true;
}

bool isPasswordValid(String password) {
  return password.length > 3;
}

class LoginValidator {
  final validateUsername =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (isUsernameValid(email)) {
      sink.add(email);
    } else {
      sink.add("");
      sink.addError("Enter a valid username");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (isPasswordValid(password)) {
          sink.add(password);
        } else {
          sink.add("");
          sink.addError("Enter a valid password");
        }
      });
}
