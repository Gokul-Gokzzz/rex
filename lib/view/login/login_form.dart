// ignore_for_file: use_build_context_synchronously, avoid_unnecessary_containers

import 'package:email_validator/email_validator.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/login_provider.dart';
import 'package:rexparts/view/bottom_bar/bottom_bar.dart';
import 'package:rexparts/view/login/forgot_password.dart';
import 'package:rexparts/view/login/phone_auth.dart';
import 'package:rexparts/widget/popup_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: loginProvider.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Email";
                        } else if (!EmailValidator.validate(value)) {
                          return "Please Enter a valid Email Address";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text('Email Address'),
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Consumer<LoginProvider>(
                      builder: (context, value, child) => TextFormField(
                        controller: loginProvider.passwordController,
                        obscureText: value.signInObscureText,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          } else if (value.length < 6) {
                            return "Enter Password At Least 6 Characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.password),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              value.signInObscureChange();
                            },
                            icon: Icon(
                              value.signInObscureText
                                  ? EneftyIcons.eye_slash_outline
                                  : EneftyIcons.eye_outline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(300, 50),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await loginProvider.signInWithEmail(
                            loginProvider.emailController.text,
                            loginProvider.passwordController.text,
                          );
                          PopupWidgets()
                              .showSuccessSnackbar(context, 'User logged in');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBar(),
                            ),
                          );
                          loginProvider.clearControllers();
                        } catch (e) {
                          loginProvider.clearControllers();
                          PopupWidgets()
                              .showErrorSnackbar(context, 'User not found!');
                        }
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const Text('or connect with'),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Consumer<LoginProvider>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            value.googleSignIn(context);
                          },
                          child: Container(
                            child: Image.asset(
                              'assets/google.png',
                              height: 35,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            loginProvider.clearControllers();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OtpPage(),
                            ));
                          },
                          child: Container(
                            child: Image.asset(
                              'assets/phone1.png',
                              height: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/login.png',
                        height: size.height * .30,
                        width: double.infinity,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -30,
                        child: Image.asset(
                          'assets/welcome2.png',
                          height: size.height * .31,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
