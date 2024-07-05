// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:rexparts/model/chat_model.dart';
// import 'package:rexparts/model/user_model.dart';
// import 'package:rexparts/view/Admin/receiver_chat.dart';
// import 'package:rexparts/view/chat/chat_screen.dart';

// class ChatTileWidget extends StatefulWidget {
//   final ChatModel chatModel;

//   const ChatTileWidget({Key? key, required this.chatModel}) : super(key: key);

//   @override
//   _ChatTileWidgetState createState() => _ChatTileWidgetState();
// }

// class _ChatTileWidgetState extends State<ChatTileWidget> {
//   late Future<UserModel?> _userFuture;

//   @override
//   void initState() {
//     super.initState();
//     _userFuture = fetchUserDetails();
//   }

//   Future<UserModel?> fetchUserDetails() async {
//     String userId = widget.chatModel.uId1 ?? widget.chatModel.uId2 ?? '';
//     try {
//       UserModel? fetchedUserInfo = await fetchUserInfo(userId);
//       return fetchedUserInfo;
//     } catch (e) {
//       print('Error fetching user details: $e');
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final DateTime? timestamp = widget.chatModel.timeStamp;
//     String formattedTime =
//         timestamp != null ? DateFormat('hh:mm a').format(timestamp) : '';

//     return Container(
//       height: 80,
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 224, 215, 215),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: FutureBuilder<UserModel?>(
//         future: _userFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error loading user',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.red,
//                 ),
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return Center(
//               child: Text('Unknown User',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey,
//                   )),
//             );
//           } else {
//             UserModel userInfo = snapshot.data!;
//             return ListTile(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => ReceiverChat(
//                       userInfor: UserInfor(
//                         id: userInfo.userId!,
//                         fullName: userInfo.name!,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               title: Text(
//                 userInfo.name!,
//                 style: GoogleFonts.montserrat(
//                   fontSize: size.width * 0.04,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle:
//                   Text(widget.chatModel.lastMessage ?? 'No message available',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[700],
//                       )),
//               trailing: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: const Color.fromARGB(255, 22, 127, 113),
//                     radius: size.width * 0.03,
//                     child: const Text(
//                       '01',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Text(
//                     formattedTime,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.red,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// Future<UserModel?> fetchUserInfo(String userId) async {
//   await Future.delayed(const Duration(seconds: 1)); // Simulating delay
//   return UserModel(
//       id: userId, name: 'John Doe'); // Replace with actual user data
// }
