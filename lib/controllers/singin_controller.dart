import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //For password visibility
  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(String userEmail, String userPassword) async {
    try {
      EasyLoading.show(status: "Please Wait..", dismissOnTap: false); // Dismiss on tap to false
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      EasyLoading.dismiss(); // Dismiss loading indicator
      return userCredential;

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss(); // Dismiss loading if there is an error
      Get.snackbar(
        "Error",
        e.message ?? "Unknown error", // Show error message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null; // Return null if there is an error
    }
  }
}
