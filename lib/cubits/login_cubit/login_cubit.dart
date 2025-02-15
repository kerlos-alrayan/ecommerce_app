import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lafyuu/constants/api_constants.dart';
import 'package:lafyuu/helper/shared_prefs_helper.dart';
import 'package:lafyuu/models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/presentation/screens/auth_screens/login_screen.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    emit(LoginLoading());

    try {
      var response = await Dio().post(
        ApiConstants.LOGIN,
        data: {'email': email, 'password': password},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );

      print("🟢 Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        LoginModel loginModel = LoginModel.fromJson(response.data);
        String? token = loginModel.data?.token;

        if (token != null && token.isNotEmpty) {
          print("✅ Token received: $token");

          await SharedPrefsHelper.saveToken(token);
          print("🔹 Token saved successfully!");

          // حفظ التوكن في SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          emit(LoginSuccess(loginModel));
        } else {
          print("❌ Token is empty or null");
          emit(LoginFailure("Received empty token"));
        }
      } else {
        print("❌ Unexpected response code: ${response.statusCode}");
        emit(LoginFailure("Unexpected error: ${response.statusCode}"));
      }
    } on DioException catch (error) {
      print("❌ DioError: ${error.response?.data}");
      emit(LoginFailure(error.response?.data['message'] ?? "Unknown error"));
    } catch (error) {
      print("❌ Unexpected error: $error");
      emit(LoginFailure("An unexpected error occurred: $error"));
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  void checkUserSession() async {
    String? token = await SharedPrefsHelper.getToken();

    if (token != null) {
      print("✅ Token found: $token");
    } else {
      print("❌ No token found, user needs to log in.");
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}
