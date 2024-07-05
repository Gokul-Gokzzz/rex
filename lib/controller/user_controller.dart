import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rexparts/model/user_model.dart';
import 'package:rexparts/service/auth_service.dart';

class UserProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  UserModel? currentUser;
  final AuthService authService = AuthService();

  UserProvider() {
    getUser();
  }

  Future<void> getUser() async {
    currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      usernameController.text = currentUser!.name ?? '';
      emailController.text = currentUser!.email ?? '';
    }
    notifyListeners();
  }

  Future<void> addUser(String email, String name) async {
    final user = UserModel(
      email: email,
      name: name,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );
    await authService.addUser(user);
    notifyListeners();
  }

  Future<void> updateUser() async {
    final user = UserModel(
      email: emailController.text,
      name: usernameController.text,
    );
    await authService.updateUser(user);
  }

  Future<void> updateUsername(String newName) async {
    if (currentUser != null) {
      currentUser!.name = newName;
      await updateUser();
    }
  }

  Future<void> updateEmail(String newEmail) async {
    if (currentUser != null) {
      currentUser!.email = newEmail;
      await updateUser();
    }
  }
}
