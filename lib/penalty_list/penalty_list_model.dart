import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharing_penalty/domain/penalty.dart';



class PenaltyListModel extends ChangeNotifier{
  List<Penalty>? penalties ;

  void fetchPenaltyList() async{
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('penalties').get();
    final List<Penalty> penalties = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String level = data['level'];
      return Penalty(id, title, level);
    }).toList();
      this.penalties = penalties;
      notifyListeners();
  }
  Future deletePenalty(Penalty penalty) {
    return FirebaseFirestore.instance.collection('penalties').doc(penalty.id).delete();
  }

 }