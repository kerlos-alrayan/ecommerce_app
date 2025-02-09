import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserModel userModel;
  RegisterSuccess(this.userModel);
}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}
