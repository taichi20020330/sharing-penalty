import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';



class AddPenaltyModel extends ChangeNotifier{


  String? title;
  String? level;

   addPenalty() async{
    if(title == null || title == ""){
      throw '罰ゲーム名が入力されていません';
    }
    if(level == null || level == ""){
      throw '罰ゲームのレベルが入力されていません';
    }
    await FirebaseFirestore.instance.collection('penalties').add({
      'title': title, // John Doe
      'level': level, // Stokes and Sons
    });
  }
}