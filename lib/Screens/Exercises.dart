import 'dart:convert';
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exercise_app/Modals/ExercisesClass.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseMp4.dart';
import 'package:exercise_app/Screens/IntroSlider.dart';
import 'package:exercise_app/Screens/StartExerciseTabScreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'StartExercise.dart';
import 'package:exercise_app/Screens/HowToExercise/HowToExerciseYoutube.dart';
import 'package:flutter/material.dart';

import '../AllText.dart';
import '../Themes.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:exercise_app/CustomWidgets/CustomDialogues.dart';

class ExercisesScreen extends StatefulWidget {
  String category_id;
  String category_name;
  String category_description;
  String total_exercise;
  String total_time;
  String total_calories;
  String image_url;

  ExercisesScreen(
      {@required this.category_id,
      @required this.category_name,
      @required this.category_description,
      @required this.total_exercise,
      @required this.total_time,
      @required this.total_calories,
      @required this.image_url});

  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  ExercisesClass exercisesClass;
  List<Create> list = List();
  int x = 7;
  String myMsg = MY_MSG[LANGUAGE_TYPE];
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  bool showDialog = false;
  Timer textAnimationTimer = Timer(Duration(seconds: 1), () {});
  String animatedMsg = "";
  InterstitialAd _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getExercisesbyCategoryList();
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (showDialog) {
            setState(() {
              showDialog = false;
            });
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: WHITE,
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, val) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: WHITE,
                      expandedHeight: 300,
                      pinned: true,
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: WHITE,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: BLACK,
                          ),
                          // child:
                          //IconButton(
                          //   icon: customDialogues.header(text: "",context: context,whiteicon: false,),
                          //   constraints: BoxConstraints(maxWidth: 30, minWidth: 10),
                          //   padding: EdgeInsets.zero,
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //   },
                          // ),
                        ),
                      ),
                      actions: <Widget>[
                        PopupMenuButton<String>(
                          onSelected: handleClick,
                          itemBuilder: (BuildContext context) {
                            return {'One', 'Two'}.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ],
                      flexibleSpace: Center(
                        child: Stack(
                          children: [
                            Container(
                              color: LIGHT_GREY_SCREEN_BACKGROUND,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 40),
                              child: CachedNetworkImage(
                                fit: BoxFit.contain,
                                height: 280,
                                width: MediaQuery.of(context).size.width,
                                imageUrl:
                                    IMAGE_ADDRESS_HOME + widget.image_url ??
                                        " ",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(),
                                errorWidget: (context, url, error) =>
                                    placeHolder(borderRadius: 10),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                    color: WHITE,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                t.boldText(
                                  text: widget.category_name ?? " ",
                                  size: 28,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                t.mediumText(
                                  text: widget.category_description ?? " ",
                                  size: 14,
                                  color: LIGHT_GREY_TEXT,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: BLUE.withOpacity(0.2)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/home/excercise.png",
                                              height: 15,
                                              width: 15,
                                              color: BLUE,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            t.lightText(
                                              text: widget.total_exercise +
                                                      " " +
                                                      EXERCISES[
                                                          LANGUAGE_TYPE] ??
                                                  " ",
                                              size: 11,
                                              color: BLUE,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ORANGE.withOpacity(0.2)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/home/clock.png",
                                              height: 15,
                                              width: 15,
                                              color: ORANGE,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            t.lightText(
                                              text: widget.total_time +
                                                      " " +
                                                      MINUTES[LANGUAGE_TYPE] ??
                                                  " ",
                                              size: 11,
                                              color: ORANGE,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Expanded(
                                    // child: Container(
                                    //   padding: EdgeInsets.all(8),
                                    //   decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //       color: BLUE.withOpacity(0.2)),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.center,
                                    //     children: [
                                    //       Image.asset(
                                    //         "assets/home/calories.png",
                                    //         height: 15,
                                    //         width: 15,
                                    //         color: BLUE,
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5,
                                    //       ),
                                    //       t.lightText(
                                    //         text: widget.total_calories +
                                    //                 " " +
                                    //                 CALORIES[LANGUAGE_TYPE] ??
                                    //             " ",
                                    //         size: 11,
                                    //         color: BLUE,
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                    //  ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                t.regularText(
                                    text: EXERCISES, size: 23, color: BLACK),
                                list.isEmpty
                                    ? exercisesClass != null
                                        ? Container()
                                        : ListView.builder(
                                            itemCount: 10,
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return exercisesCardLoader();
                                            })
                                    : AnimatedList(
                                        key: listKey,
                                        initialItemCount: list.length - 1,
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (BuildContext builder,
                                            int index, animation) {
                                          return exercisesCard(
                                              list, index, animation);
                                        }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                // Timer(Duration(seconds: 2), (){
                                //   setState(() {
                                //     x = 30;
                                //     print("func called");
                                //   });
                                // });
                                if (exercisesClass == null) {
                                } else {
                                  setState(() {
                                    showDialog = true;
                                    animatedMsg = "";
                                  });
                                  // for(int i=0; i<ARE_YOU_EXCITED[LANGUAGE_TYPE].length; i++){
                                  //   setState(() {
                                  //     animatedMsg = animatedMsg + ARE_YOU_EXCITED[LANGUAGE_TYPE][i];
                                  //   });
                                  //   await Future.delayed(Duration(milliseconds: 50));
                                  //   if(!showDialog){
                                  //     break;
                                  //   }
                                  // }
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  decoration: BoxDecoration(
                                    color: ORANGE,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: t.regularText(
                                      text: START,
                                      size: 22,
                                      color: WHITE,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              showDialog
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showDialog = false;
                        });
                      },
                      child: Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        color: Colors.black54,
                        child: myCustomDialog(
                          title: ARE_YOU_READY,
                          msg: ARE_YOU_EXCITED[LANGUAGE_TYPE],
                          btnNoText: NO_HOLD_ON,
                          btnYesText: YES_AM_READY,
                          onPressedBtnYes: () {
                            setState(() {
                              showDialog = false;
                            });
                            if (DISPLAY_ADS) {
                              customDialogues.progressDialog(
                                  context: context,
                                  title: SHOWING_AD[LANGUAGE_TYPE]);
                              createInterstitialAd();
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartExercise(
                                          createList: exercisesClass
                                              .data.exercise.create,
                                        )),
                              );
                            }
                          },
                          onPressedButtonNo: () {
                            setState(() {
                              showDialog = false;
                            });
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  getExercisesbyCategoryList() async {
    final _response = await http
        .post(Uri.parse(SERVER_ADDRESS +
            "/api/getexercisebycategory.php?cat_id=" +
            widget.category_id))
        .catchError((e) {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg:INTERNET_CONNECTION,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
    });
    final _jsonResponse = jsonDecode(_response.body);
    print("ExercisesScreen/" +
        SERVER_ADDRESS +
        "/api/getexercisebycategory.php?cat_id=" +
        widget.category_id);

    if (_response.statusCode == 200 &&
        _jsonResponse['data']['success'] == "1") {
      print("ExercisesScreen/" + _jsonResponse.toString());

      setState(() {
        exercisesClass = ExercisesClass.fromJson(_jsonResponse);
      });

      for (int j = 0; j < exercisesClass.data.exercise.create.length; j++) {
        list.insert(j, exercisesClass.data.exercise.create[j]);
        await Future.delayed(Duration(milliseconds: 200));
        listKey.currentState.insertItem(j);
      }
    } else {
      showCustomDialog(
          context: context,
          title: ERROR,
          msg: INTERNET_CONNECTION,
          btnYesText: OK,
          onPressedBtnYes: () {
            Navigator.pop(context);
          });
      print("ExercisesScreen/error");
    }
  }

  Widget exercisesCard(
      List<Create> list, int index, Animation<double> animation) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizeTransition(
          sizeFactor: animation,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Container(
              color: WHITE,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PLAY_YOUTUBE_VIDEOS
                                    ? HowToExerciseYoutube(
                                        ex_id: list[index].id,
                                        name: list[index].name)
                                    : HowToExerciseMp4(
                                        ex_id: list[index].id,
                                        name: list[index].name)));
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                                color: BACK_GREY,
                                borderRadius: BorderRadius.circular(12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: HEIGHT * 0.20,
                                width: WIDTH * 0.20,
                                imageUrl:
                                    IMAGE_URL_MENU_ITEM + list[index].image ??
                                        " ",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container(),
                                errorWidget: (context, url, error) =>
                                    placeHolder(
                                  height: 65,
                                  width: 70,
                                  borderRadius: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customTextWidget.mediumText(
                                      text: list[index].name,
                                      size: 18,
                                      color: BLACK,
                                      textOverFlow: TextOverflow.ellipsis),
                                  SizedBox(height: 8),
                                  customTextWidget.mediumText(
                                      text: "X " +
                                              list[index]
                                                  .repeatCount
                                                  .toString() ??
                                          " ",
                                      color: LIGHT_GREY_TEXT,
                                      size: 14),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PLAY_YOUTUBE_VIDEOS
                                  ? HowToExerciseYoutube(
                                      ex_id: exercisesClass
                                          .data.exercise.create[index].id,
                                      name: exercisesClass
                                          .data.exercise.create[index].name)
                                  : HowToExerciseMp4(
                                      ex_id: exercisesClass
                                          .data.exercise.create[index].id,
                                      name: exercisesClass
                                          .data.exercise.create[index].name)));
                    },
                    child: Container(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Image.asset("assets/detail.png"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // DISPLAY_ADS && (index+1)%4    == 0 ? customAds.nativeAds(id: 0) : SizedBox(),
      ],
    );
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

  void createInterstitialAd() {
    _interstitialAd ??= InterstitialAd(
      adUnitId: INTERSTITIAL_AD_ID, //"ca-app-pub-1534623013393777/2381290914",
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          Navigator.pop(context);
          _interstitialAd.show();
          //ad.dispose();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) async {
          print('${ad.runtimeType} failed to load: $error.');
          await Future.delayed(Duration(seconds: 1));
          ad.dispose();
          Navigator.pop(context);
          _interstitialAd = null;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartExercise(
                      createList: exercisesClass.data.exercise.create,
                    )),
          );
          //createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StartExercise(
                      createList: exercisesClass.data.exercise.create,
                    )),
          );
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }
}
