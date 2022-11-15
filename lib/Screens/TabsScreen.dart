import 'package:exercise_app/AllText.dart';
import 'package:exercise_app/Themes.dart';
import 'package:flutter/material.dart';

import '../Modals/AllWorkoutsClass.dart';
import '../main.dart';
import 'AllWorkouts.dart';
import 'CustomWorkouts.dart';
import 'HomeScreen.dart';
import 'ProgressScreen.dart';
import 'Settings.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  List<Widget> screens = [
    HomeScreen(),
    ProgressScreen(),
    CustomWorkouts(),
    AllWorkouts(),
    Settings()
  ];

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: screens[index],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            //borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: ClipRRect(

            borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    index==0
                        ? "assets/bottom/home_active.png"
                        : "assets/bottom/home.png",
                     height: HEIGHT * 0.04,
                     width: WIDTH * 0.09,
                    fit: BoxFit.contain,
                  ),
                  label: HOME[LANGUAGE_TYPE],
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    index==1
                        ? "assets/bottom/progress_active.png"
                        : "assets/bottom/progress.png",
                    height: HEIGHT * 0.04,
                    width: WIDTH * 0.09,
                    fit: BoxFit.contain,
                  ),
                  label: PROGRESS[LANGUAGE_TYPE],
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    index==2
                        ? "assets/bottom/workout_active.png"
                        : "assets/bottom/workout.png",
                    height: HEIGHT * 0.04,
                    width: WIDTH * 0.13,
                    fit: BoxFit.contain,
                  ),
                  label: CUSTOM[LANGUAGE_TYPE],
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    index==3
                        ? "assets/bottom/custom_active.png"
                        : "assets/bottom/custom.png",
                    height: HEIGHT * 0.04,
                    width: WIDTH * 0.09,
                    fit: BoxFit.contain,
                  ),
                  label: EXERCISES[LANGUAGE_TYPE],
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    index==4
                        ? "assets/bottom/setting_active.png"
                        : "assets/bottom/setting.png",
                    height: HEIGHT * 0.04,
                    width: WIDTH * 0.09,
                    fit: BoxFit.contain,
                  ),
                  label: SETTING[LANGUAGE_TYPE],
                ),
              ],
              selectedLabelStyle:TextStyle(
                color: Colors.black,
                fontSize: 11,
                  fontFamily: "Bold"

              ),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: "Bold"
              ),
              unselectedItemColor: TAB_GREY_DARK,
              selectedItemColor: Colors.black,
              onTap: (i){
                setState(() {
                  index = i;
                });
              },
              currentIndex: index,
            ),
          ),
        ),
      ),
    );
  }

}



