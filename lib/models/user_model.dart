class UserModel{
  String? name;
  String? email;
  String? phone;
  String? password;
  String? id;
  List<String> favorites = [];


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.id,
    this.favorites = const []
  });

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    id = json['uId'];
    // favorites = json['favorites'].cast<String>();
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uId': id,
      'favorites': favorites
    };
  }
}