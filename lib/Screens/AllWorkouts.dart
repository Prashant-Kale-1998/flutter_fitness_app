import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/Modals/AllWorkoutsClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';
import '../Modals/AllWorkoutsClass.dart';
import '../Themes.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'HowToExercise/HowToExerciseMp4.dart';
import 'HowToExercise/HowToExerciseYoutube.dart';

class AllWorkouts extends StatefulWidget {
  @override
  _AllWorkoutsState createState() => _AllWorkoutsState();
}

class _AllWorkoutsState extends State<AllWorkouts> {
  AllWorkoutsClass allWorkoutsClass;
  List<Create> list = List();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    getExercisesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        toolbarHeight: 45,
        backgroundColor: WHITE,
        elevation: 0,
        flexibleSpace: customDialogues.header(
            text: "", context: context, goToHomeScreen: true),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextWidget.boldText(
                text: ALL_WORKOUTS, size: 33, color: BLACK),
            SizedBox(
              height: 5,
            ),
            customTextWidget.regularText(
                text: WARM_UP_PROPERLY, size: 15, color: LIGHT_GREY_TEXT),
            SizedBox(
              height: 5,
            ),
            list.isEmpty
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
                        itemCount: list.length,
                        itemBuilder: (BuildContext builder, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PLAY_YOUTUBE_VIDEOS
                                                    ? HowToExerciseYoutube(
                                                        ex_id: list[index].id)
                                                    : HowToExerciseMp4(
                                                        ex_id:
                                                            list[index].id)));
                                  },
                                  child: Container(
                                    height: 72,
                                    color: WHITE,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
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
                                                    height: HEIGHT * 0.20,
                                                    width: WIDTH * 0.20,
                                                    imageUrl:
                                                        IMAGE_URL_MENU_ITEM +
                                                                list[index]
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
                                              // Image.asset("assets/splash/1 crop.png",fit: BoxFit.cover,)),
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
                                                      // Expanded(child:
                                                      // customTextWidget.mediumText(text:list[index].name??" ",size: 17,color: BLACK),
                                                      //
                                                      // ),
                                                      customTextWidget
                                                          .mediumText(
                                                              text: list[index]
                                                                  .name,
                                                              size: 18,
                                                              color: BLACK,
                                                              textOverFlow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      customTextWidget.mediumText(
                                                          text: "X " +
                                                                  list[index]
                                                                      .repeatCount
                                                                      .toString() ??
                                                              " ",
                                                          color:
                                                              LIGHT_GREY_TEXT,
                                                          size: 14),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image.asset(
                                                "assets/detail.png"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //  DISPLAY_ADS && (index+1)%4    == 0 ? customAds.nativeAds(id: 0) : SizedBox(),
                              ],
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  getExercisesList() async {
    final _response = await http
        .post(Uri.parse(SERVER_ADDRESS + "/api/get_allexcercise.php"));
    final _jsonResponse = jsonDecode(_response.body);

    if (_response.statusCode == 200 &&
        _jsonResponse['data']['success'] == "1") {
      allWorkoutsClass = AllWorkoutsClass.fromJson(_jsonResponse);
      print("AllWorkoutsScreen/" + SERVER_ADDRESS + "api/get_allexcercise.php");
      print("AllWorkoutsScreen/" + _jsonResponse.toString());

      setState(() {
        list = allWorkoutsClass.data.exercise.create;
      });
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: FAILED_TO_LOAD_DATA,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
      print("AllWorkoutScreen/error");
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
