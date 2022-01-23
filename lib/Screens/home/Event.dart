

import 'package:chip_in_flutter_version/Screens/home/Member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

class Event  {
  
  final String Name;
  String Id;
  String Deadline;
  String CreditorName;
  num FullAmount;
  int MemberNumber;
  List<Member>?Members;

  Event(
  this.Name, 
  this.Id,
  this.Deadline,
  this.CreditorName,
  this.FullAmount,
  this.MemberNumber, 
  this.Members);
  
  void setId(){
    var uuid = Uuid();
    Id = uuid.v1();
    //установить id по дате
  }
  void setFullAmountAuto(){
    num amount = 0;
    Members!.forEach((element) { amount+element.Credit;});
  }
  void setAmountForAll(){//устанавливает для всех одинаковую сумму долга
    
    double Amount = 0.0;
    Amount = FullAmount/Members!.length;
    for (var member in Members! ){
      member.Credit = Amount;
    }
  }
}
class EventProvider with ChangeNotifier{
  //здесь будут операции с базой данных
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
  Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();
  
  

    

  }