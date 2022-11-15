import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Screens/SetUpProfileScreen.dart';
import 'package:exercise_app/Themes.dart';
import 'package:exercise_app/login/componants/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/login/Screen/Login/login_screen.dart';
import 'package:exercise_app/login/Screen/Signup/componants/background.dart';
import 'package:exercise_app/login/componants/already_have_an_account_check.dart';
import 'package:exercise_app/login/componants/rounded_button.dart';
import 'package:exercise_app/login/componants/rounded_input_field.dart';
import 'package:exercise_app/login/Constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              "assets/fitness_image/sign.png",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.003,
            ),
            Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return EMAIL_VALIDATION[LANGUAGE_TYPE];
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: kPrimaryColor),
                          filled: true,
                          fillColor: kPrimaryLightColor,
                          hintText: "Your Email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(29),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: TextFormField(
                      // onChanged: onChanged,
                      obscureText: !_passwordVisible,
                      controller: passController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return PASSWORD_VALIDATION[LANGUAGE_TYPE];
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: kPrimaryColor),
                          suffixIcon:
                          IconButton(
                            onPressed:(){
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon:Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:kPrimaryColor),),
                          filled: true,
                          fillColor: kPrimaryLightColor,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(29),
                          )),
                    ),
                  ),
                ])),
            // RoundedInputField(hintText: "Your Email", onChanged: (value) {}),
            // RoundedPasswordField( onChanged: (value) {}),
            SizedBox(
              height: size.height * 0.003,
            ),
            RoundedButton(
                text: "SIGNUP",
                press: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SetUpProfileScreen();
                    }));
                  }
                }),
            AlreadyHaveanAccountCheck(
                login: false,
                press: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
