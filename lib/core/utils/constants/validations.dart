bool isValidEmail(String email) {
  return RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ).hasMatch(email);
}

bool validationPassword(String password) {
  final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
  return regex.hasMatch(password);
}