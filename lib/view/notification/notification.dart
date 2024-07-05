// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rexparts/controller/noti_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final notificationProvider = Provider.of<NotificationProvider>(context);
    notificationProvider.getAllNotification();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Notification',
          style: TextStyle(
              color: const Color(0xFF1A1A1A),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = provider.allNotification
              .where((notification) => notification.receiverId == user!.uid)
              .toList();

          if (notifications.isEmpty) {
            return Center(
                child: Text(
              'No Notification Found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final isRead = notification.read ?? false;
              final textColor = isRead ? Colors.grey[500] : Colors.black;

              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: ListTile(
                        title: Text(
                          notification.title ?? '',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor),
                        ),
                        subtitle: Text(
                          notification.body ?? '',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  notificationProvider
                                      .updateNotificationReadStatus(
                                          notification.id!, true);
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: textColor,
                                )),
                            IconButton(
                                onPressed: () {
                                  notificationProvider
                                      .deleteNotification(notification.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          ],
                        )),
                  ),
                  const Row(
                    children: [
                      Divider(),
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
