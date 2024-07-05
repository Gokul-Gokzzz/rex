import 'package:flutter/material.dart';

Container userPrompt({
  required final bool isPrompt,
  required String message,
  required String date,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: isPrompt ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: isPrompt ? Radius.circular(20) : Radius.zero,
          bottomRight: isPrompt ? Radius.zero : Radius.circular(20),
        )),
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.symmetric(vertical: 15).copyWith(
      left: isPrompt ? 80 : 15,
      right: isPrompt ? 15 : 80,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: TextStyle(
            fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
            color: isPrompt ? Colors.white : Colors.black,
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 16,
            color: isPrompt ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );
}
