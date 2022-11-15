
import 'package:hive/hive.dart';
part 'CustomWorkoutCreateClass.g.dart';

@HiveType(typeId: 3)
class CustomWorkoutCreateClass{
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image;
  @HiveField(3)
  String repeatCount;
  @HiveField(4)
  String url;
  @HiveField(5)
  String catName;
  @HiveField(6)
  String timee;
  @HiveField(7)
  String calories;
  @HiveField(8)
  String gif;
  @HiveField(9)
  String createdAt;
  @HiveField(10)
  String updatedAt;
  @HiveField(11)
  String isDeleted;
  @HiveField(12)
  String deletedAt;
  @HiveField(13)
  String datetime;

  CustomWorkoutCreateClass(
      {this.id,
        this.name,
        this.image,
        this.repeatCount,
        this.url,
        this.catName,
        this.timee,
        this.calories,
        this.gif,
        this.createdAt,
        this.updatedAt,
        this.isDeleted,
        this.deletedAt,
        this.datetime});




}