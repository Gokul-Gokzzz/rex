// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rexparts/view/Admin/add_product.dart';

class AdminLoginPage extends StatelessWidget {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernamecontroller,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordcontroller,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                adminlogin(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  adminlogin(context) {
    if (usernamecontroller.text == "user" && passwordcontroller.text == "123") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddProductPage(),
          ));
    }
  }
}
