import 'dart:convert';

import 'package:exercise_app/Modals/AllWorkoutsClass.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseMp4.dart';
import 'package:exercise_app/Screens/SelectExercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';
import 'package:exercise_app/main.dart';
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'HowToExercise/HowToExerciseYoutube.dart';
import 'StartExercise.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';

class SelectWorkouts extends StatefulWidget {
  @override
  _SelectWorkoutsState createState() => _SelectWorkoutsState();
}

class _SelectWorkoutsState extends State<SelectWorkouts> {
  List<bool> isChipSelected = [];
  List<Create> workoutslist = List();
  List<CustomWorkoutCreateClass> mylist = List();
  AllWorkoutsClass allWorkoutsClass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExercisesList();
  }

  initialiseList(int size) {
    for (int i = 0; i < size; i++) {
      isChipSelected.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: WHITE,
        elevation: 0,
        leading: Container(),
        flexibleSpace: customDialogues.header(text: "", context: context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextWidget.boldText(
                text: SELECT_WORKOUT, size: 33, color: BLACK),
            SizedBox(
              height: 5,
            ),
            customTextWidget.regularText(
                text: SELECT_ANY_THREE, size: 15, color: DARK_GREY_TEXT),
            SizedBox(
              height: 5,
            ),
            workoutslist.isEmpty
                ? allWorkoutsClass != null
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return exercisesCardLoader();
                            }),
                      )
                : Expanded(
                    child: ListView.builder(
                        itemCount: workoutslist.length,
                        itemBuilder: (BuildContext builder, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChipSelected[index] =
                                      !isChipSelected[index];
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 70,
                                    color: WHITE,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 17,
                                                width: 17,
                                                decoration: BoxDecoration(
                                                    color:
                                                        isChipSelected[index] ==
                                                                false
                                                            ? LIGHT_GREY_TEXT
                                                            : BLUE,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Container(
                                                    height: 16,
                                                    width: 16,
                                                    decoration: BoxDecoration(
                                                        color: WHITE,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Container(
                                                        height: 16,
                                                        width: 16,
                                                        decoration: BoxDecoration(
                                                            color: isChipSelected[
                                                                        index] ==
                                                                    false
                                                                ? WHITE
                                                                : BLUE,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    color: BACK_GREY,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.cover,
                                                    height: 70,
                                                    width: 70,
                                                    imageUrl:
                                                        IMAGE_URL_MENU_ITEM +
                                                                workoutslist[
                                                                        index]
                                                                    .image ??
                                                            " ",
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Container(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        placeHolder(
                                                            borderRadius: 10),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: customTextWidget
                                                            .mediumText(
                                                                text: workoutslist[
                                                                            index]
                                                                        .name ??
                                                                    " ",
                                                                size: 16,
                                                                color: BLACK),
                                                      ),
                                                      SizedBox(
                                                        height: 0,
                                                      ),
                                                      customTextWidget.mediumText(
                                                          text: "X " +
                                                              workoutslist[
                                                                      index]
                                                                  .repeatCount,
                                                          size: 16,
                                                          color:
                                                              DARK_GREY_TEXT),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PLAY_YOUTUBE_VIDEOS
                                                            ? HowToExerciseYoutube(
                                                                ex_id:
                                                                    workoutslist[
                                                                            index]
                                                                        .id,
                                                              )
                                                            : HowToExerciseMp4(
                                                                ex_id:
                                                                    workoutslist[
                                                                            index]
                                                                        .id,
                                                              )));
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image.asset(
                                                  "assets/detail.png"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // DISPLAY_ADS && (index+1)%4    == 0 ? customAds.nativeAds(id: 0) : SizedBox(),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
            InkWell(
              onTap: () {
                for (int i = 0; i < workoutslist.length; i++) {
                  if (isChipSelected[i] == true) {
                    mylist.add(CustomWorkoutCreateClass(
                        name: workoutslist[i].name,
                        calories: workoutslist[i].calories,
                        catName: workoutslist[i].catName,
                        createdAt: workoutslist[i].createdAt,
                        datetime: workoutslist[i].datetime,
                        deletedAt: workoutslist[i].deletedAt,
                        gif: workoutslist[i].gif,
                        id: workoutslist[i].id,
                        image: workoutslist[i].image,
                        isDeleted: workoutslist[i].isDeleted,
                        repeatCount: workoutslist[i].repeatCount,
                        timee: workoutslist[i].timee,
                        updatedAt: workoutslist[i].updatedAt,
                        url: workoutslist[i].url));
                  }
                }
                if (mylist.length != SELECT_WORKOUTS_LIMIT) {
                  print("select $SELECT_WORKOUTS_LIMIT exercises");
                  mylist.clear();
                  showCustomDialog(
                      context: context,
                      title: ERROR,
                      msg: PLEASE_SELECT_LIMIT_EXERCISES,
                      btnYesText: OK,
                      onPressedBtnYes: () {
                        Navigator.pop(context);
                      });
                } else {
                  int ttlcalories = 0;
                  int ttltime = 0;

                  for (int i = 0; i < mylist.length; i++) {
                    ttlcalories = (int.parse(mylist[i].calories)) + ttlcalories;
                    ttltime = (int.parse(mylist[i].timee)) + ttltime;
                  }

                  print(ttltime.toString());
                  print(ttlcalories.toString());
                  //Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectExercise(mylist,
                              ttltime.toString(), ttlcalories.toString())));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  //margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  decoration: BoxDecoration(
                    color: ORANGE,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(
                      child: t.mediumText(
                          text: ADD_WORKOUT, color: WHITE, size: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  getExercisesList() async {
    final _response = await http
        .post(Uri.parse(SERVER_ADDRESS + "/api/get_allexcercise.php"));
    final _jsonResponse = jsonDecode(_response.body);

    if (_response.statusCode == 200 &&
        _jsonResponse['data']['success'] == "1") {
      allWorkoutsClass = AllWorkoutsClass.fromJson(_jsonResponse);
      print("SelectWorkoutScreen/" +
          SERVER_ADDRESS +
          "/api/get_allexcercise.php");
      print("SelectWorkoutScreen/" + _jsonResponse.toString());

      setState(() {
        workoutslist = allWorkoutsClass.data.exercise.create;
      });
      initialiseList(workoutslist.length);
    } else {
      print("SelectWorkoutScreen/error");
    }
  }

  Widget exercisesCardLoader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        height: 70,
        color: WHITE,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: BACK_GREY,
                        borderRadius: BorderRadius.circular(10)),
                    child: loader(height: 60, width: 60, borderRadius: 3),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loader(height: 12, width: 150, borderRadius: 3),
                        SizedBox(
                          height: 10,
                        ),
                        loader(height: 15, width: 100, borderRadius: 3),
                      ],
                    ),
                  )
                ],
              ),
            ),
            loader(height: 50, width: 50, borderRadius: 25)
          ],
        ),
      ),
    );
  }
}
