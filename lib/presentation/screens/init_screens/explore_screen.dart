import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/screens/auth_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.logout, size: 50, color: Colors.red),
          onPressed: () => logout(context),
        ),
      ),
    );
  }
}
