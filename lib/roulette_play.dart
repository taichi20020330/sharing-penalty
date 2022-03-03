import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'domain/penalty_page.dart';

class RoulettePage extends StatefulWidget {
  RoulettePage(this.roulette_items,this.penalty_list);
  List<String> roulette_items;
  List<Penalty> penalty_list;

  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<RoulettePage> {
  StreamController<int> selected = StreamController<int>();
  bool isDone = false;
  final player = AudioCache();
  List<Penalty> selected_penalty_list = [];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backButtonPress(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('罰ゲームルーレット'),
        ),
        body: GestureDetector(
          onTap: () {
            if(isDone == false){
              setState(() {
                player.play('drumroll.mp3');
                selected.add(
                  Fortune.randomInt(0, widget.roulette_items.length),
                );
                isDone = true;
              });
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 350,
                  child: FortuneWheel(
                    animateFirst: false,
                    rotationCount: 100,
                    selected: selected.stream,
                    indicators: const <FortuneIndicator>[
                      FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: TriangleIndicator(
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                    items: [
                      for (var it in widget.roulette_items) FortuneItem(
                          child: Text(it),

                      ),
                    ],
                    onAnimationEnd: () {
                      player.play('drumroll_end.mp3');
                      print(selected.toString());
                    },
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            widget.penalty_list.forEach((penalty){
              selected_penalty_list.add(penalty);
            }
            );
          },
          label: const Text('保存する'),
          icon: const Icon(Icons.download),
        ),
      ),
    );
  }
  Future<bool> _backButtonPress(BuildContext context) async {
    bool? answer = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ルーレットが破棄されますがよろしいですか？'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('キャンセル')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('戻る')),
            ],
          );
        });

    return answer ?? false;
  }
}


