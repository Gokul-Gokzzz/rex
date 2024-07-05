import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/chat_provider.dart';
import 'package:rexparts/service/chat_service.dart';
import 'package:rexparts/widget/chat_bubble.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key});

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  final ChatService chatservice = ChatService();

  @override
  void initState() {
    super.initState();
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.scrollController = ScrollController();
    chatProvider.getMessages(chatProvider.adminId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 280,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            const CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            SizedBox(
              width: size.width * .025,
            ),
            Text(
              'Rexparts',
              style: TextStyle(
                color: const Color(0xFF1995AD),
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, value, child) {
                return value.allMessage.isEmpty
                    ? Center(
                        child: Text(
                          'Start a conversation..',
                          style: TextStyle(color: const Color(0xFF1995AD)),
                        ),
                      )
                    : ListView.builder(
                        reverse: true,
                        itemCount: value.allMessage.length,
                        itemBuilder: (context, index) {
                          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                          bool isSender = value.allMessage[index].senderId ==
                              firebaseAuth.currentUser!.uid;
                          DateTime timestamp =
                              value.allMessage[index].timestamp!;
                          String formattedTime =
                              DateFormat('hh:mm a').format(timestamp);
                          return chatBubble(
                            size,
                            isSend: isSender,
                            message: value.allMessage[index].message!,
                            time: formattedTime,
                          );
                        },
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatProvider.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (chatProvider.messageController.text.isNotEmpty) {
                      await chatProvider.sendMessage(chatProvider.adminId);
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
