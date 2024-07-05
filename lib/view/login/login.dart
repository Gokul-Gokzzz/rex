// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rexparts/view/Admin/admin_login.dart';
import 'package:rexparts/view/login/login_form.dart';
import 'package:rexparts/view/login/reg_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminLoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.admin_panel_settings))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Text(
              'We are always happy',
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
          ),
          const Text(
            'to serve you!',
            style: TextStyle(color: Colors.blue, fontSize: 30),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xFFFFFFFF),
                  bottom: TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: const Color(0xFF778293),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                      indicatorColor: Colors.grey,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(
                          text: 'Login',
                        ),
                        Tab(
                          text: 'Register',
                        ),
                      ]),
                ),
                body: const TabBarView(
                  children: [
                    LoginForm(),
                    RegisterForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
