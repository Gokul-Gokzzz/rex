import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/chat_provider.dart';
import 'package:rexparts/view/Admin/receiver_chat.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).getAllChats();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 20),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * .01),
        child: Consumer<ChatProvider>(
          builder: (context, value, child) => value.myAllChat.isEmpty
              ? const Center(child: Text("No chats available"))
              : ListView.builder(
                  itemCount: value.myAllChat.length,
                  itemBuilder: (context, index) {
                    final chat = value.myAllChat[index];
                    final userInfo = chat.userInfo;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AdminChatPage(userinfo: userInfo!),
                          ),
                        );
                      },
                      child: Container(
                        height: size.height * .1,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * .02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userInfo?.name ?? 'Unknown User',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
