
import 'dart:ui';

//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/Modals/HomeScreenClass.dart';
import 'package:exercise_app/Screens/AboutUsScreen.dart';
import 'package:exercise_app/Screens/ContactUsScreen.dart';
import 'package:exercise_app/Screens/PrivacyPolicyScreen.dart';
import 'package:exercise_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../AllText.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomTextWidget.dart';
import '../Themes.dart';
import 'HomeScreen.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  double _value = 1;
  bool isReminderOn=false;
  bool isHalfwayOn=false;
  bool isVoiceGuidanceOn=false;
  SharedPreferences sharedPreferences;
  TextEditingController timeController = TextEditingController();
  DateTime now = DateTime.now();
  final player = AudioPlayer();
  //AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadSettings();
     //timeController.text=TimeOfDay.now().period.toString();

  }

  loadSettings() async{
    initSharedPreferences();
    SharedPreferences.getInstance().then((value){
      setState(() {
        isReminderOn = value.getBool("isReminderOn") ?? false;
        isVoiceGuidanceOn = value.getBool("isVoiceGuidanceOn") ?? true;
        isHalfwayOn = value.getBool("isHalfwayPromptOn") ?? true;
        timeController.text = value.getString("reminderTime") ?? "Set a reminder";
        _value = value.getDouble("volume") ?? 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(

        toolbarHeight: 45,
        elevation: 0,
        backgroundColor: WHITE,
        flexibleSpace: customDialogues.header(text: "",context: context, goToHomeScreen: true),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 10, 0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
           children: [
            customTextWidget.boldText(text: SETTING,size: 33,color: BLACK),
            SizedBox(height: 15,),

            // account section

          customTextWidget.boldText(text:ACCOUNT,size: 17,color: BLUE),
           SizedBox(height: 15,),
            // lt.tile(
            //   icon :"rate_us",
            //   title: RATE_US[LANGUAGE_TYPE],
            //   widget: Image.asset("assets/setting/right_arrow.png",height: 15,width: 15,),
            // ),
            // SizedBox(height:25,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUsScreen()));
              },
              child: lt.tile(
                icon :"email",
                title: CONTACT_US[LANGUAGE_TYPE],
                widget: Image.asset("assets/setting/right_arrow.png",height: 15,width: 15,),
              ),
            ),

            SizedBox(height: 30,),

            // notification section
            // customTextWidget.boldText(text:NOTIFICATION,size: 17,color: BLUE),
            // SizedBox(height: 15,),
            // lt.tile(
            //   icon :"reminder",
            //   title: REMINDER[LANGUAGE_TYPE],
            //   widget: GestureDetector(
            //       onTap: () async {

            //         setState(() {
            //           isReminderOn=!isReminderOn;
            //           sharedPreferences.setBool("isReminderOn", isReminderOn);
            //         });
            //         if(!isReminderOn){
            //           notificationHelper.cancelNotification(1);
            //           notificationHelper.cancelNotification(2);
            //         }
            //       },
            //       child: isReminderOn
            //           ?Image.asset("assets/setting/switch_active.png",height: 25,width: 35,)
            //           :Image.asset("assets/setting/switch.png",height: 25,width: 35,)),
            // ),
            // SizedBox(height: 20,),
            // Visibility(
            //   visible: isReminderOn,
            //   child: InkWell(
            //     onTap: () async {

            //       print("clicked");

            //       var time =  await showTimePicker(
            //         initialTime: TimeOfDay.now(),
            //         context: context,);
            //       setState(() {
            //         timeController.text = time.format(context);
            //         sharedPreferences.setString("reminderTime", timeController.text);
            //         notificationHelper.cancelNotification(1);
            //         notificationHelper.cancelNotification(2);
            //         int second = DateTime.now().difference(DateTime(now.year, now.month, now.day, time.hour, time.minute)).inSeconds.abs();
            //         notificationHelper.scheduleNotification(
            //           title: WORKOUT[LANGUAGE_TYPE],
            //           body: YOUR_WORKOUT_TIME_IS_UP[LANGUAGE_TYPE],
            //           payload: "payload",
            //           id: 10.toString(),
            //           context2: context,
            //           seconds: second,
            //         );
            //       });
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             SizedBox(width: 50,),
            //           customTextWidget.mediumText(text: REMINDER_TIME,color: LIGHT_GREY_TEXT,size: 15),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Container(
            //               child: customTextWidget.mediumText(text: timeController.text ?? " ",size: 11,color: LIGHT_GREY_TEXT)
            //             ),
            //             SizedBox(width: 16,)
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            // SizedBox(height: 20,),

            // // volume section
            // customTextWidget.boldText(text: APP_VOLUME,size: 17,color: BLUE),
            // SizedBox(height: 15,),
            // Row(
            //   children: [
            //     SizedBox(width: 5,),
            //     Image.asset("assets/setting/mute.png",height: 23,width: 23,),
            //     Expanded(
            //        child: SfSlider(


            //          onChanged: (value){
            //            setState(() {
            //              _value=value;
            //            });
            //            sharedPreferences.setDouble("volume", _value);
            //            loadAudio321(_value);
            //                    // assetsAudioPlayer.open(
            //                    //     Audio("assets/audios/321.wav"),
            //                    //     volume: _value);
            //          },
            //          min: 0.0,
            //          max: 1.0,
            //          value: _value,
            //          activeColor: PEACH,
            //         inactiveColor: BACK_GREY,

            //          thumbIcon: Icon(Icons.circle,size: 16,color: WHITE,),

            //        ),

            //     ),
            //     Image.asset("assets/setting/volume.png",height: 23,width: 23,),
            //     SizedBox(width: 10,)
            //     // customTextWidget.mediumText(text: "Volume",size: 16,color: BLACK),
            //   ],
            // ),
            // SizedBox(height: 20,),
            // lt.tile(
            //   icon :"mike",
            //   title: VOICE_GUIDANCE[LANGUAGE_TYPE],
            //   widget: GestureDetector(
            //       onTap: (){

            //         setState(() {
            //           isVoiceGuidanceOn=!isVoiceGuidanceOn;
            //           sharedPreferences.setBool("isVoiceGuidanceOn", isVoiceGuidanceOn);
            //         });

            //       },
            //       child: isVoiceGuidanceOn
            //           ? Image.asset("assets/setting/switch_active.png",height: 25,width: 35,)
            //           : Image.asset("assets/setting/switch.png",height: 25,width: 35,)),

            // ),
            // SizedBox(height: 25,),
            // lt.tile(
            //   icon :"half",
            //   title: HALFWAY_PROMPT[LANGUAGE_TYPE],
            //   widget: GestureDetector(
            //       onTap: (){
            //         setState(() {

            //           isHalfwayOn=!isHalfwayOn;
            //           sharedPreferences.setBool("isHalfwayPromptOn", isHalfwayOn);
            //         });

            //       },
            //       child: isHalfwayOn

            //           ?Image.asset("assets/setting/switch_active.png",height: 25,width: 35,)
            //           :Image.asset("assets/setting/switch.png",height: 25,width: 35,)),
            // ),


            // SizedBox(height: 30,),

            // more section
            customTextWidget.boldText(text: "More",size: 17,color: BLUE),
            SizedBox(height: 15,),
            // InkWell(
            //   onTap: (){
            //         showCustomDialog(
            //             title: RESET_SETTINGS,
            //             msg: ARE_YOU_SURE_RESET,
            //             btnYesText: YES,
            //             btnNoText: NO,
            //             onPressedButtonNo: (){
            //               Navigator.pop(context);
            //             },
            //             onPressedBtnYes: (){
            //           resetSettings();
            //           },context: context);
//                resetSettings();
//                customDialogues.infoDialog(context: context,title:RESET_SETTINGS[LANGUAGE_TYPE],msg: ARE_YOU_SURE_RESET[LANGUAGE_TYPE],widget:resetSettings())  ;
//  },
          
            //   child: lt.tile(
            //     icon :"setting",
            //     title: RESET_SETTING[LANGUAGE_TYPE],
            //     widget: Image.asset("assets/setting/right_arrow.png",height: 15,width: 15,),
              
            //   ),
            // ),
            // SizedBox(height: 25,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));

              },
              child: lt.tile(
                icon :"lock",
                title: PRIVACY_POLICY[LANGUAGE_TYPE],
                widget: Image.asset("assets/setting/right_arrow.png",height: 15,width: 15,),
              ),
            ),
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutScreen()));

              },
              child: lt.tile(
                icon :"about_us",
                title: ABOUT_US[LANGUAGE_TYPE],
                widget: Image.asset("assets/setting/right_arrow.png",height: 15,width: 15,),
              ),
            ),
             SizedBox(height: 20,)
          ],
          ),
        ),
      ),
    ));
  }


  initSharedPreferences() async{
    sharedPreferences=await SharedPreferences.getInstance();

  }
  resetSettings(){
    print("called");
    setState(() {
      isReminderOn=false;
      isVoiceGuidanceOn=false;
      isHalfwayOn=false;
    });
    sharedPreferences.setBool("isReminderOn", false);
    notificationHelper.cancelNotification(1);
    notificationHelper.cancelNotification(2);
    sharedPreferences.setBool("isVoiceGuidanceOn", true);
    sharedPreferences.setBool("isHalfwayPromptOn", true);
    loadSettings();
    Navigator.pop(context);
  }

  showCustomDialog({title, msg, onPressedBtnYes(), onPressedButtonNo(), btnYesText, btnNoText , context}) {

    return showDialog(
        context: context,
        builder: (context){
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      t.mediumText(
                          text: title,
                          size: 22
                      ),
                      SizedBox(height: 10,),
                      t.regularText(
                          text: msg,
                          size: 15,
                          alignment: TextAlign.center
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      btnYesText == null ? Container() : Row(
                        children: [
                          SizedBox(width: 20,),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                onPressedBtnYes();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: BLUE,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: t.mediumText(
                                        text: btnYesText,
                                        color: WHITE,
                                        size: 15
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
                      btnYesText == null ? Container() :SizedBox(
                        height: 10,
                      ),
                      btnNoText == null ? Container() :Row(
                        children: [
                          SizedBox(width: 20,),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                onPressedButtonNo();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: LIGHT_GREY_SCREEN_BACKGROUND,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: t.mediumText(
                                        text: btnNoText,
                                        color: BLACK,
                                        size: 15
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );

  }

  loadAudio321(double v) async{
    await player.setAsset('assets/audios/321.wav').then((value) async{
      print("duration : ${value.inMilliseconds}");
      player.setVolume(v);
      player.play();
    });
  }


}
