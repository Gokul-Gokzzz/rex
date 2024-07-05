import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rexparts/model/message_model.dart';
import 'package:rexparts/model/user_model.dart';
import 'package:rexparts/service/auth_service.dart';
import 'package:rexparts/service/chat_service.dart';
import 'package:rexparts/widget/utilities.dart';

class ChatProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();
  ChatService chatService = ChatService();
  AuthService userservice = AuthService();
  late ScrollController scrollController;
  List<MessageModel> allMessage = [];
  List<MessageModel> myAllChat = [];
  final String adminId = 'GbVF11DrbQRPLEnex5F49QqJqkq1';

  ChatProvider() {
    scrollController = ScrollController();
  }

  sendMessage(String receiverId) async {
    await createChat(receiverId);
    final currentUser = firebaseAuth.currentUser;
    final senderId = currentUser != null ? currentUser.uid : adminId;
    final data = MessageModel(
        senderId: senderId,
        recieverId: receiverId,
        message: messageController.text,
        timestamp: DateTime.now());
    await chatService.sendMessage(data);
    messageController.clear();
    getAllChats();
    getMessages(receiverId);
  }

  getMessages(String receiverId) async {
    allMessage.clear();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        await chatService.getMessages(receiverId);
    snapshot.listen((message) {
      allMessage =
          message.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      scrollDown();
      notifyListeners();
    });
  }

  createChat(String receiverId) async {
    final currentUser = firebaseAuth.currentUser;
    final senderId = currentUser != null ? currentUser.uid : adminId;

    String chatRoomId = generateChatRoomId(uId1: senderId, uId2: receiverId);

    final data = MessageModel(
      chatRoomId: chatRoomId,
      recieverId: receiverId,
      senderId: senderId,
      timestamp: DateTime.now(),
    );
    return await chatService.createChat(data);
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  getAllChats() async {
    final currentUser = firebaseAuth.currentUser;
    final isAdmin = currentUser == null;

    List<UserModel> allUser = await userservice.getAllUsers();
    List<MessageModel> allChats = [];
    myAllChat.clear();

    try {
      allChats = await chatService.getAllChats();

      for (var chat in allChats) {
        if (isAdmin) {
          UserModel? user = allUser.firstWhere(
              (user) =>
                  user.userId == chat.recieverId ||
                  user.userId == chat.senderId,
              orElse: () => UserModel());
          final chatInfo = MessageModel(message: 'No Messages', userInfo: user);
          myAllChat.add(chatInfo);
        } else {
          if (chat.senderId == currentUser.uid ||
              chat.recieverId == currentUser.uid) {
            UserModel? user = allUser.firstWhere(
                (user) => user.userId == adminId,
                orElse: () => UserModel());
            final chatInfo =
                MessageModel(message: 'No Messages', userInfo: user);
            myAllChat.add(chatInfo);
          }
        }
        notifyListeners();
      }
    } catch (e) {
      log("Error from Get all chats: ${e.toString()}");
    }
  }
}
