import 'package:exercise_app/login/componants/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:exercise_app/login/constants.dart';
class RoundedRepeatPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedRepeatPasswordField({
    Key key,  this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
          onChanged: onChanged,
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Confirm Password",
              icon: Icon(
                Icons.lock,
                color: kPrimaryColor,
              ),
              suffix: Icon(
                Icons.visibility,
                color: kPrimaryColor,
              ),
              border: InputBorder.none),
        ));
  }
}