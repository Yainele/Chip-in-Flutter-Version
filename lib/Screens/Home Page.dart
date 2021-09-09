import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold
    (
      appBar: new AppBar(
        title: new Text('Главная'),
      ),
      body: new Center(
        child: new Text('Главная'),
      ),
    );
  }
}

