enum NotificationType { chat, course, payment, review }

class NotificationModel {
  String? id;
  String? receiverId;
  String? title;
  bool? read;
  String? body;

  NotificationModel({
    this.id,
    this.receiverId,
    this.title,
    this.body,
    this.read,
  });

  factory NotificationModel.fromJson(String id, Map<String, dynamic> json) {
    return NotificationModel(
      id: id,
      receiverId: json['receiverId'],
      title: json['title'],
      body: json['body'],
      read: json['read'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiverId': receiverId,
      'title': title,
      'body': body,
      'read': read
    };
  }
}
