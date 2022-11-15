import 'package:flutter/material.dart';
import 'package:exercise_app/login/Constants.dart';
import 'package:exercise_app/login/Screen/Welcome/componants/background.dart';
import 'package:exercise_app/login/Screen/Login/login_screen.dart';
import 'package:exercise_app/login/Screen/Signup/signup_screen.dart';
import 'package:exercise_app/login/componants/rounded_button.dart';


class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WELCOME TO FITNESS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              "assets/fitness_image/chat.png",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                }),
            RoundedButton(
                text: "SIGNUP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
