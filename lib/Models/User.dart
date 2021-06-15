import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String password;
  String role;

  DocumentReference documentReference;

  User({this.name, this.email, this.password, this.role});

  User.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    name = map["firstName"];
    email = map["email"];
    password = map["password"];
    role = map["role"];
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      "firstName": name,
      "email": email,
      "password": password,
      "role": role
    };
  }
}
