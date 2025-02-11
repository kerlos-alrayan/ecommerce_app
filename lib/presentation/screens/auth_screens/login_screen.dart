import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/cubits/login_cubit/login_cubit.dart';
import 'package:lafyuu/helper/login_helper.dart';
import 'package:lafyuu/presentation/screens/auth_screens/register_screen.dart';
import 'package:lafyuu/presentation/screens/home_screen.dart';
import 'package:lafyuu/presentation/widgets/input_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final bool isPasswordObscure = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final LoginControllers loginControllers = LoginControllers();

  void saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                saveLoginState();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/Vector.png',
                          height: 72, width: 72),
                      const SizedBox(height: 16),
                      const Text(
                        'Welcome to Lafyuu',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign in to continue',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      CustomTextFormField(
                        isPassword: false,
                        controller: emailController,
                        hintText: "Email",
                        label: "Email",
                        prefix: Icons.mail,
                        validator: (value) {
                          if (!loginControllers.isValidEmail(value!)) {
                            return "Email invalid";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        isPassword: true,
                        controller: passwordController,
                        hintText: "Password",
                        label: "Password",
                        prefix: Icons.lock_outline,
                        validator: (value) {
                          if (!loginControllers.isValidPassword(value!)) {
                            return "Password invalid";
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              fixedSize: const Size(343, 57)),
                          onPressed: state is LoginLoading
                              ? null
                              : () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context)
                                  .userLogin(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(), context: context,
                              );
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeScreen()),
                                  (Route route)=> false);
                            }
                          },
                          child: state is LoginLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      _registerSection(context),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _registerSection(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 12)),
        GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => RegisterScreen())),
          child: const Text('Register',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.blue)),
        ),
      ],
    ),
  );
}
