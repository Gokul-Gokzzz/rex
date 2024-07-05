import 'package:flutter/material.dart';
import 'package:rexparts/view/auth_screen/auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  'Welcome to',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                  ),
                ),
              ),
              const Text(
                'Rexparts',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
              const Text(
                'online store',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Let's get started",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 100,
              ),
              Stack(
                children: [
                  Image.asset(
                    'assets/welcome1.png',
                    height: size.height * .31,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
