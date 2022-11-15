import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/Screens/SelectWorkouts.dart';
import 'package:exercise_app/Screens/StartExercise.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';

class CustomWorkouts extends StatefulWidget {
  @override
  _CustomWorkoutsState createState() => _CustomWorkoutsState();
}

class _CustomWorkoutsState extends State<CustomWorkouts> {
  CustomWorkoutsClass customWorkoutsClass = CustomWorkoutsClass();
  List<CustomWorkoutsClass> list = List();
  List<List<CustomWorkoutCreateClass>> list2 = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCustomData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        leading: Container(),
        toolbarHeight: 45,
        backgroundColor: WHITE,
        elevation: 0,
        flexibleSpace: customDialogues.header(
            text: "", context: context, goToHomeScreen: true),
      ),
      body: list.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: HEIGHT * 0.35,
                      child: FlareActor(
                        "flare/placeholder.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "idle",
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  customTextWidget.boldText(
                      text: ADD_CUSTOM_WORKOUT,
                      alignment: TextAlign.center,
                      size: 25),
                  SizedBox(
                    height: 10,
                  ),
                  customTextWidget.mediumText(
                      text:
                          CREATE_YOUR_OWN_CUSTOMIZED_WORKOUT_BY_CLICKING_ON_PLUS_ICON,
                      alignment: TextAlign.center,
                      size: 15,
                      color: DARK_GREY_TEXT),
                  SizedBox(
                    height: HEIGHT * 0.15,
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextWidget.boldText(
                      text: CUSTOM_WORKOUT, size: 33, color: BLACK),
                  SizedBox(
                    height: 5,
                  ),
                  customTextWidget.regularText(
                      text: THE_EXERCISE_SHOULD_BE,
                      size: 15,
                      color: LIGHT_GREY_TEXT),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext builder, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Container(
                              height: 75,
                              color: WHITE,
                              child: Row(
                                children: [
                                  Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: CUSTOM_BG,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: customTextWidget.regularText(
                                            text: list[index]
                                                .name
                                                .substring(0, 1),
                                            size: 40,
                                            color: LIGHT_GREY_TEXT),
                                      )),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customTextWidget.mediumText(
                                              text: list[index].name,
                                              size: 17,
                                              color: BLACK,
                                              textOverFlow:
                                                  TextOverflow.ellipsis),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/customWorkout/calories.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    customTextWidget.mediumText(
                                                      text: list[index]
                                                              .totalCalories +
                                                          " " +
                                                          CALORIES_SMALL[
                                                              LANGUAGE_TYPE],
                                                      size: 11,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/customWorkout/clock.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    customTextWidget.mediumText(
                                                        text: list[index]
                                                                .totaltime +
                                                            " " +
                                                            MINUTES_SMALL[
                                                                LANGUAGE_TYPE],
                                                        size: 11),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StartExercise(
                                                      createList: list2[index],
                                                      intervalTime: int.parse(
                                                          list[index]
                                                              .intervalTime))));
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset("assets/detail.png"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => SelectWorkouts()));
          readCustomData();
        },
        
        backgroundColor: ORANGE,
        child: Icon(
          Icons.add,
          color: WHITE,
        ),
      ),
    ));
  }

  readCustomData() async {
    setState(() {
      list.clear();
    });
    await customWorkoutsClass.readData().then((value) {
      setState(() {
        list.addAll(value);
        list2 = List(list.length);
        for (int i = 0; i < list.length; i++) {
          list2[i] = list[i].list;
        }
      });
    });
  }
}
