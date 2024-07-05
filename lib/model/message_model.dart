import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rexparts/model/user_model.dart';

class MessageModel {
  String? message;
  String? senderId;
  String? recieverId;
  String? chatRoomId;
  UserModel? userInfo;
  DateTime? timestamp;
  MessageModel(
      {this.message,
      this.senderId,
      this.recieverId,
      this.chatRoomId,
      this.userInfo,
      this.timestamp});

  factory MessageModel.fromJson(json) {
    return MessageModel(
        message: json['message'],
        senderId: json['senderId'],
        recieverId: json['recieverId'],
        timestamp: json['timestamp'] != null
            ? (json['timestamp'] as Timestamp).toDate()
            : null,
        chatRoomId: json['chatRoomId']);
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
      'recieverId': recieverId,
      'timestamp': timestamp,
      'chatRoomId': chatRoomId
    };
  }
}
