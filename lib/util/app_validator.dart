abstract class AppValidator {

  static  String? nameValidation(String text) {
    if (text.trim().isEmpty) {
      return "Please enter your name";
    }
    if (text.trim().length < 3) {
      return "Name must be at least 3 characters";
    }

    final nameRegExp = RegExp(r"^[a-zA-Z\s]+$");
    if (!nameRegExp.hasMatch(text)) {
      return "Please enter a valid name (letters only)";
    }

    return null;
  }

  static  String? emailValidation (String text){
    if (text.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(text)) {
      return 'Please enter a valid email address';
    }
    return null ;
  }

  static String? passwordValidation (String text){
    // 1. Check if the field is empty
    if (text.trim().isEmpty) {
      return 'Password is required';
    }
    if (text.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!text.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!text.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    if (!text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null ;

  }

  static String? confirmPasswordValidation({String? text, required String originalPassword}) {
    if (text == null || text.trim().isEmpty) {
      return 'Confirm Password is required';
    }
    if (text != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }


}


