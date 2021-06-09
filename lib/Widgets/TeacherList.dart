import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:teachme/Widgets/StarRatingWidget.dart';
import 'package:teachme/Screens/UpdateTeacher.dart';

class TeacherList extends StatelessWidget {
  const TeacherList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StarRatingWidgt start = new StarRatingWidgt();
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              //Activity activity = widget.destination.activities[index];

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
                      padding:
                          const EdgeInsets.fromLTRB(60.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 90.0,
                                child: Text(
                                  'Nuwan Kodagoda',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                            builder: (context) =>
                                                UpdateTeacher()),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                          Text('Tuorism', style: TextStyle(color: Colors.grey)),
                          IconTheme(
                              data: IconThemeData(
                                  color: Colors.yellow[700], size: 18),
                              child: Row(
                                  children: List.generate(5, (index) {
                                return Icon(
                                    index < 4 ? Icons.star : Icons.star_border);
                              }))),
                          Row(
                            children: [
                              FlatButton(
                                onPressed: () {
                                  _showRatingAppDialog(context);
                                },
                                child: Text('Rate Teacher'),
                                color: Colors.blue[400],
                                textColor: Colors.white,
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {},
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
            }));
  }

  _showRatingAppDialog(BuildContext context) {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: 'Rating Dialog In Flutter',
      message: '',
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${context}');

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
}
