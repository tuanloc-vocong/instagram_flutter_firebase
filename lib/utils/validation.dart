class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty) return 'Username is required.';
    final RegExp nameExp = new RegExp(r'^[A-za-z]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
  }

  static String? validateEmail(String? value, [bool isRequired = true]) {
    if (value!.isEmpty && isRequired) return 'Email is required.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequired) {
      return 'Invalid email address';
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Please enter a valid password.';
    }
  }
}
