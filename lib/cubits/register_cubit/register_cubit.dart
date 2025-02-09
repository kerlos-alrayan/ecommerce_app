import 'package:dio/dio.dart';
import 'package:lafyuu/cubits/register_cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/api_constants.dart';
import '../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      var response = await Dio().post(
        ApiConstants.REGISTER,
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "image": "https://images.pexels.com/photos/3792581/pexels-photo-3792581.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successful registration
        UserModel userModel = UserModel.fromJson(response.data);
        emit(RegisterSuccess(userModel));
      } else {
        // Unexpected response
        emit(RegisterFailure("Unexpected error: ${response.statusCode}"));
      }
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response!.statusCode == 400) {
          emit(RegisterFailure("Invalid registration data. Please check your inputs."));
        } else if (error.response!.statusCode == 404) {
          emit(RegisterFailure("Server not found. Try again later."));
        } else if (error.response!.statusCode == 409) {
          emit(RegisterFailure("Email or phone number already exists."));
        } else if (error.response!.statusCode == 500) {
          emit(RegisterFailure("Server error. Please try again later."));
        } else {
          emit(RegisterFailure("Error: ${error.response!.statusCode}"));
        }
      } else {
        emit(RegisterFailure("Network error. Please check your connection."));
      }
    } catch (error) {
      emit(RegisterFailure("An unexpected error occurred: $error"));
    }
  }

}