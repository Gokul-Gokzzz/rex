// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/bottom_provider.dart';
import 'package:rexparts/controller/login_provider.dart';
import 'package:rexparts/view/login/login.dart';

confirmationDialog(context, LoginProvider loginProvider) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: SizedBox(
          height: 130,
          width: 40,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text('asdfsff'),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Color(0xFF1995AD)),
                      )),
                  TextButton(
                    onPressed: () async {
                      await loginProvider.googleSignOut();
                      Provider.of<BottomNavProvider>(context, listen: false)
                          .setInitIndex(0);
                      FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      ' Logout',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ])
              ]),
        ));
      });
}
