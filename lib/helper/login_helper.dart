import 'package:flutter/material.dart';

class LoginControllers {
  bool isValidEmail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isValidPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    return true;
    /*return RegExp(
            r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$')
        .hasMatch(password);*/
  }

  bool isValidName(String name) {
    if (name.length < 2) {
      return false;
    }
    return true;
  }

  bool isValidPhone(String phoneNumber) {
    if (phoneNumber.length < 2) {
      return false;
    }
    return true;
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}