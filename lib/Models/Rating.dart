import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String id;
  String teacherEmail;
  double rating;
  double totalRating;
  int noOfRatedTimes;

  DocumentReference documentReference;

  Rating(
      {this.teacherEmail,
      this.rating,
      this.id = '',
      this.noOfRatedTimes = 1,
      this.totalRating = 0});

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
