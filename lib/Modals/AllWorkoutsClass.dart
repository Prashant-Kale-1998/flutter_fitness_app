class AllWorkoutsClass {
  Data data;

  AllWorkoutsClass({this.data});

  AllWorkoutsClass.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String success;
  Exercise exercise;

  Data({this.success, this.exercise});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    exercise = json['exercise'] != null
        ? new Exercise.fromJson(json['exercise'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.exercise != null) {
      data['exercise'] = this.exercise.toJson();
    }
    return data;
  }
}

class Exercise {
  List<Create> create;
  List<Null> update;
  List<Null> delete;

  Exercise({this.create, this.update, this.delete});

  Exercise.fromJson(Map<String, dynamic> json) {
    if (json['create'] != null) {
      create = new List<Create>();
      json['create'].forEach((v) {
        create.add(new Create.fromJson(v));
      });
    }
    // if (json['update'] != null) {
    //   update = new List<Null>();
    //   json['update'].forEach((v) {
    //     update.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['delete'] != null) {
    //   delete = new List<Null>();
    //   json['delete'].forEach((v) {
    //     delete.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.create != null) {
      data['create'] = this.create.map((v) => v.toJson()).toList();
    }
    // if (this.update != null) {
    //   data['update'] = this.update.map((v) => v.toJson()).toList();
    // }
    // if (this.delete != null) {
    //   data['delete'] = this.delete.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Create {
  String id;
  String name;
  String image;
  String repeatCount;
  String url;
  String catName;
  String timee;
  String calories;
  Null gif;
  String createdAt;
  String updatedAt;
  String isDeleted;
  String deletedAt;
  String datetime;

  Create(
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

  Create.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    repeatCount = json['repeat_count'];
    url = json['url'];
    catName = json['cat_name'];
    timee = json['timee'];
    calories = json['calories'];
    gif = json['gif'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    deletedAt = json['deleted_at'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['repeat_count'] = this.repeatCount;
    data['url'] = this.url;
    data['cat_name'] = this.catName;
    data['timee'] = this.timee;
    data['calories'] = this.calories;
    data['gif'] = this.gif;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    data['deleted_at'] = this.deletedAt;
    data['datetime'] = this.datetime;
    return data;
  }
}
