import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:teachme/Models/Teacher.dart';

class UpdateTeacher extends StatefulWidget {
  final Teacher teacher;
  const UpdateTeacher(this.teacher, {Key key}) : super(key: key);

  @override
  _UpdateTeacherState createState() => _UpdateTeacherState();
}

class _UpdateTeacherState extends State<UpdateTeacher> {
  String dropdownValue = 'Combined Mathematics';
  final TextEditingController _controllerTeacherfName = TextEditingController();
  final TextEditingController _controllerTeacherlName = TextEditingController();
  final TextEditingController _controllerTeacherEmail = TextEditingController();
  final TextEditingController _controlllerTeacherSubject =
      TextEditingController();

  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isEditing;
  bool textFirldVisibility;

  String fireStoreCollectionName = "Teachers";
  Teacher currentTeacher;

  updateTeacher(Teacher teacher, String firstName, String lastName,
      String email, String subject) {
    try {
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.update(teacher.documentReference, {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'subject': subject
        });
      });
      successMessage();
    } catch (e) {
      print('Fail to update');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.teacher.firstName);

    setState(() {
      _controllerTeacherfName.text = widget.teacher.firstName;
      _controllerTeacherlName.text = widget.teacher.lastName;
      _controllerTeacherEmail.text = widget.teacher.email;
      dropdownValue = widget.teacher.subject;
    });

    return Scaffold(
        appBar: AppBar(
            title: Text('Update Details'),
            backgroundColor: Colors.greenAccent[400]),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 520,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      _entryFiedTeacherFname('First Name'),
                      _entryFiedTeacherLname('Last Name'),
                      _entryFiedTeacherEmail('Email'),
                      Align(
                          alignment: Alignment.topLeft,
                          child: _dropdownFieldSubject('Subject')),
                      _createButton(),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _entryFiedTeacherFname(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _controllerTeacherfName,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ))
        ],
      ),
    );
  }

  Widget _entryFiedTeacherLname(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _controllerTeacherlName,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ))
        ],
      ),
    );
  }

  Widget _entryFiedTeacherEmail(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _controllerTeacherEmail,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
              ))
        ],
      ),
    );
  }

  Widget _dropdownFieldSubject(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 56,
          isExpanded: true,
          style: const TextStyle(color: Colors.black87, fontSize: 17),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>[
            'Combined Mathematics',
            'Software Engineering',
            'Big Data Analysis',
            'Azure Kubernetes'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _createButton() {
    return InkWell(
      onTap: () {
        updateTeacher(
            currentTeacher,
            _controllerTeacherfName.text,
            _controllerTeacherlName.text,
            _controllerTeacherEmail.text,
            dropdownValue);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 35),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.greenAccent,
                  Colors.greenAccent[400],
                ])),
        child: Text(
          'Update Teacher',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  successMessage() {
    return Alert(
        context: context,
        title: "Successfully Updated",
        type: AlertType.success,
        content: Column(),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "CLOSE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
