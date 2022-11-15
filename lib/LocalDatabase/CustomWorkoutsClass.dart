import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:exercise_app/LocalDatabase/CustomWorkoutCreateClass.dart';

part 'CustomWorkoutsClass.g.dart';

@HiveType(typeId: 2)
class CustomWorkoutsClass{

  @HiveField(0)
  String name;
  @HiveField(1)
  String repeatCount;
  @HiveField(2)
  String intervalTime;
  @HiveField(3)
  String totalCalories;
  @HiveField(4)
  String totaltime;
  @HiveField(5)
  List<CustomWorkoutCreateClass> list = List();

  CustomWorkoutsClass();


  CustomWorkoutsClass.constructor(this.name, this.repeatCount, this.intervalTime,
      this.totalCalories, this.totaltime, this.list);

  addData({CustomWorkoutsClass customWorkoutsClass}) async {
    await Hive.openBox("CustomBox")
    .then((value){
      value.add(customWorkoutsClass);
      print("Data added successfully");
    });

  }

  Future<List<CustomWorkoutsClass>> readData() async{
    List<CustomWorkoutsClass> list=List();
    await Hive.openBox("CustomBox")
        .then((value){
          for(int i=0;i<value.length;i++){
            final data=value.getAt(i) as CustomWorkoutsClass;
            print("reading data "+data.list.toString());
            list.add(data);

          }

    });
    return list;
  }
}
