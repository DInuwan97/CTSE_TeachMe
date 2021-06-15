import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teachme/Models/Teacher.dart';
import 'package:teachme/Models/Rating.dart';

class FirebaseController {
  //declaring firebase collections
  final String fireStoreCollectionName = "Teachers";
  final String fireStoreCollectionNameRatings = "ratings";

  //get list of teachers
  getAllTeachers() {
    return FirebaseFirestore.instance
        .collection(fireStoreCollectionName)
        .snapshots();
  }

  //get down avarage retings
  Future<QuerySnapshot<Map<String, dynamic>>> getAllRatings() async {
    QuerySnapshot<Map<String, dynamic>> qs;

    try {
      qs = await FirebaseFirestore.instance
          .collection(fireStoreCollectionNameRatings)
          .get();
    } catch (e) {
      print('Ratings fetching error: ' + e.toString());
    }

    return qs;
  }

  //delete an exsisting teacher from the system
  deleteTeacher(Teacher teacher) {
    FirebaseFirestore.instance.runTransaction((transaction) {
      transaction.delete(teacher.documentReference);
    });
  }

  //adding a rate to a teacher
  addNewRate(String email, int starRating) async {
    Rating rating = new Rating(teacherEmail: email, rating: starRating);
    try {
      await FirebaseFirestore.instance
          .collection(fireStoreCollectionNameRatings)
          .doc()
          .set(rating.toJson());
    } catch (e) {
      print('Failed');
      print(e.toString());
    }
  }

  //add new teacher
  addNew(Teacher teacher) async {
    await FirebaseFirestore.instance
        .collection(fireStoreCollectionName)
        .doc()
        .set(teacher.toJson());
  }

  //update exsisting teacher details
  updateTeacher(Teacher teacher, String firstName, String lastName,
      String email, String subject) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      await transaction.update(teacher.documentReference, {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'subject': subject
      });
    });
  }
}
