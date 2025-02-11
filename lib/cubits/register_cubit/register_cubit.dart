import 'package:dio/dio.dart';
import 'package:lafyuu/cubits/register_cubit/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/api_constants.dart';
import '../../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.BASEURL,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      Response response = await dio.post(
        ApiConstants.REGISTER,
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "password": password,
          "image":
          "https://images.pexels.com/photos/3792581/pexels-photo-3792581.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        },
      );

      print("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        UserModel userModel = UserModel.fromJson(response.data);
        emit(RegisterSuccess(userModel));
      } else {
        emit(RegisterFailure("Unexpected error: ${response.statusCode}"));
      }
    } on DioError catch (error) {
      if (error.response != null) {
        print("DioError Response: ${error.response!.data}");

        switch (error.response!.statusCode) {
          case 400:
            emit(RegisterFailure("Invalid data. Check your inputs."));
            break;
          case 404:
            emit(RegisterFailure("Server not found. Try again later."));
            break;
          case 409:
            emit(RegisterFailure("Email or phone number already exists."));
            break;
          case 500:
            emit(RegisterFailure("Server error. Please try again later."));
            break;
          default:
            emit(RegisterFailure("Error: ${error.response!.statusCode}"));
        }
      } else {
        print("Network Error: ${error.message}");
        emit(RegisterFailure("Network error. Check your connection."));
      }
    } catch (error) {
      print("Unexpected Error: $error");
      emit(RegisterFailure("An unexpected error occurred: $error"));
    }
  }
}
