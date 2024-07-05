import 'package:flutter/material.dart';

Widget chatBubble(Size size, {isSend, message, time}) {
  return Padding(
    padding: EdgeInsets.only(
        bottom: size.height * .01, top: size.height * .01, left: 10, right: 10),
    child: Align(
      alignment: isSend ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: isSend
                ? Color.fromARGB(255, 220, 217, 217)
                : const Color(0xFF1995AD),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight:
                  isSend ? const Radius.circular(0) : const Radius.circular(20),
              bottomLeft:
                  isSend ? const Radius.circular(20) : const Radius.circular(0),
              bottomRight: isSend
                  ? const Radius.circular(20)
                  : const Radius.circular(20),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSend ? Colors.black : Colors.white,
                ),
                textAlign: TextAlign.justify),
            const SizedBox(
              height: 3,
            ),
            Text(
              time,
              style: TextStyle(
                color: isSend ? Colors.black : Colors.white,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
