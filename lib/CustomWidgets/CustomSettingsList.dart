import 'package:flutter/material.dart';

import '../Themes.dart';
import '../main.dart';

class CustomSettingsListTile{
  Widget tile({String icon, String title, Widget widget}){
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              SizedBox(width: 5,),
              Image.asset("assets/setting/$icon.png",height: 23,width: 23,),
              SizedBox(width: 20,),
              t.boldText(text:title,size: 16,color: BLACK),
            ],
          ),
        ),
        widget,
        SizedBox(width: 10,),
      ],
    );
  }
}