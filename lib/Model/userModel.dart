class UserModel {
  String id;
  String name;
  String uid;

  UserModel({
    required this.id,
    required this.name,
    required this.uid
  });

  Map<String,dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "uid": uid,
    };
  }
  factory UserModel.fromMap(Map<String, dynamic>Map){
    return UserModel(
    id: Map["id"]as String,
    name: Map["name"]as String,
    uid: Map["uid"]as String
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? uid,
}){
    return UserModel(
        id: id?? this.id,
        name: name?? this.name,
        uid: uid?? this.uid
    );
  }


}
