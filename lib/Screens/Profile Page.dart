import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key ?key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold
      (
      appBar: new AppBar(
        title: new Text('Профиль'),
      ),
      body: new Center(
        child: new Text('Профиль'),
      ),
    );
  }
}
