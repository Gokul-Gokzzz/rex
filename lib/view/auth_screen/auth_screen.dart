import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rexparts/view/bottom_bar/bottom_bar.dart';
import 'package:rexparts/view/login/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return BottomNavBar();
          } else {
            //user not logged in
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
