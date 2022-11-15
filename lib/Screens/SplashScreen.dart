import 'dart:async';
import 'dart:convert';
import 'package:exercise_app/login/Screen/Login/login_screen.dart';
import 'package:exercise_app/login/Screen/Signup/signup_screen.dart';
import 'package:exercise_app/login/Screen/Welcome/welcome_screen.dart';
import 'package:exercise_app/Screens/SetUpProfileScreen.dart';
import 'package:exercise_app/login/Screen/Welcome/welcome_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TabsScreen.dart';
import '../main.dart';
import 'IntroSlider.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAndStoreToken();
  }

  findPPIofDevice() {
    setState(() {
      HEIGHT = MediaQuery.of(context).size.height;
      WIDTH = MediaQuery.of(context).size.width;
      print("Height & Width");
      print(HEIGHT);
      print(WIDTH);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    findPPIofDevice();
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/splash/bg.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Image.asset(
                "assets/splash/1 crop.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  getAndStoreToken() async {
    SharedPreferences.getInstance().then((value) async {
      //first time
      if (value.getBool("isTokenStored") ?? false) {
        print(await FirebaseMessaging.instance.getToken());
        callHomeScreen();
      } else if (value.getBool("isTokenStored") == null) {
        FirebaseMessaging.instance.getToken().then((value) {
          storeToken(value);
        }).catchError((e) {
          // print("SplashScreen/Token Retrieving Error :" + e.toString());
          value.setBool("isTokenStored", false);
          callIntroSlider();
        });
      } else if (value.getBool("isTokenStored") == false) {
        FirebaseMessaging.instance.getToken().then((value) {
          storeToken(value);
        }).catchError((e) {
          // print("SplashScreen/Token Retrieving Error :" + e.toString());
          value.setBool("isTokenStored", false);
          callHomeScreen();
        });
      }
    });
  }

  callIntroSlider() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroSlider()));
    });
  }

  callHomeScreen() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getBool("isUserRegistered") ?? false) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  storeToken(token) async {
    print(
        "SplashScreen/$SERVER_ADDRESS/api/tokan_data.php?token=$token&type=android");
    await post("$SERVER_ADDRESS/api/tokan_data.php?token=$token&type=android")
        .then((value) {
      final jsonResponse = jsonDecode(value.body);
      // print("SplashScreen/" + jsonResponse.toString());
      if (value.statusCode == 200 && jsonResponse['data']['success'] == "1") {
        SharedPreferences.getInstance().then((value) {
          value.setBool("isTokenStored", true);
          callIntroSlider();
        });
      }
    }).catchError((e) {
      print("SplashScreenError/" + e.toString());
      SharedPreferences.getInstance().then((value) {
        value.setBool("isTokenStored", false);
        callIntroSlider();
      });
    });
  }
}
