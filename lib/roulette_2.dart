import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';


/*void main() {
  runApp(RoulettePage_2(this.items));
}*/

class RoulettePage_2 extends StatelessWidget {
  RoulettePage_2(this.items);
  var items = <String>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(this.items),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.rouletteItems);
  List rouletteItems;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamController<int> selected = StreamController<int>();


  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Fortune Wheel'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected.add(
              Fortune.randomInt(0, widget.rouletteItems.length),
            );
          });
        },
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                rotationCount: 10,
                selected: selected.stream,
                indicators: const <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.centerRight,
                    child: TriangleIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ],
                items: [
                  for (var it in widget.rouletteItems) FortuneItem(
                      child: Text(it),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
