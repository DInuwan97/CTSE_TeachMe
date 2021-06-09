import 'package:flutter/material.dart';
import 'package:teachme/Widgets/TeacherList.dart';

class TeacherListScreen extends StatefulWidget {
  const TeacherListScreen({Key key}) : super(key: key);

  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TeacherList());
  }
}
