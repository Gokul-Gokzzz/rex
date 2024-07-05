// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rexparts/model/user_model.dart';
import 'package:rexparts/service/noti_service.dart';
import 'package:rexparts/view/bottom_bar/bottom_bar.dart';
import 'package:rexparts/widget/popup_widget.dart';

class AuthService {
  String? verificationid;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String collection = 'user';
  Reference storage = FirebaseStorage.instance.ref();
  NotificationService notificationService = NotificationService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel data) async {
    try {
      await firestore
          .collection(collection)
          .doc(firebaseAuth.currentUser!.uid)
          .set(data.toJson());
    } catch (e) {
      const ScaffoldMessenger(
        child: Text('User not Added'),
      );
    }
  }

  Future<UserModel?> getCurrentUser() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await firestore.collection(collection).doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<UserCredential> signUpWithEmail(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userData = UserModel(
          email: email, name: userName, userId: userCredential.user?.uid);
      await firestore
          .collection(collection)
          .doc(userCredential.user?.uid)
          .set(userData.toJson());
      log('Account created');
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User logged in');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOutEmail() async {
    await firebaseAuth.signOut();
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? guser = userCredential.user;
      log("User display Name: ${guser?.displayName}");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      return guser;
    } catch (e) {
      log('Google Sign-In Error: $e');
      rethrow;
    }
  }

  Future<void> signOutWithGoogle() async {
    await GoogleSignIn().signOut();
  }

  Future<void> getOtp(String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await firebaseAuth.signInWithCredential(phoneAuthCredential);
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await user.updatePhoneNumber(phoneAuthCredential);
          }
        },
        verificationFailed: (error) {
          log("verification failed error : $error");
        },
        codeSent: (verificationId, forceResendingToken) {
          verificationid = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          verificationid = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      log("sign in error : $e");
    }
  }

  Future<PhoneAuthCredential?> verifyOtp(String otp, context) async {
    try {
      if (verificationid == null) {
        throw Exception('Verification ID is null');
      }
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationid!, smsCode: otp);
      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (route) => false,
      );
      PopupWidgets().showSuccessSnackbar(context, "OTP Validated");
    } catch (e) {
      PopupWidgets().showErrorSnackbar(context, "Invalid OTP");
      log("verify otp error $e");
      return null;
    }
    return null;
  }

  void passwordReset({required email, context}) async {
    try {
      log('start');
      await firebaseAuth.sendPasswordResetEmail(email: email);
      log('success');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      log('error occure');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    }
  }

  Future<void> updateUser(UserModel data) async {
    try {
      if (firebaseAuth.currentUser != null) {
        await firestore
            .collection(collection) // Using 'user'
            .doc(firebaseAuth.currentUser!.uid)
            .update(data.toJson());
      } else {
        throw Exception('No current user found');
      }
    } catch (e) {
      log('Error updating user: $e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection(collection).get();
      List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // Send notifications to all users
      await notificationService.sendNotificationToAllUsers(
        'New Product Added',
        'A new product has been added to the catalog!',
        users,
      );

      return users;
    } catch (e) {
      log('Error fetching users: $e');
      return [];
    }
  }
}
