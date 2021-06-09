import 'package:flutter/material.dart';
import 'package:teachme/Screens/AddTeacher.dart';
import 'package:teachme/Screens/Home.dart';
import 'package:teachme/Screens/TeacherListScreen.dart';

class BootomNavigationWidget extends StatefulWidget {
  @override
  BootomNavigationWidget({Key key}) : super(key: key);
  _BootomNavigationWidgetState createState() => _BootomNavigationWidgetState();
}

class _BootomNavigationWidgetState extends State<BootomNavigationWidget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Home(key: PageStorageKey('Page1')),
    AddTeacher(key: PageStorageKey('Page2')),
    TeacherListScreen(key: PageStorageKey('Page3')),
    Home(key: PageStorageKey('Page4'))
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.greenAccent[400],
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add_sharp),
            label: 'Add New',
            backgroundColor: Colors.greenAccent[400],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Teachers',
            backgroundColor: Colors.greenAccent[400],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.greenAccent[400],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
