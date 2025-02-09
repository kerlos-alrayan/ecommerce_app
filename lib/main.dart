import 'package:lafyuu/cubits/bottom_bar_cubit/bottom_bar_cubit.dart';
import 'package:lafyuu/cubits/categories/categories_cubit.dart';
import 'package:lafyuu/cubits/category_product/category_product_cubit.dart';
import 'package:lafyuu/cubits/home_products_cubit/home_product_cubit.dart';
import 'package:lafyuu/cubits/login_cubit/login_cubit.dart';
import 'package:lafyuu/cubits/product_details_cubit/product_details_cubit.dart';
import 'package:lafyuu/cubits/register_cubit/register_cubit.dart';
import 'package:lafyuu/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit()),
        BlocProvider(create: (context) => HomeProductCubit()),
        BlocProvider(create: (context) => ProductDetailsCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => CategoriesCubit()..fetchCategories()),
        BlocProvider(create: (context) => CategoryProductCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
