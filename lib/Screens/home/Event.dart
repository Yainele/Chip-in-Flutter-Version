

import 'package:chip_in_flutter_version/Screens/home/Member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

class Event  {
  
  final String Name;
  String Id;
  String Deadline;
  String CreditorName;
  num FullAmount;
  int MemberNumber;
  String HexColor;
  List<Member>Members;

  Event(
  this.Name, 
  this.Id, 
  this.Deadline,
  this.CreditorName,
  this.FullAmount,
  this.MemberNumber, 
  this.HexColor,
  this.Members);
  
  void setId(){
    Id="1";
    //установить id по дате
  }
  void setFullAmountAuto(){
    num amount = 0;
    Members.forEach((element) { amount+element.Credit;});
  }
}
class EventProvider with ChangeNotifier{
  //здесь будут операции с базой данных
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
  Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();
  

    

  }