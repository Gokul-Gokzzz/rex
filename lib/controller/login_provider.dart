import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rexparts/model/user_model.dart';
import 'package:rexparts/service/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  TextEditingController userNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final forgotPasswordFormkey = GlobalKey<FormState>();
  int currentIndex = 0;
  UserModel? currentUser;
  bool showPassword = true;
  bool showOtpField = false;
  Country selectCountry = Country(
      phoneCode: '91',
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "INDIA",
      example: "INDIA",
      displayName: "INDIA",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  Future<UserCredential> signUpWithEmail(
      String email, String password, String userName) async {
    return await authService.signUpWithEmail(
        email: email, password: password, userName: userName);
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await authService.signInWithEmail(email, password);
  }

  Future<void> signOutWithEmail() async {
    return await authService.signOutEmail();
  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      await authService.signInWithGoogle(context);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> googleSignOut() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> getUser() async {
    if (currentUser != null) {
      log(currentUser!.email!);
    }
    notifyListeners();
  }

  bool signInObscureText = true;
  void signInObscureChange() {
    signInObscureText = !signInObscureText;
    notifyListeners();
  }

  Future<void> getOtp(phoneNumber) async {
    await authService.getOtp(phoneNumber);
    notifyListeners();
  }

  Future<void> verifyOtp(otp, context) async {
    await authService.verifyOtp(otp, context);
    notifyListeners();
  }

  countrySelection(value) {
    selectCountry = value;
    notifyListeners();
  }

  Future<void> showOtp() async {
    showOtpField = true;
    notifyListeners();
  }

  Future clearControllers() async {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneController.clear();
    otpController.clear();
    notifyListeners();
  }

  onTabTapped(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> forgotPassword(context, {email}) async {
    authService.passwordReset(email: email, context: context);
  }
// ---------------------------------------------------------------------- //
  // for registration screen //

  bool passwordVisible = false;
  signUp(context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    if (passwordController.text != confirmPasswordController.text) {
      displayMessage('Passwords don\'t match', context);
      notifyListeners();
      return;
    }

    try {
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage(e.code, context);
      notifyListeners();
    }
    notifyListeners();
  }

  //display dialogue message to user
  void displayMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
    notifyListeners();
  }

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void clear() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  bool createObscureText = true;
  void createObscureChange() {
    createObscureText = !createObscureText;
    notifyListeners();
  }

  bool conformObscureText = true;
  void conformObscureChange() {
    conformObscureText = !conformObscureText;
    notifyListeners();
  }
}
