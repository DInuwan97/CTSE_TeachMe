import 'package:flutter/material.dart';
import 'package:teachme/Widgets/BottomNavigationWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BootomNavigationWidget(),
      appBar:
          AppBar(title: Text('Home'), backgroundColor: Colors.greenAccent[400]),
    );
  }
}
