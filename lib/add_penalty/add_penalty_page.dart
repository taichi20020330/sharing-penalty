import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharing_penalty/add_penalty/add_penalty_model.dart';

class AddPenaltyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPenaltyModel>(
      create: (_) => AddPenaltyModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text( '罰ゲームの追加'),
        ),
        body: Center(
          child: Consumer<AddPenaltyModel>(builder: (context, model, child) {
            return Column(children:[
              TextField(
                decoration: InputDecoration(
                  hintText: '罰ゲーム名',
                ),
                onChanged: (text) {
                  model.title = text;
                },
              ),
              SizedBox(height:8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'レベル',
                ),
                onChanged: (text) {
                  model.level = text;
                },
              ),
              SizedBox(height:16,),
              ElevatedButton(onPressed: () async{
                //追加の処理
                try{
                  await model.addPenalty();
                  Navigator.of(context).pop(true);

                }catch(e){
                  final snackBar= SnackBar(
                    content:Text(e.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }, child: Text('追加する')),
            ],);
          }),
        ),
      ),
    );
  }
}