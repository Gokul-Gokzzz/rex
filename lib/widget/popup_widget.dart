// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class PopupWidgets {
  void showSuccessSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void showErrorSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  Future<void> showLoadingIndicator(context) async {
    showDialog(
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> showLoadingIndicatorWithoutColor(context) async {
    showDialog(
      context: context,
      builder: (context) => Container(
        color: const Color.fromARGB(106, 0, 0, 0),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> showLoadingIndicatorWithFunction(BuildContext context,
      {required Future<void> Function() function}) async {
    showDialog(
      context: context,
      builder: (context) => Container(
        color: const Color.fromARGB(76, 0, 0, 0),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    await function();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }
}
