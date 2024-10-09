import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_with_auth/controllers/get_user_data_controller.dart';
import 'package:login_signup_with_auth/main.dart';
import 'package:login_signup_with_auth/screens/customer_welcome_screen.dart';
import 'package:login_signup_with_auth/screens/register.dart';
import '../controllers/singin_controller.dart';
import 'admin_panel/admin_main_screen.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 135),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "Login Here!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.white,
                        controller: userEmail,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.grey,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => TextFormField(
                          controller: userPassword,
                          obscureText: signInController.isPasswordVisible.value,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: Colors.grey,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signInController.isPasswordVisible.toggle();
                              },
                              child: Icon(
                                signInController.isPasswordVisible.value
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
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color(0xff4c5050),
                                fontSize: 25,
                                fontFamily: 'FontMain',
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff4c5050),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  String email = userEmail.text.trim();
                                  String password = userPassword.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    Get.snackbar(
                                      "Error",
                                      "Please enter all details",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  } else {
                                    UserCredential? userCredential =
                                        await signInController.signInMethod(
                                            email, password);
                                    var userData = await getUserDataController
                                        .getUserData(userCredential!.user!.uid);

                                    if (userCredential != null) {
                                      if (userCredential.user!.emailVerified) {
                                        if (userData[0]['isAdmin'] == true) {
                                          Get.snackbar(
                                            "Success Admin Login",
                                            "login Successfully!",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                          );
                                          Get.offAll(() => AdminMainScreen());
                                        } else {
                                          Get.offAll(() => CustomerDashboard());
                                          Get.snackbar(
                                            "Success User Login",
                                            "login Successfully!",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white,
                                          );
                                        }
                                      } else {
                                        Get.snackbar(
                                          "Error",
                                          "Please verify your email before login",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      }
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        "Please try again",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    }
                                  }
                                },
                                icon: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ),
                      ),


                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff4c5050),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
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
