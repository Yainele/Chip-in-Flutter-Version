/*
import 'package:chip_in_flutter_version/Screens/home/Event.dart';
import 'package:chip_in_flutter_version/Screens/home/Member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

Container _EventListView(Event event) {
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
            leading: Icon(
              Icons.account_circle,
              size: 40,
            ),
            title: Text(event.CreditorName),
            subtitle: Text(event.Deadline),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              event.Name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Text("FullAmount"),
                  Text(event.FullAmount.toString())
                ],
              ),
              Column(
                children: [
                  Text("Members"),
                  Text(event.MemberNumber.toString())
                ],
              ),
              Column(
                children: [Text("Deadline"), Text(event.Deadline)],
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
                  //пометить как важное
                  iconSize: 25,
                  //color: Theme.of().unselectedWidgetColor,
                  onPressed: () {},
                  icon: Icon(Icons.bookmark)),
              IconButton(
                  //уведомить всех
                  iconSize: 25,
                  // color: Theme.of().unselectedWidgetColor,
                  onPressed: () {},
                  icon: Icon(Icons.notifications)),
              IconButton(
                  //поделиться
                  iconSize: 25,
                  // color: Theme.of(context).unselectedWidgetColor,
                  onPressed: () {
                    Share.share("список должников" + " скоро будет больше");
                  },
                  icon: Icon(Icons.reply)),
            ],
          ),
        ],
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.delegatePackingProperty;
  }
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  



  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection(getId()).snapshots(includeMetadataChanges: true);
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Event? event;
            event?.fromMap(data);
            return _EventListView(event!);
          }).toList(),
        );
      },
    );
  }
  String getId() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }
}
*/
