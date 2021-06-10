import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:teachme/Widgets/StarRatingWidget.dart';
import 'package:teachme/Screens/UpdateTeacher.dart';
import 'package:teachme/Models/Teacher.dart';
import 'package:teachme/Models/Rating.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class TeacherList extends StatelessWidget {
  const TeacherList({Key key}) : super(key: key);

  final String fireStoreCollectionName = "Teachers";
  final String fireStoreCollectionNameRatings = "ratings";

  getAllTeachers() {
    return FirebaseFirestore.instance
        .collection(fireStoreCollectionName)
        .snapshots();
  }

  getAllRatings() {
    return FirebaseFirestore.instance
        .collection(fireStoreCollectionNameRatings)
        .snapshots();
  }

  deleteTeacher(Teacher teacher) {
    FirebaseFirestore.instance.runTransaction((transaction) {
      transaction.delete(teacher.documentReference);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    StarRatingWidgt start = new StarRatingWidgt();
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: getAllTeachers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildList(context, snapshot.data.docs);
              } else {
                return SplashScreen(
                    seconds: 5,
                    //navigateAfterSeconds: new AfterSplash(),
                    gradientBackground: LinearGradient(
                      colors: [
                        Colors.white12,
                        Colors.white24,
                        Colors.green[100]
                      ],
                    ),
                    styleTextUnderTheLoader: new TextStyle(),
                    loaderColor: Colors.red);
              }
            }));
  }

  _showRatingAppDialog(BuildContext context, String email) {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rating Dialog In Flutter',
      message: '',
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${context}');

        addNewRate(email, response.rating);

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          Container();
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  showStarRating() {
    var rating = 3.0;

    return Center(
        child: SmoothStarRating(
      rating: rating,
      isReadOnly: false,
      size: 80,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      spacing: 2.0,
      onRated: (value) {
        print("rating value -> $value");
        // print("rating value dd -> ${value.truncate()}");
      },
    ));
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
        children:
            snapshot.map((data) => listItemBuild(context, data)).toList());
  }

  Widget listItemBuild(BuildContext context, DocumentSnapshot data) {
    final teacher = Teacher.fromSnapshot(data);

    return Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
          height: 170.0,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60.0, 20.0, 20.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 130.0,
                      child: Text(
                        '${teacher.firstName}  ${teacher.lastName}',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        // Text('\LKR ${1500}',
                        //     style: TextStyle(
                        //         fontSize: 20.0,
                        //         fontWeight: FontWeight.w600)),
                        // Text('per pax',
                        //     style: TextStyle(color: Colors.grey))

                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 35,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateTeacher(teacher)),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Text('${teacher.subject}',
                    style: TextStyle(color: Colors.grey)),
                IconTheme(
                    data: IconThemeData(color: Colors.yellow[700], size: 18),
                    child: Row(
                        children: List.generate(5, (index) {
                      return Icon(index < 4 ? Icons.star : Icons.star_border);
                    }))),
                Row(
                  children: [
                    FlatButton(
                      onPressed: () {
                        _showRatingAppDialog(context, teacher.email);
                        //showStarRating();
                      },
                      child: Text('Rate Teacher'),
                      color: Colors.blue[400],
                      textColor: Colors.white,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        deleteConfirmation(context, teacher);
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.redAccent,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
      Positioned(
        left: 10.0,
        top: 15.0,
        bottom: 15.0,
        child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                  width: 90.0,
                  image: AssetImage('assets/teacher.png'),
                  fit: BoxFit.cover)),
        ),
      )
    ]);
  }

  deleteConfirmation(BuildContext context, Teacher teacher) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are You Sure?",
      desc:
          "${teacher.firstName} ${teacher.lastName} will be permenetly deleted from the system",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            deleteTeacher(teacher);
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
