class adduserModel{
  String name;
  String email;
  String password;

  adduserModel({
    required this.name,
    required this.email,
    required this.password,

});
  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }

  factory adduserModel.fromMap(Map<String, dynamic>Map){
    return adduserModel(
        name: Map["name"]as String,
        email: Map["email"]as String,
        password: Map["password"]as String
    );
  }
  adduserModel copyWith({
    String? id,
    String? name,
    String? uid,
  }){
    return adduserModel(
        name: id?? this.name,
        email: name?? this.email,
        password: uid?? this.password
    );
  }
}