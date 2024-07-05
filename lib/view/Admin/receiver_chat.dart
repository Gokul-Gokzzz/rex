// ignore_for_file: must_be_immutable

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/chat_provider.dart';
import 'package:rexparts/model/user_model.dart';
import 'package:rexparts/widget/chat_bubble.dart';

class AdminChatPage extends StatefulWidget {
  UserModel userinfo;
  AdminChatPage({Key? key, required this.userinfo}) : super(key: key);

  @override
  State<AdminChatPage> createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false)
        .getMessages(widget.userinfo.userId!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 600,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            SizedBox(
              width: size.width * .02,
            ),
            Text(widget.userinfo.name ?? 'unknown')
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, value, child) {
                  return value.allMessage.isEmpty
                      ? Center(
                          child: Text(
                            'Start a conversation..',
                            style: TextStyle(
                              color: const Color(0xFF1995AD),
                            ),
                          ),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: value.allMessage.length,
                          itemBuilder: (context, index) {
                            bool isSender = value.allMessage[index].senderId ==
                                chatProvider.adminId;
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
              padding: const EdgeInsets.all(8.0),
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
                        await chatProvider.sendMessage(widget.userinfo.userId!);
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                    ),
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
