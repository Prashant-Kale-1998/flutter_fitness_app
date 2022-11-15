// ignore_for_file: unrelated_type_equality_checks, valid_regexps

import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Modals/UserModal.dart';
import 'package:exercise_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Themes.dart';
import 'TabsScreen.dart';

class SetUpProfileScreen extends StatefulWidget {
  const SetUpProfileScreen({Key key}) : super(key: key);

  @override
  _SetUpProfileScreenState createState() => _SetUpProfileScreenState();
}

class _SetUpProfileScreenState extends State<SetUpProfileScreen> {
  int currentStep = 0;
  int selectedIntenseLevel = 0;
  int selectedTimesInWeek = 0;
  int selectedGender = 0;
  List<Widget> screens;
  UserModal userModal;
  List<IntenseCardModel> intenselyList = [
    IntenseCardModel(LOW[LANGUAGE_TYPE], LOW_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(
        MODERATE[LANGUAGE_TYPE], MODERATE_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(HIGH[LANGUAGE_TYPE], HIGH_EXPLANATION[LANGUAGE_TYPE]),
  ];
  List<IntenseCardModel> timesInWeekList = [
    IntenseCardModel(TWO_THREE_TIMES_IN_WEEK[LANGUAGE_TYPE],
        TWO_THREE_TIMES_IN_WEEK_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(FIVE_DAYS_IN_WEEK[LANGUAGE_TYPE],
        FIVE_DAYS_IN_WEEK_EXPLANATION[LANGUAGE_TYPE]),
    IntenseCardModel(ALL_SEVEN_DAYS[LANGUAGE_TYPE],
        ALL_SEVEN_DAYS_EXPLANATION[LANGUAGE_TYPE]),
  ];
  double WIDTH;
  ScrollController scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int currentAge = 14;
  double currentAgeScroller = 14;
  int currentHeight = 50;
  double currentHeightScroller = 50;
  CarouselController carouselControllerAge = CarouselController();
  CarouselController carouselControllerHeight = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WIDTH = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: LIGHT_GREY_SCREEN_BACKGROUND,
        appBar: AppBar(
          title: Center(
              child: Text(
            "Complete your profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
          toolbarHeight: 45,
          elevation: 0,
          backgroundColor: LIGHT_GREY_SCREEN_BACKGROUND,
          automaticallyImplyLeading: false,
        ),
        body: body(),
      ),
    );
  }

  body() {
    return WillPopScope(
      onWillPop: () async {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: List.generate(
                    7,
                    (index) => Expanded(
                            child: Container(
                          height: 6,
                          color: currentStep >= index
                              ? BLUE
                              : LIGHT_GREY_SCREEN_BACKGROUND,
                          margin:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                        ))),
              ),
            ),
            decoration: BoxDecoration(color: WHITE),
          ),
          Expanded(child: widgetToDisplay()),
          bottomButtons(),
        ],
      ),
    );
  }

  widgetToDisplay() {
    if (currentStep == 0) {
      return stepOne();
    } else if (currentStep == 1) {
      return stepTwo();
    } else if (currentStep == 2) {
      return stepFour();
    } else if (currentStep == 3) {
      return stepThree();
    } else if (currentStep == 4) {
      return stepFive();
    } else if (currentStep == 5) {
      return stepSix();
    } else if (currentStep == 6) {
      return stepSeven();
    }
  }

  Widget stepOne() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(
              text: WHATS_YOUR_NAME, color: BLACK, size: 25),
          SizedBox(
            height: 16,
          ),
          customTextWidget.mediumText(
              text:
                  ALTERNATIVELY_REFERED_TO_AS_AN_ACCOUNT_NAME_LOGIN_ID_NICK_NAME_AND_USER_ID_USERNAME_OR_USER_NAME_THE_NAME_GIVEN_TO_A_USER_ON,
              color: LIGHT_GREY_TEXT,
              size: 12),
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(text: USER_NAME, color: BLACK, size: 25),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: nameController,
              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), ],
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value.isEmpty) {
                  return THIS_NAME_FIELD_IS_REQUIRED[LANGUAGE_TYPE];
                }
                return null;
              },
              // onSaved: (value) {
              //   namecontroller.text = value;
              // },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                isCollapsed: true,
                hintText: YOUR_NAME_HERE[LANGUAGE_TYPE],
                hintStyle: TextStyle(
                    color: TAB_GREY_DARK, fontFamily: 'Bold', fontSize: 15),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
              ),

              style: TextStyle(
                  color: LIGHT_GREY_TEXT, fontFamily: 'Bold', fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget stepTwo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(
              text: WHATS_YOUR_CONTACT_NUMBER, color: BLACK, size: 25),
          SizedBox(
            height: 16,
          ),
          customTextWidget.mediumText(
              text: ALTERNATIVELY_REFERED_TO_AS_AN_MOBILE_NUMBER_,
              color: LIGHT_GREY_TEXT,
              size: 12),
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(
              text: MOBILE_NUMBER, color: BLACK, size: 25),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: phoneController,
              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[0-9]")), ],
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return THIS_FIELD_IS_REQUIRED[LANGUAGE_TYPE];
                } else if (value.length < 8) {
                  return VALID_MOBILE_NUMBER[LANGUAGE_TYPE];
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                isCollapsed: true,
                hintText: YOUR_MOBILE_NUMBER_HERE[LANGUAGE_TYPE],
                hintStyle: TextStyle(
                    color: TAB_GREY_DARK, fontFamily: 'Bold', fontSize: 15),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: LIGHT_GREY_TEXT,
                  width: 0.5,
                )),
              ),
              style: TextStyle(
                  color: LIGHT_GREY_TEXT, fontFamily: 'Bold', fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget stepThree() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            customTextWidget.boldText(
                text: HOW_INTENSIVELY_YOU_WORKOUT, color: BLACK, size: 25),
            SizedBox(
              height: 16,
            ),
            // customTextWidget.mediumText(
            //     text: YOUR_EXERCISE_INTENSITY_MUST_BE_AT_A,
            //     color: LIGHT_GREY_TEXT,
            //     size: 12),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  intenselyList.length,
                  (index) => intenseLevelCard(
                      title: intenselyList[index].title,
                      subTitle: intenselyList[index].subTitle,
                      index: index)),
            )
          ],
        ),
      ),
    );
  }

  intenseLevelCard({String title, String subTitle, int index}) => InkWell(
        onTap: () {
          setState(() {
            selectedIntenseLevel = index;
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectedIntenseLevel == index ? ORANGE : null,
              border: selectedIntenseLevel != index
                  ? Border.all(width: 2, color: BLUE)
                  : Border.all(color: Colors.transparent)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextWidget.boldText(
                  text: title,
                  color: selectedIntenseLevel == index ? WHITE : BLUE,
                  size: 20),
              SizedBox(
                height: 10,
              ),
              customTextWidget.mediumText(
                  text: subTitle,
                  color:
                      selectedIntenseLevel == index ? WHITE : LIGHT_GREY_TEXT,
                  size: 12),
            ],
          ),
        ),
      );

  Widget stepFour() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(
              text: WHATS_YOUR_GENDER, color: BLACK, size: 25),
          SizedBox(
            height: 16,
          ),
          customTextWidget.mediumText(
              text: GENDER_EXPLANATION, color: LIGHT_GREY_TEXT, size: 12),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 5,
                child: genderCard(
                    index: 0,
                    name: MALE[LANGUAGE_TYPE],
                    imagePath: "assets/splash/male@3x.png"),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 5,
                child: genderCard(
                    index: 1,
                    name: FEMALE[LANGUAGE_TYPE],
                    imagePath: "assets/splash/female@3x.png"),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    );
  }

  genderCard({String name, String imagePath, int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedGender = index;
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectedGender == index ? ORANGE : BACK_GREY,
              border: selectedGender != index
                  ? Border.all(color: ORANGE)
                  : Border.all(color: Colors.transparent),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(imagePath),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          customTextWidget.boldText(
              text: name, color: LIGHT_GREY_TEXT, size: 20)
        ],
      ),
    );
  }

  Widget stepFive() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(
              text: HOW_OLD_ARE_YOU, color: BLACK, size: 25),
          SizedBox(
            height: 16,
          ),
          // customTextWidget.mediumText(
          //     text: AGE_EXPLANATION, color: LIGHT_GREY_TEXT, size: 12),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 1,
                  options: CarouselOptions(
                    autoPlay: false,
                    scrollDirection: Axis.vertical,
                    enlargeCenterPage: true,
                    height: double.maxFinite,
                    viewportFraction: 0.14,
                    aspectRatio: 2,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    initialPage: 1,
                    pageSnapping: true,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: 90,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: BLUE),
                          color: (currentAgeScroller %
                                      currentAgeScroller.toInt()) ==
                                  0
                              ? BLUE
                              : Colors.transparent, // BLUE,
                        ),
                        child: Center(
                          child: customTextWidget.boldText(
                              text: itemIndex.toString(),
                              color: Colors.transparent,
                              size: 30),
                        )),
                  ),
                ),

                ///-----------------------

                CarouselSlider.builder(
                  itemCount: 100,
                  key: Key("ageSlider"),
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollDirection: Axis.vertical,
                      enlargeCenterPage: false,
                      height: double.maxFinite,
                      viewportFraction: 0.13,
                      aspectRatio: 1,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics(),
                      initialPage: currentAge,
                      pageSnapping: true,
                      onScrolled: (val) {
                        setState(() {
                          currentAge = val.toInt().floor();
                          currentAgeScroller = val;
                          print("CURRENT AGE : $currentHeight");
                        });
                      }),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: 80,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          //color: Colors.blue,
                        ),
                        child: Opacity(
                          opacity: indexToOpacity(itemIndex),
                          child: currentAgeScroller == itemIndex
                              ? Align(
                                  alignment: Alignment.center,
                                  child: customTextWidget.mediumText(
                                    text: (itemIndex + 1).toString(),
                                    color: WHITE,
                                    size: indexToSize(itemIndex),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: customTextWidget.boldText(
                                    text: (itemIndex + 1).toString(),
                                    color: LIGHT_GREY_TEXT,
                                    size: indexToSize(itemIndex),
                                  ),
                                ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  double indexToSize(int index) {
    if (index == currentAge) {
      return 35;
    } else if (index < currentAge) {
      return currentAge - index < 5 ? 30 - (currentAge - index) * 4.0 : 0.0;
    } else if (index > currentAge) {
      return index - currentAge < 5 ? 30 - (index - currentAge) * 4.0 : 0.0;
    } else {
      return 10;
    }
  }

  double indexToOpacity(int index) {
    if (index == currentAge) {
      return 1.0;
    } else if (index < currentAge) {
      return currentAge - index < 5 ? 1.0 - ((currentAge - index) / 5) : 0.0;
    } else if (index > currentAge) {
      return index - currentAge < 5 ? 1.0 - ((index - currentAge) / 5) : 0.0;
    } else {
      return 10;
    }
  }

  Widget stepSix() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          customTextWidget.boldText(
              text: WHAT_IS_YOUR_HEIGHT, color: BLACK, size: 25),
          SizedBox(
            height: 16,
          ),
          // customTextWidget.mediumText(
          //     text: HEIGHT_EXPLANATION, color: LIGHT_GREY_TEXT, size: 12),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 1,
                  options: CarouselOptions(
                    autoPlay: false,
                    scrollDirection: Axis.vertical,
                    enlargeCenterPage: true,
                    height: double.maxFinite,
                    viewportFraction: 0.14,
                    aspectRatio: 2,
                    enableInfiniteScroll: false,
                    scrollPhysics: BouncingScrollPhysics(),
                    initialPage: 1,
                    pageSnapping: true,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: 120,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: BLUE),
                          color: (currentHeightScroller %
                                      currentHeightScroller.toInt()) ==0
                              ? BLUE
                              : Colors.blue, // BLUE,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: customTextWidget.boldText(
                                  text: itemIndex.toString(),
                                  color: Colors.transparent,
                                  size: 30),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: customTextWidget.mediumText(
                                  text: CENTIMETERS,
                                  color: WHITE,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),

                ///-----------------------

                CarouselSlider.builder(
                  itemCount: 100,
                  //key: Key("heightSlider"),
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollDirection: Axis.vertical,
                      enlargeCenterPage: false,
                      height: double.maxFinite,
                      viewportFraction: 0.13,
                      aspectRatio: 1,
                      enableInfiniteScroll: false,
                      scrollPhysics: BouncingScrollPhysics(),
                      initialPage: currentHeight,
                      pageSnapping: true,
                      onScrolled: (val) {
                        setState(() {
                          currentHeight = val.toInt().floor();
                          currentHeightScroller = val;
                          print("CURRENT HEIGHT : $currentHeight");
                        });
                      }),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Center(
                    child: Container(
                        width: 80,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                         // color: Colors.blue,
                        ),
                        child: Opacity(
                          opacity: indexToOpacity6(itemIndex),
                          child: currentHeightScroller == itemIndex
                              ? Align(
                                  alignment: Alignment.center,
                                  child: customTextWidget.mediumText(
                                    text: (itemIndex + 120).toString(),
                                    color: WHITE,
                                    size: indexToSize6(itemIndex),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: customTextWidget.boldText(
                                    text: (itemIndex + 120).toString(),
                                    color: LIGHT_GREY_TEXT,
                                    size: indexToSize6(itemIndex),
                                  ),
                                ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  double indexToSize6(int index) {
    if (index == currentHeight) {
      return 35;
    } else if (index < currentHeight) {
      return currentHeight - index < 5
          ? 30 - (currentHeight - index) * 4.0
          : 0.0;
    } else if (index > currentHeight) {
      return index - currentHeight < 5
          ? 30 - (index - currentHeight) * 4.0
          : 0.0;
    } else {
      return 10;
    }
  }

  double indexToOpacity6(int index) {
    if (index == currentHeight) {
      return 1.0;
    } else if (index < currentHeight) {
      return currentHeight - index < 5
          ? 1.0 - ((currentHeight - index) / 5)
          : 0.0;
    } else if (index > currentHeight) {
      return index - currentHeight < 5
          ? 1.0 - ((index - currentHeight) / 5)
          : 0.0;
    } else {
      return 10;
    }
  }

  Widget stepSeven() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            customTextWidget.boldText(
                text: HOW_MANY_TIMES_IN_WEEK_YOU_EXERCISE,
                color: BLACK,
                size: 25),
            SizedBox(
              height: 16,
            ),
            customTextWidget.mediumText(
                text: HOW_MANY_TIMES_IN_WEEK_YOU_EXERCISE_EXPLANATION,
                color: LIGHT_GREY_TEXT,
                size: 12),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  timesInWeekList.length,
                  (index) => timesInWeekCard(
                      title: timesInWeekList[index].title,
                      subTitle: timesInWeekList[index].subTitle,
                      index: index)),
            )
          ],
        ),
      ),
    );
  }

  timesInWeekCard({String title, String subTitle, int index}) => InkWell(
        onTap: () {
          setState(() {
            selectedTimesInWeek = index;
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selectedTimesInWeek == index ? ORANGE : null,
              border: selectedTimesInWeek != index
                  ? Border.all(width: 2, color: BLUE)
                  : Border.all(color: Colors.transparent)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextWidget.boldText(
                  text: title,
                  color: selectedTimesInWeek == index ? WHITE : BLUE,
                  size: 20),
              SizedBox(
                height: 10,
              ),
              customTextWidget.mediumText(
                  text: subTitle,
                  color: selectedTimesInWeek == index ? WHITE : LIGHT_GREY_TEXT,
                  size: 11),
            ],
          ),
        ),
      );

  bottomButtons() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (currentStep < 6) {
                if (validateFields()) {
                  setState(() {
                    currentStep++;
                  });
                }
              } else {
                registerUser();
              }
            },
            child: currentStep == 6
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ORANGE,
                    ),
                    child: Center(
                      child: customTextWidget.mediumText(
                          text: SAVE, color: WHITE, size: 18),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ORANGE,
                    ),
                    child: Center(
                      child: customTextWidget.mediumText(
                          text: NEXT_STEP, color: WHITE, size: 18),
                    ),
                  ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep--;
                });
              } else {}
            },
            child: currentStep == 0
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: BLUE, width: 2)),
                    child: Center(
                      child: customTextWidget.boldText(
                          text: PREVIOUS_STEP, color: BLUE, size: 18),
                    ),
                  ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      );

  bool validateFields() {
    if (currentStep == 0) {
      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      return _formKey.currentState.validate();
    } else if (currentStep == 1) {
      return _formKey.currentState.validate();
    } else if (selectedGender != null) {
      return true;
    } else if (selectedIntenseLevel != null) {
      return true;
    } else {
      return true;
    }
  }

  registerUser() async {
    customDialogues.progressDialog(
        context: context, title: SAVING_INFO[LANGUAGE_TYPE]);
    var request = http.MultipartRequest(
        'POST', Uri.parse('$SERVER_ADDRESS/api/user_register.php'));
    request.fields.addAll({
      'name': nameController.text,
      'phone': phoneController.text,
      'gender': typeToGender(selectedGender),
      'workout_intensity': typeToIntensity(selectedIntenseLevel),
      'age': currentAge.toString(),
      'height': currentHeight.toString() + " " + CENTIMETERS[LANGUAGE_TYPE],
      'exercise_days': typeToDays(selectedTimesInWeek),
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(await response.stream.bytesToString());
      userModal = UserModal.fromJson(jsonResponse);
      if (userModal.data.success == "1") {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setBool("isUserRegistered", true);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TabsScreen()));
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String typeToGender(int selectedGender) {
    if (selectedGender == 0) {
      return "Male";
    } else if (selectedGender == 1) {
      return "Female";
    }
  }

  String typeToIntensity(int x) {
    if (x == 0) {
      return LOW[LANGUAGE_TYPE];
    } else if (x == 1) {
      return MODERATE[LANGUAGE_TYPE];
    } else {
      return HIGH[LANGUAGE_TYPE];
    }
  }

  String typeToDays(int x) {
    if (x == 0) {
      return TWO_THREE_TIMES_IN_WEEK[LANGUAGE_TYPE];
    } else if (x == 1) {
      return FIVE_DAYS_IN_WEEK[LANGUAGE_TYPE];
    } else {
      return ALL_SEVEN_DAYS[LANGUAGE_TYPE];
    }
  }
}

class IntenseCardModel {
  String title;
  String subTitle;

  IntenseCardModel(this.title, this.subTitle);
}

class GenderCardModel {
  String image;
  String text;

  GenderCardModel(this.image, this.text);
}
