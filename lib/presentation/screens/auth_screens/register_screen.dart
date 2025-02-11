import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/cubits/register_cubit/register_cubit.dart';
import 'package:lafyuu/cubits/register_cubit/register_state.dart';
import 'package:lafyuu/helper/login_helper.dart';
import 'package:lafyuu/presentation/screens/auth_screens/login_screen.dart';
import 'package:lafyuu/presentation/screens/home_screen.dart';
import 'package:lafyuu/presentation/widgets/input_text.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

 final  bool isPasswordObscure1 = true;

 final  bool isPasswordObscure2 = true;

  final LoginControllers loginControllers = LoginControllers();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("register Succeed")));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route route) => false);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error :${state.error} ")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image
                        Image.asset(
                          'assets/images/Vector.png',
                          width: 72,
                          height: 72,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        // Text Welcome
                        Text(
                          'Let${"'"}s Get Started',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // Text Sign In
                        Text(
                          'create a new account',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // User Name
                        Column(
                          spacing: 20,
                          children: [
                            CustomTextFormField(
                              isPassword: false,
                              controller: loginControllers.nameController,
                              hintText: "Full Name",
                              label: "Name",
                              prefix: Icons.mail,
                              validator: (value) {
                                if (!loginControllers.isValidName(value!)) {
                                  return "Name invalid";
                                }

                                return null;
                              },
                            ),
                            // Email
                            CustomTextFormField(
                              isPassword: false,
                              controller: loginControllers.emailController,
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
                            // Password
                            CustomTextFormField(
                                isPassword: true,
                                controller: loginControllers.passwordController,
                                hintText: "Password",
                                label: "Password",
                                prefix: Icons.lock_outline,
                                validator: (value) {
                                  if (!loginControllers.isValidPassword(value!)) {
                                    return "password invalid";
                                  }
                                  return null;
                                }),
                            // Password Again
                            CustomTextFormField(
                                isPassword: false,
                                controller: loginControllers.phoneController,
                                hintText: "phone number",
                                label: "phone number",
                                prefix: Icons.lock_outline,
                                validator: (value) {
                                  if (!loginControllers.isValidPhone(value!)) {
                                    return "phone number invalid";
                                  }
                                  return null;
                                }),
                          ],
                        ),
                        // Button Sign In
                        Container(
                          margin: EdgeInsets.all(16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(343, 57),
                              shadowColor: Colors.blue,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: loginControllers.nameController.text,
                                  email: loginControllers.emailController.text,
                                  phone: loginControllers.phoneController.text,
                                  password: loginControllers.passwordController.text,
                                );
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()), (Route route) => false);
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        // Register Button
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'have a account? ',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
