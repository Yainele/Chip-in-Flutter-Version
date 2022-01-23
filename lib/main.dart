import 'package:chip_in_flutter_version/Screens/Event/NewEventPage.dart';
import 'package:chip_in_flutter_version/Screens/auth/authentification.dart';
import 'package:chip_in_flutter_version/Screens/home/Home%20Page.dart';
import 'package:chip_in_flutter_version/Screens/profile/Profile%20Page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp
    (
ChipIn()
    );

}

class ChipIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      home: MyBottomNavigationBar(),

    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key ?key}) : super(key: key);
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  List<Widget> _children =
  [
    HomePage(),
    NewEventPage(),
    ProfilePage(),
  ];
  void onTappedBar(int index)
  {
    setState(() {
    _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem
            (
              icon: new Icon(Icons.home),
              title: new Text('Главная')
            ),
          BottomNavigationBarItem
            (
              icon: new Icon(Icons.add),
              title: new Text('Запись')
          ),
          BottomNavigationBarItem
            (
              icon: new Icon(Icons.account_circle),
              title: new Text('Вы')
          ),
        ],
      ),
    );
  }
}



