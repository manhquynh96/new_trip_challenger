class UserModel {
  String name;
  String email;
  String height;
  String weight;
  String date;
  int gender;
  String id;
  int range;
  int minute;
  int kcal;

  UserModel({
    this.name,
    this.email,
    this.height,
    this.weight,
    this.date,
    this.gender,
    this.id,
    this.range,
    this.minute,
    this.kcal,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String,
        height = json['height'] as String,
        weight = json['weight'] as String,
        date = json['date'] as String,
        gender = json['gender'] as int,
        id = json['id'] as String,
        range = json['range'] as int,
        minute = json['minute'] as int,
        kcal = json['kcal'] as int;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['date'] = this.date;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['range'] = this.range;
    data['minute'] = this.minute;
    data['kcal'] = this.kcal;
    return data;
  }
}
