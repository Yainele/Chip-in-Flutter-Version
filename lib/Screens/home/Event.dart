

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'package:chip_in_flutter_version/Screens/home/Member.dart';

class Event {
  
  String? Name;
  String? Id;
  String? Deadline;
  String? CreditorName;
  num? FullAmount;
  int? MemberNumber;
  String? HexColor;
  List<Member>?Members;

  
  
  void setId(){
    Id="1";
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


  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'Id': Id,
      'Deadline': Deadline,
      'CreditorName': CreditorName,
      'FullAmount': FullAmount,
      'MemberNumber': MemberNumber,
      'HexColor': HexColor,
    };
  }

 
 

 
}
class EventProvider with ChangeNotifier{
  //здесь будут операции с базой данных

  getDataFromFirebase(){
    FirebaseFirestore userID = FirebaseFirestore.instance;
    List<Event>? Events = [];
    
    FirebaseFirestore.instance
    .collection(userID.toString())
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["first_name"]);
            
        });
    });

  }
  

    

  }