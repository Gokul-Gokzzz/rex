// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rexparts/view/chat/chat_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const ListTile(
              title: Text(
                'How to Order Spare Parts?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'To order spare parts, go to the Spare Parts section in the app. Browse through the available parts, select the ones you need, and proceed to checkout to complete your order.',
              ),
            ),
            const Divider(),
            const ListTile(
              title: Text(
                'Contact Support',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'If you have any further questions or need assistance, feel free to contact our support team at support@example.com.',
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'For Know About Us Come Here',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserChatScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: LottieBuilder.asset('assets/chat.json'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
