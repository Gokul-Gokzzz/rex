import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rexparts/model/message_model.dart';
import 'package:rexparts/widget/utilities.dart';

const String adminId = 'GbVF11DrbQRPLEnex5F49QqJqkq1';

class ChatService {
  String chatCollection = 'chats';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  sendMessage(MessageModel data) async {
    final currentUser = firebaseAuth.currentUser;
    final senderUid = currentUser != null ? currentUser.uid : adminId;

    String chatRoomId =
        generateChatRoomId(uId1: senderUid, uId2: data.recieverId!);
    String senderId =
        data.senderId! + DateTime.now().millisecondsSinceEpoch.toString();
    try {
      await firestore
          .collection(chatCollection)
          .doc(chatRoomId)
          .collection("Messeges")
          .doc(senderId)
          .set(data.toJson());
    } catch (e) {
      throw e;
    }
    ;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getMessages(
      String receiverId) async {
    final currentUser = firebaseAuth.currentUser;
    final senderId = currentUser != null ? currentUser.uid : adminId;
    try {
      String chatRoomId = generateChatRoomId(uId1: senderId, uId2: receiverId);

      var snapshot = await firestore
          .collection("chats")
          .doc(chatRoomId)
          .collection('Messeges')
          .orderBy('timestamp', descending: true)
          .snapshots();
      return snapshot;
    } catch (e) {
      throw e;
    }
  }

  Future<List<MessageModel>> getAllChats() async {
    try {
      final QuerySnapshot snapshot = await firestore
          .collection(chatCollection)
          .orderBy('timestamp', descending: false)
          .get();

      List<MessageModel> allChats = snapshot.docs
          .map((DocumentSnapshot doc) => MessageModel.fromJson(doc.data()))
          .toList();

      return allChats;
    } catch (e) {
      log("getAllChats service chach : ${e}");
      rethrow;
    }
  }

  createChat(MessageModel data) async {
    try {
      await firestore
          .collection(chatCollection)
          .doc(data.chatRoomId)
          .set(data.toJson());
      log('chat created');
    } catch (e) {
      throw e;
    }
  }
}
