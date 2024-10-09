
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_with_auth/screens/login.dart';
import 'package:login_signup_with_auth/screens/splash.dart';
import 'package:login_signup_with_auth/screens/register.dart';

class Splash extends StatefulWidget {


  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {

    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Login() ),
      );
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.blue,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/splash.png'),
              ),
              SizedBox(height: 5),
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}