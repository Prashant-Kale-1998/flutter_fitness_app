import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';
import 'package:exercise_app/CustomWidgets/CustomTextWidget.dart';

import 'package:exercise_app/Modals/HomeScreenClass.dart';

import 'package:exercise_app/Screens/Exercises.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exercise_app/main.dart';
import 'package:exercise_app/Themes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenClass homeScreenClass;
  List<Exercise> list = List();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  bool showDialog = false;

  final predefinedColors = [
    Color(0xFF9935E0),
    Color(0xFF00B981),
    Color(0xFF35318D),
    Color(0xFFC7594B),
    Color(0xFFE16588),
    Color(0xFFEC5952),
    Colors.teal,
    Colors.brown,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.pink[300],
    Colors.cyan[700],
    Colors.deepOrange[200],
    Colors.deepPurpleAccent,
    Colors.deepPurple,
  ];
  CustomTextWidget customTextWidget = CustomTextWidget();
  @override
  void initState() {
    // TODO: implement initState
    getExercisesList();

    FirebaseMessaging.onMessage.listen((event) {
      notificationHelper.showNotification(
          title: event.notification.title,
          body: event.notification.body,
          payload: "payload",
          id: "124",
          context2: context);
    });

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     print("\n\n"+message.toString());
    //     notificationHelper.showNotification(title: message['notification']['title'],body: message['notification']['body'] ,payload: "payload", id: "124", context2: context);
    //   },
    //   //onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     print("\n\n"+message.toString());
    //     // if(message['data']['type'] == "user_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => UserAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //     // else if(message['data']['type'] == "doctor_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => DoctorAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     print("\n\n"+message['data'].toString());
    //     // if(message['data']['type'] == "user_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => UserAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //     // else if(message['data']['type'] == "doctor_id"){
    //     //   Navigator.push(context,
    //     //     MaterialPageRoute(builder: (context) => DoctorAppointmentDetails(message['data']['order_id'].toString())),
    //     //   );
    //     // }
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: body(),
    ));
  }

  body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextWidget.regularText(
                  text: FIND_YOUR, size: 20, color: DARK_BLUE),
              customTextWidget.boldText(
                  text: FAVOURITE_WORKOUT_PLAN, size: 25, color: DARK_BLUE),
              homeScreenClass == null
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return myFavouriteExerciseCardLoader(index);
                      },
                    )
                  : AnimatedList(
                      key: listKey,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      initialItemCount: list.length - 1,
                      itemBuilder: (context, index, animation) {
                        return myFavouriteExerciseCard(index, animation);
                      })
            ],
          ),
        ),
      ),
    );
  }

  myFavouriteExerciseCard(int index, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExercisesScreen(
                        category_id: list[index].id,
                        category_name: list[index].name,
                        category_description: list[index].description,
                        total_exercise: list[index].totalExercise,
                        total_time: ((list[index].time / 60).truncate() % 60)
                            .toString()
                            .padLeft(2, '0'),
                        total_calories: list[index].calories.toString(),
                        image_url: list[index].image,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: predefinedColors[index < 10 ? index : index % 10]),
          padding: EdgeInsets.fromLTRB(15, 20, 8, 10),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.contain,
                    height: 140,
                    width: 125,
                    imageUrl: IMAGE_ADDRESS_HOME + list[index].image ?? " ",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(),
                    errorWidget: (context, url, error) =>
                        placeHolder(height: 140, width: 130, borderRadius: 10),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextWidget.mediumText(
                      text: list[index].name ?? "7M Beginner",
                      size: 20,
                      color: WHITE),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/home/excercise.png",
                                height: 15,
                                width: 15,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              customTextWidget.lightText(
                                  text: list[index].totalExercise +
                                          " " +
                                          EXERCISES[LANGUAGE_TYPE] ??
                                      " ",
                                  size: 12,
                                  color: WHITE)
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Image.asset(
                          //       "assets/home/calories.png",
                          //       height: 15,
                          //       width: 15,
                          //       fit: BoxFit.cover,
                          //     ),
                          //     SizedBox(
                          //       width: 3,
                          //     ),
                          //     customTextWidget.lightText(
                          //         text: list[index].calories.toString() +
                          //                 " " +
                          //                 CALORIES_SMALL[LANGUAGE_TYPE] ??
                          //             " ",
                          //         size: 12,
                          //         color: WHITE)
                          //   ],
                          // )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/home/clock.png",
                                height: 15,
                                width: 15,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              customTextWidget.lightText(
                                  text:
                                      ((list[index].time / 60).truncate() % 60)
                                                  .toString()
                                                  .padLeft(2, '0') +
                                              " " +
                                              MINUTES_SMALL[LANGUAGE_TYPE] ??
                                          " ",
                                  size: 12,
                                  color: WHITE)
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Image.asset(
                          //       "assets/home/star.png",
                          //       height: 15,
                          //       width: 15,
                          //       color: WHITE,
                          //       fit: BoxFit.cover,
                          //     ),
                          //     SizedBox(
                          //       width: 3,
                          //     ),
                          //     customTextWidget.lightText(
                          //         text: list[index].level ?? " ",
                          //         size: 12,
                          //         color: WHITE)
                          //   ],
                          // )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: WHITE.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: WHITE,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  myFavouriteExerciseCardLoader(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: LIGHT_GREY_SCREEN_BACKGROUND),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loader(height: 20, width: 80, borderRadius: 3),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/excercise.png",
                            height: 15,
                            width: 15,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/calories.png",
                            height: 15,
                            width: 15,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/clock.png",
                            height: 15,
                            width: 15,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/home/star.png",
                            height: 15,
                            width: 15,
                            color: WHITE,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          loader(height: 15, width: 65, borderRadius: 2),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  loader(height: 35, width: 35, borderRadius: 17),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  getExercisesList() async {
    final _response = await http
        .get(Uri.parse(SERVER_ADDRESS + "/api/get_set_by_category.php"))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: INTERNET_CONNECTION,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });
    print("HomeScreen/" + SERVER_ADDRESS + "/api/get_set_by_category.php");
    final _jsonResponse = jsonDecode(_response.body);
    homeScreenClass = HomeScreenClass.fromJson(_jsonResponse);
    print("HomeScreen/" + _jsonResponse.toString());
    if (_response.statusCode == 200 && _jsonResponse['success'] == "1") {
      if (mounted) {
        setState(() {
          homeScreenClass = HomeScreenClass.fromJson(_jsonResponse);
        });
      }

      for (int j = 0; j < homeScreenClass.exercise.length; j++) {
        list.insert(j, homeScreenClass.exercise[j]);
        await Future.delayed(Duration(milliseconds: 200));
        if (mounted) {
          listKey.currentState.insertItem(j);
        }
      }
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
      print("HomeScreen/error/");
    }
  }
}
