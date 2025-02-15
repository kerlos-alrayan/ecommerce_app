import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/cubits/PasswordVisibility_cubit/PasswordVisibility_cubit.dart';
import 'package:lafyuu/cubits/profile_cubit/profile_cubit.dart';
import 'package:lafyuu/presentation/screens/init_screens/account_screens/account_screen.dart';
import 'package:lafyuu/presentation/screens/init_screens/account_screens/profile.dart';
import 'package:lafyuu/presentation/screens/init_screens/splash_screen.dart';
import 'helper/dio_helper.dart';
import 'package:lafyuu/cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import 'package:lafyuu/cubits/categories/categories_cubit.dart';
import 'package:lafyuu/cubits/category_product/category_product_cubit.dart';
import 'package:lafyuu/cubits/home_products_cubit/home_product_cubit.dart';
import 'package:lafyuu/cubits/login_cubit/login_cubit.dart';
import 'package:lafyuu/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:lafyuu/cubits/register_cubit/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  DioHelper.init();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit()),
        BlocProvider(create: (context) => HomeProductCubit()..getHomeProducts()),
        BlocProvider(create: (context) => ProductDetailsCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => CategoriesCubit()..fetchCategories()),
        BlocProvider(create: (context) => CategoryProductCubit()),
        BlocProvider(create: (context) => PasswordVisibilityCubit()),
        BlocProvider(create: (context) => ProfileCubit()..getProfileData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
