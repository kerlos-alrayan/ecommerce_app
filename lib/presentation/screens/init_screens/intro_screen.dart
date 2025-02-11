import 'package:lafyuu/presentation/screens/auth_screens/login_screen.dart';
import 'package:lafyuu/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, snapshot){
          if(snapshot.data != null){
            print('Its Dooooooooooooooooooooooooooooooooooooon');
            return HomeScreen();
          }else{
            print('Its Noooooooooooooooooooooooot Don');
            return LoginScreen();
          }
        }, stream: null,
    );
  }
}
