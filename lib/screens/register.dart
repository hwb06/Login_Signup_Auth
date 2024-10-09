import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_with_auth/controllers/signup_controller.dart';
import 'package:login_signup_with_auth/screens/login.dart';
import '../services/notification_service.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final SignUpController signUpController = Get.put(SignUpController());
  final NotificationService notificationService =
      Get.put(NotificationService());

  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/register.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 110),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "Welcome Here \n Mr. Hussnain",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'FontMain',
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      right: 55,
                      left: 35),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.white,
                        controller: userName,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.verified_user),
                          prefixIconColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.white,
                        controller: userEmail,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Obx(
                        () => TextFormField(
                          cursorColor: Colors.white,
                          controller: userPassword,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          obscureText:
                              !signUpController.isPasswordVisible.value,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: Colors.white,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signUpController.isPasswordVisible.toggle();
                              },
                              child: Icon(
                                signUpController.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Container(
                        width: Get.width / 2.3,
                        height: Get.height / 18,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            String name = userName.text.trim();
                            String email = userEmail.text.trim();
                            String password = userPassword.text.trim();
                            String? userDeviceToken = await notificationService.getDeviceToken();

                            if (name.isEmpty || email.isEmpty || password.isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Please Enter All Details",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            } else {
                              UserCredential? userCredential = await signUpController.signUpMethod(
                                name,
                                email,
                                password,
                                userDeviceToken ?? '',
                              );

                              if (userCredential != null) {
                                Get.snackbar(
                                  "Verification Email Sent",
                                  "Please Check Your Email",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );

                                await FirebaseAuth.instance.signOut();
                                Get.offAll(() => Login());
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            minimumSize: Size(Get.width / 2.3, Get.height / 18),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),


                    SizedBox(height: Get.height / 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.off(() => Login());
                            },
                            child: Text(
                              "Already have an account? Sign In",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
