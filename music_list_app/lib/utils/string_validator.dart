const _emailAddressRegex =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

String validateEmailAddress(String input) {
  return RegExp(_emailAddressRegex).hasMatch(input)
      ? null
      : 'Invalid email format';
}

String validatePassword(String password) {
  return password.length >= 6
      ? null
      : 'Password must contain at least 6 characters';
}

String validateNonEmptyMessage(String input) {
  return input == null || input.isEmpty ? 'This field must not be empty' : null;
}
