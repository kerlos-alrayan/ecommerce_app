import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import 'package:lafyuu/cubits/login_cubit/login_cubit.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.logout, size: 50, color: Colors.teal),
          onPressed: () {
            context.read<BottomBarCubit>().clearBottomIndex();
            context.read<LoginCubit>().logout(context);
          }
        ),
      ),
    );
  }
}
