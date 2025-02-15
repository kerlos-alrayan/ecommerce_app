import 'package:bloc/bloc.dart';
import 'package:lafyuu/models/profile_model.dart';
import 'package:lafyuu/repository/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void getProfileData()async{
    emit(ProfileLoading());

    try{
      final profileData =await  ProfileRepo().getProfileRepo();
      print("✅ Profile Data: $profileData");
      emit(ProfileSuccess(profileData));
    }catch (e) {
      print("❌ Profile Error: $e");
      emit(ProfileFailure(e.toString()));
    }
  }
}
