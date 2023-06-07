import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movinguy/authentication/login_screen.dart';
import 'package:movinguy/global/global.dart';
import 'package:movinguy/helpers/helper_methods.dart';
import 'package:movinguy/main_screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    if (fAuth.currentUser != null) {
      HelperMethods.readCurrentOnlineInfo();
    }
    Timer(const Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const MainScreen(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const LoginScreen(),
          ),
        );
      }
      // send user to home screen
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Taxi & Driver',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
