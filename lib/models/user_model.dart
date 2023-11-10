class UserModel{
  String? name;
  String? email;
  String? phone;
  String? password;
  String? id;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    id = json['uId'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'uId': id,
    };
  }
}