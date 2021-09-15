import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

ListView _EventListView(){
  return ListView.builder(
    itemCount: 2,
    itemBuilder: (BuildContext context, int index) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.account_circle,size: 40,),
              title: Text("Name creater Event"),
              subtitle: Text("Date of event"),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Name Event",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [Text("FullAmount"), Text("999")],
                ),
                Column(
                  children: [Text("Members"), Text("10")],
                ),
                Column(
                  children: [Text("Deadline"), Text("15.09.2020")],
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    iconSize: 25,
                    color: Theme.of(context).unselectedWidgetColor,
                    onPressed: () {}, icon: Icon(Icons.bookmark)

                ),
                IconButton(
                    iconSize: 25,
                    color: Theme.of(context).unselectedWidgetColor,
                    onPressed: () {}, icon: Icon(Icons.notifications)
                ),
                IconButton(
                    iconSize: 25,
                    color: Theme.of(context).unselectedWidgetColor,
                    onPressed: () {}, icon: Icon(Icons.reply)
                ),
              ],
            ),
          ],
        ),
      ),
    );
   },
  );
}
class HomePage extends StatefulWidget {
  const HomePage({Key ?key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.delegatePackingProperty;
  }
}

class _HomePageState extends State<HomePage> {
  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      body: _EventListView(),
    );
  }
}
