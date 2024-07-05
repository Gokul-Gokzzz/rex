import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rexparts/controller/login_provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * .03, horizontal: size.width * .05),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/forgot password.png'),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              const Text(
                  'Enter Your Email and we will send you a password reset link to Email'),
              SizedBox(
                height: size.height * .02,
              ),
              Form(
                key: loginProvider.forgotPasswordFormkey,
                child: TextFormField(
                  controller: loginProvider.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              ElevatedButton(
                  child: const Text('Send'),
                  onPressed: () {
                    if (loginProvider.forgotPasswordFormkey.currentState!
                        .validate()) {
                      loginProvider.forgotPassword(context,
                          email: loginProvider.emailController.text.trim());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
