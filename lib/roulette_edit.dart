import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PenaltyListPage extends StatefulWidget {
  List<String> selected_penalties_title = [];
  PenaltyListPage(this.selected_penalties_title);
  @override
  _PenaltyListState createState() => _PenaltyListState();
}

class _PenaltyListState extends State<PenaltyListPage> {
  late TextEditingController myController;

  void _changePenaltyTitle(String penalty_title){
    setState(() {
      int index = widget.selected_penalties_title.indexOf(penalty_title);
      widget.selected_penalties_title[index] = myController.text;
    });
  }
  void _deletePenaltyTitle(String penalty_title){
    setState(() {
      widget.selected_penalties_title.remove(penalty_title);
    });
  }

  @override
  void initState() {
    super.initState();
    myController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> widgets= widget.selected_penalties_title
        .map(
          (penalty_title)=> Slidable(
        actionPane: const SlidableDrawerActionPane(),
        child: ListTile(
          trailing: const Icon(Icons.arrow_back),
          title: Text(penalty_title),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: '編集',
              color: Colors.black45,
              icon: Icons.edit,
              onTap: () async {
                InputDialog(context, penalty_title);
              }
          ),
          IconSlideAction(
              caption: '削除',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () async {
                await showConfirmDialog(context, penalty_title);
              }
          ),
        ],
      ),
    ).toList();
      return WillPopScope(
          onWillPop: () {
            Navigator.of(context).pop(widget.selected_penalties_title);
            return Future.value(false);
          },
        child: Scaffold(
          appBar: AppBar(
            title: const Text( '罰ゲームの編集'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (childContext) {
                      return SimpleDialog(
                        title: Text("Title"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                20))),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(childContext);
                            },
                            child: Text("・First Item"),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(childContext);
                            },
                            child: Text("・Second Item"),
                          ),
                        ],
                      );
                    },
                  );
                }
              )
            ],
          ),
            body: ListView(children: widgets),
        ),
      );
 // This trailing comma makes auto-formatting nicer for build methods.
  }
  Future showConfirmDialog(
      BuildContext context,
      String penalty_title,
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          content: Text("『${penalty_title}』を削除しますか？"),
          actions: [
            TextButton(
              child: const Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("はい"),
              onPressed: ()  {
                _deletePenaltyTitle(penalty_title);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('『${penalty_title}』を削除しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> InputDialog(BuildContext context, String penalty_title) async {
    myController = TextEditingController(text: penalty_title);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('罰ゲーム名の修正'),
            content: TextField(
              controller: myController,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('キャンセル'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  //OKを押したあとの処理
                  _changePenaltyTitle(penalty_title);
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('罰ゲーム名を編集しました'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ],
          );
        });
  }
}

