import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String teacherEmail;
  int rating;

  DocumentReference documentReference;

  Rating({this.teacherEmail, this.rating});

  Rating.fromMap(Map<String, dynamic> map, {this.documentReference}) {
    teacherEmail = map["teacherEmail"];
    rating = map["rating"];
  }

  Rating.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), documentReference: snapshot.reference);

  toJson() {
    return {"teacherEmail": teacherEmail, "rating": rating};
  }
}
