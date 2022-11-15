import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Themes.dart';
import 'package:exercise_app/login/Screen/Login/componants/background.dart';
import 'package:exercise_app/login/Screen/forgot_screen/forget_password.dart';
import 'package:exercise_app/login/componants/rounded_button.dart';
import 'package:exercise_app/login/componants/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/login/Constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: background(
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email Confirmation",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),

                    Image.asset(
                      "assets/fitness_image/email.png",
                      height: size.height * 0.35,
                    ),

                    Form(
                        key: _formKey,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return EMAIL_VALIDATION[LANGUAGE_TYPE];
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.person, color: kPrimaryColor),
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
                        )),

                    // RoundedInputField(
                    //   hintText: "Your Email",
                    //   onChanged: (value) {},
                    // ),

                    RoundedButton(
                      text: "Set New Password",
                      press: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ForgetPasswordPage();
                          }));
                        }
                      },
                    ),
                  ],
                ))),
      ),
    );
  }
}
