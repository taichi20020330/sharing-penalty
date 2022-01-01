import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharing_penalty/domain/penalty.dart';



class EditPenaltyModel extends ChangeNotifier{

  final Penalty penalty;
  EditPenaltyModel(this.penalty) {
    titleController.text = penalty.title;
    levelController.text = penalty.level;
  }
  final titleController = TextEditingController();
  final levelController = TextEditingController();

  String? title;
  String? level;

  void setTitle (String title){
    this.title = title;
    notifyListeners();
  }
  void setLevel (String level){
    this.level = level;
    notifyListeners();
  }

  bool isUpdate(){
    return title != null || level != null;
  }

  Future updatePenalty() async{
    this.title = titleController.text;
    this.level = levelController.text;    await FirebaseFirestore.instance.collection('penalties').doc(penalty.id).update({
      'title': title, // John Doe
      'level': level, // Stokes and Sons
    });
  }
}