// ignore_for_file: use_build_context_synchronously

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/login_provider.dart';
import 'package:rexparts/controller/user_controller.dart';
import 'package:rexparts/view/bottom_bar/bottom_bar.dart';
import 'package:rexparts/widget/popup_widget.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final regProvider = Provider.of<LoginProvider>(context, listen: false);
    final pro = Provider.of<UserProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                          controller: regProvider.userNameController,
                          decoration: const InputDecoration(
                              label: Text('Enter Full Name'),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.person),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                            return null;
                          },
                          controller: regProvider.emailController,
                          decoration: const InputDecoration(
                            label: Text('Enter Email Address'),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.email),
                            ),
                          ),
                        ),
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                obscureText: value.createObscureText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                                controller: regProvider.passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(Icons.password),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      value.createObscureChange();
                                    },
                                    icon: Icon(value.createObscureText
                                        ? EneftyIcons.eye_slash_outline
                                        : EneftyIcons.eye_outline),
                                  ),
                                  label: const Text(
                                    'Enter Password',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                obscureText: value.conformObscureText,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Conform Password';
                                  }
                                  return null;
                                },
                                controller:
                                    regProvider.confirmPasswordController,
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(Icons.password_rounded),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      value.conformObscureChange();
                                    },
                                    icon: Icon(value.conformObscureText
                                        ? EneftyIcons.eye_slash_outline
                                        : EneftyIcons.eye_outline),
                                  ),
                                  label: const Text('Conform Password'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(
                              300,
                              50,
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                await regProvider.signUpWithEmail(
                                    regProvider.emailController.text,
                                    regProvider.passwordController.text,
                                    regProvider.userNameController.text);
                                await pro.addUser(
                                    regProvider.emailController.text,
                                    regProvider.userNameController.text);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavBar(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                                PopupWidgets().showSuccessSnackbar(
                                    context, 'Account has been created');
                                regProvider.clearControllers();
                              } catch (e) {
                                PopupWidgets().showErrorSnackbar(
                                    context, 'Account not created, try again');
                              }
                            }
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ]),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/welcome1.png',
                            height: size.height * .23,
                            width: double.infinity,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: -100,
                            child: Image.asset(
                              'assets/welcome2.png',
                              height: size.height * .31,
                              width: double.infinity,
                            ),
                          )
                        ],
                      )
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
