import 'package:lafyuu/helper/api.dart';
import 'package:lafyuu/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  Future<ProfileModel> getProfileRepo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception("❌ No token found, please log in again.");
      }

      print("🚀 Sending Request with Token: Bearer $token");

      final response = await Api().get(
        uri: 'https://student.valuxapps.com/api/profile',
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      );

      print("✅ API Response: ${response.data}");

      if (response.data['status'] == false) {
        throw Exception("❌ API Error: ${response.data['message']}");
      }

      return ProfileModel.fromJson(response.data);

    } catch (e) {
      print("❌ Error in ProfileRepo: $e");
      throw Exception("Failed to load profile: $e");
    }
  }
}
