import 'package:firebase_database/firebase_database.dart';
import 'package:movinguy/authentication/sign_up_screen.dart';
import 'package:movinguy/global/global.dart';
import 'package:movinguy/splash_screen/splash_screen.dart';
import 'package:movinguy/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains('@')) {
      Fluttertoast.showToast(
        msg: "Email is not valid.",
        backgroundColor: Colors.white,
        textColor: Colors.red,
      );
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Password is required.",
        backgroundColor: Colors.white,
        textColor: Colors.red,
      );
    } else {
      loginUserNow();
    }
  }

  loginUserNow() async {
    showDialog(
      context: context,
      builder: (BuildContext c) => ProgressDialog(
        message: 'Processing, Please wait..',
      ),
      barrierDismissible: false,
    );
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        msg: 'Error ${msg.toString()}',
        backgroundColor: Colors.white,
        textColor: Colors.red,
      );
    }))
        .user;
    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      DatabaseReference usersRef =
          FirebaseDatabase.instance.ref().child('users');
      usersRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          Fluttertoast.showToast(
            msg: 'Welcome! Successfully logged in.',
            backgroundColor: Colors.white,
            textColor: Colors.cyan,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => SplashScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'No record exists with this email.',
            backgroundColor: Colors.white,
            textColor: Colors.cyan,
          );
          fAuth.signOut();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => SplashScreen(),
            ),
          );
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Error occurred during login.',
        backgroundColor: Colors.white,
        textColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Login as a User',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: const Text(
                  'Login now!',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const SignUpScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'You don\'t have an Account? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Register here!',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
