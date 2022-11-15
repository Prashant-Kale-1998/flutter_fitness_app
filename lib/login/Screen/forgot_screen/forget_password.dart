import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Themes.dart';
import 'package:exercise_app/login/Screen/Login/login_screen.dart';
import 'package:exercise_app/login/Screen/Signup/componants/background.dart';
import 'package:exercise_app/login/Screen/forgot_screen/compenants/rounded_repeat_password_field.dart';
import 'package:exercise_app/login/componants/rounded_button.dart';
import 'package:exercise_app/login/componants/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/login/Constants.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  bool _passwordVisible, _cPasswordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    _cPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Background(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, top: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),

                      Image.asset(
                        "assets/fitness_image/pass.png",
                        height: size.height * 0.35,
                      ),

                      // RoundedPasswordField(
                      // onChanged: (value) {},
                      // ),
                      //
                      // RoundedRepeatPasswordField(onChanged: (value){},),

                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: TextFormField(
                                  // onChanged: onChanged,
                                  obscureText: !_passwordVisible,
                                  controller: passController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return NEW_PASSWORD_VALIDATION[
                                          LANGUAGE_TYPE];
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,
                                          color: kPrimaryColor),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: kPrimaryColor),
                                      ),
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 10),
                                child: TextFormField(
                                  // onChanged: onChanged,
                                  obscureText: !_cPasswordVisible,
                                  controller: confirmPassController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return CONFIRM_PASSWORD_VALIDATION[
                                          LANGUAGE_TYPE];
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,
                                          color: kPrimaryColor),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _cPasswordVisible =
                                                !_cPasswordVisible;
                                          });
                                        },
                                        icon: Icon(
                                            _cPasswordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: kPrimaryColor),
                                      ),
                                      filled: true,
                                      fillColor: kPrimaryLightColor,
                                      hintText: "Confirm Password",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                        borderRadius: BorderRadius.circular(29),
                                      )),
                                ),
                              ),
                            ],
                          )),

                      RoundedButton(
                        text: "Reset Password",
                        press: () {
                          if (_formKey.currentState.validate()) {
                            if (passController.text ==
                                confirmPassController.text) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            }
                            else{
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:WHITE ,
                                    //insetPadding: EdgeInsets.all(16),
                                    content: Container(
                                      height: 100,width: 200,
                                        child:Column(children: [
                                          Text("Conform Password not match with new password..."),
                                          SizedBox(height: 10,),
                                          InkWell(
                                              onTap: (){Navigator.pop(context);},child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                onSurface: Colors.purple
                                              ),
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(color: Colors.black),
                                              )),)
                                        ],)),
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ))),
        ));
  }
}
