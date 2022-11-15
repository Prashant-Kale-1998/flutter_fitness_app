class HomeScreenClass {
  String success;
  List<Exercise> exercise;

  HomeScreenClass({this.success, this.exercise});

  HomeScreenClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['exercise'] != null) {
      exercise = new List<Exercise>();
      json['exercise'].forEach((v) {
        exercise.add(new Exercise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.exercise != null) {
      data['exercise'] = this.exercise.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exercise {
  String id;
  String name;
  String image;
  String totalExercise;
  int time;
  int calories;
  String level;
  String description;

  Exercise(
      {this.id,
        this.name,
        this.image,
        this.totalExercise,
        this.time,
        this.calories,
        this.level,
        this.description});

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    totalExercise = json['total_exercise'];
    time = json['time'];
    calories = json['calories'];
    level = json['level'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['total_exercise'] = this.totalExercise;
    data['time'] = this.time;
    data['calories'] = this.calories;
    data['level'] = this.level;
    data['description'] = this.description;
    return data;
  }
}
