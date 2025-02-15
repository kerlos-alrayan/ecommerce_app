import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/cubits/register_cubit/register_state.dart';
import 'package:lafyuu/helper/shared_prefs_helper.dart';
import 'package:lafyuu/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_constants.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoading());
    var dio = Dio(BaseOptions(followRedirects: false));

    try {
      print("🔵 Sending request to API...");
      var response = await dio.post(
        ApiConstants.REGISTER,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phone": phone,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Cookie': 'humans_21909=1',
          },
        ),
      );

      print("🟢 Response Status: ${response.statusCode}");
      print("🟢 Response Headers: ${response.headers}");
      print("🟢 Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel userModel = UserModel.fromJson(response.data);

        String? token = userModel.data?.token;
        if(token != null && token.isNotEmpty){
          print("✅ Token received: $token");
          await SharedPrefsHelper.saveToken(token);
          print("🔹 Token saved successfully!");
        }
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token!);

        emit(RegisterSuccess(userModel));
      } else if (response.statusCode == 400 || response.statusCode == 409) {
        emit(RegisterFailure("⚠️ Email or phone number already exists."));
      } else {
        emit(RegisterFailure("⚠️ Unexpected response from server."));
      }
    } on DioException catch (error) {
      print("🔴 DioException occurred: ${error.response?.data}");

      if (error.response != null) {
        String errorMessage = error.response!.data is Map<String, dynamic>
            ? error.response!.data["message"] ?? "Unknown error"
            : "Unexpected server response.";

        emit(RegisterFailure("❌ Server error: $errorMessage"));
      } else {
        emit(RegisterFailure("❌ Network error, check your connection."));
      }
    } catch (error) {
      print("🔴 Unknown Error: $error");
      emit(RegisterFailure("❌ Unexpected error occurred."));
    }
  }
}
