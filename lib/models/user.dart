class User{
  String? name;
  String? email;
  String? password;
  String? phone;

  User({this.name, this.email, this.password, this.phone});
  User.fromMap(Map<String, dynamic> map){
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}