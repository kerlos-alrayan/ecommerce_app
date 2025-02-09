import 'package:lafyuu/presentation/screens/account_screen.dart';
import 'package:lafyuu/presentation/screens/cart_screen.dart';
import 'package:lafyuu/presentation/screens/explore_screen.dart';
import 'package:lafyuu/presentation/screens/main_screen.dart';
import 'package:lafyuu/presentation/screens/offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import '../../cubits/bottom_bar_cubit/bottom_bar_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      // Main Screen
      MainScreen(),
      // Explore Screen
      ExploreScreen(),
      // Cart Screen
      CartScreen(),
      // Offer Screen
      OfferScreen(),
      // Account Screen
      AccountScreen(),
    ];
    return Scaffold(
      body: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return screen[state.index];
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            onTap: (int index) {
              context.read<BottomBarCubit>().changeIndex(index);
            },
            type: BottomNavigationBarType.fixed, // lw akter mn 2 icons
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_offer_outlined,
                ),
                label: 'Offer',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_outlined,
                ),
                label: 'Account',
              ),
            ],
          );
        },
      ),
    );
  }
}
