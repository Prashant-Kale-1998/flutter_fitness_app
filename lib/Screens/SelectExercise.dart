import 'package:exercise_app/LocalDatabase/CustomWorkoutsClass.dart';
import 'package:exercise_app/Modals/AllWorkoutsClass.dart';

import 'package:exercise_app/Screens/CustomWorkouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AllText.dart';
import '../AllText.dart';
import '../CustomWidgets/CustomDialogues.dart';
import '../CustomWidgets/CustomTextWidget.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';
import '../Themes.dart';
import '../main.dart';

class SelectExercise extends StatefulWidget {
  List<CustomWorkoutCreateClass> list;
  String totaltime;
  String totalcalories;

  @override
  _SelectExerciseState createState() => _SelectExerciseState();

  SelectExercise( this.list,this.totaltime,this.totalcalories);
}

class _SelectExerciseState extends State<SelectExercise> {
  int repeat_index=4;
  int interval_index=4;
  TextEditingController namecontroller=TextEditingController();
  final RegExp formatter = new RegExp("[a-zA-Z]");
  final _formKey = GlobalKey<FormState>();
  CustomWorkoutsClass customWorkoutsClass=CustomWorkoutsClass();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(

        leading: Container(),
        toolbarHeight: 45,
        backgroundColor: WHITE,
        elevation: 0,
        flexibleSpace: customDialogues.header(text: "",context: context),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTextWidget.boldText(text: SELECT_EXERCISE,size: 33,color: BLACK),
                    SizedBox(height: 12,),
                    Container(
                      padding: EdgeInsets.fromLTRB(35, 30, 35, 30),
                      decoration: BoxDecoration(
                          color: PEACH,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              t.regularText(
                                text: "$SELECT_WORKOUTS_LIMIT",
                                size: 30,
                              ),
                              t.boldText(
                                  text:WORKOUTS,
                                  size: 12,
                                  color: ORANGE
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              t.regularText(
                                text: widget.totalcalories,
                                size: 30,
                              ),
                              t.boldText(
                                  text: CALORIES,
                                  size: 12,
                                  color: ORANGE
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              t.regularText(
                                text: widget.totaltime,
                                size: 30,
                              ),
                              t.boldText(
                                  text: MINUTES,
                                  size: 12,
                                  color: ORANGE
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    customTextWidget.boldText(text: WORKOUT_NAME,size: 20,color: BLACK),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: namecontroller,
                          keyboardType:TextInputType.name,
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), ],
                        validator: (value){
                          // print("runningg");

                          //if (!formatter.hasMatch(value)||value.isEmpty) {
                          if (value.isEmpty) {

                          return ENTER_WORKOUT_NAME[LANGUAGE_TYPE];
                          }
                          return null;
                        },
                        // onSaved: (value) {
                        //   namecontroller.text = value;
                        // },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          isCollapsed: true,
                          hintText: ENTER_CUSTOM_WORKOUT_NAME[LANGUAGE_TYPE],
                          hintStyle: TextStyle(
                            color: TAB_GREY_DARK,
                            fontFamily: 'Bold',
                            fontSize: 15
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: LIGHT_GREY_TEXT,
                              width: 0.5,
                            )
                          ),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: LIGHT_GREY_TEXT,
                                width: 0.5,
                              )
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: LIGHT_GREY_TEXT,
                                width: 0.5,
                              )
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: LIGHT_GREY_TEXT,
                                width: 0.5,
                              )
                          ),
                        ),

                        style: TextStyle(
                            color: LIGHT_GREY_TEXT,
                            fontFamily: 'Bold',
                            fontSize: 13
                        ),

                      ),
                    ),
                    SizedBox(height: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextWidget.boldText(text: REPEAT_WORKOUT,size: 20,color: BLACK),
                        SizedBox(height: 8,),
                        customTextWidget.boldText(text:SELECT_NO_OF_TIMES,size: 15,color:TAB_GREY_DARK),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics:NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index){
                            return Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      repeat_index=index;

                                    });
                                  },
                                  child: Container(
                                    child: Center(
                                      child: customTextWidget.regularText(text:   index==0?"1":index==1?"2":"3",size: 25,color: repeat_index!=index?BLUE:WHITE),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: repeat_index!=index?BLUE:WHITE,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),

                                        color: repeat_index==index?BLUE:WHITE
                                    ),
                                    width: MediaQuery.of(context).size.width/3.7,
                                  ),
                                ),
                                SizedBox(width: 15,),
                              ],
                            );
                          }),
                        )

                      ],
                    ),
                    SizedBox(height: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextWidget.boldText(text: INTERVAL_TIME,size: 20,color: BLACK),
                        SizedBox(height: 8,),
                        customTextWidget.boldText(text:CHOOSE_UR_INTERVAL_TIME,size: 15,color:TAB_GREY_DARK),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          child: ListView.builder(
                              itemCount: 3,

                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                               physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index){
                                return Row(
                                  children: [

                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          interval_index=index;
                                        });
                                      },
                                      child: Container(
                                        child: Center(
                                          child : customTextWidget.regularText(text:   index==0?"05":index==1?"10":"15",size: 25,color: interval_index!=index?BLUE:WHITE),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: interval_index!=index?BLUE:WHITE,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(10),

                                            color:interval_index==index?BLUE:WHITE
                                        ),
                                        width: MediaQuery.of(context).size.width/3.7,
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                  ],
                                );
                              }),
                        )

                      ],
                    ),
                    SizedBox(height: 15,),



                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){


              if(namecontroller.text.length==0){
                print("name empty");
                showCustomDialog(
                    context: context,
                    title: ERROR,
                    msg: ENTER_WORKOUT_NAME,
                    btnYesText: OK,
                    onPressedBtnYes: (){
                      Navigator.pop(context);
                    }

                );

              }
              else if(repeat_index==4){
                print("repeat count empty");
                showCustomDialog(
                    context: context,
                    title: ERROR,
                    msg: SELECT_REPEAT_COUNT,
                    btnYesText: OK,
                    onPressedBtnYes: (){
                      Navigator.pop(context);
                    }
                );
              }
              else if(interval_index==4){
                print("interval time empty");
                showCustomDialog(
                    context: context,
                    title: ERROR,
                    msg: SELECT_INTERVAL_NAME,
                    btnYesText: OK,
                    onPressedBtnYes: (){
                      Navigator.pop(context);
                    }
                );

              }
              else{


                if (_formKey.currentState.validate()) {
                  customWorkoutsClass.addData(
                      customWorkoutsClass: CustomWorkoutsClass.constructor(namecontroller.text,repeat_index==0?"1":repeat_index==1?"2":"3",interval_index==0?"5":interval_index==1?"10":"15",widget.totalcalories,widget.totaltime, widget.list)
                  );
                  print("added interval"+interval_index.toString());
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomWorkouts()));
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                else{
                   print(" validator error");
                }

              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 10, 16, 20),
              decoration: BoxDecoration(
                color: ORANGE,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                  child: t.mediumText(
                    text: ADD_WORKOUT,
                    color: WHITE,
                    size: 18
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }


}
