import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  String firstName;
  String lastName;
  String email;
  String subject;
  double rating;

  DocumentReference documentReference;

  Teacher(
      {this.firstName,
      this.lastName,
      this.email,
      this.subject,
      this.rating = 0});

  Teacher.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    firstName = map["firstName"];
    lastName = map["lastName"];
    email = map["email"];
    subject = map["subject"];
  }

  Teacher.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "subject": subject
    };
  }
}
