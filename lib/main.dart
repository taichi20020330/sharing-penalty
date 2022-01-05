//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sharing_penalty/roulette_1.dart';
import 'package:sharing_penalty/roulette_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = <String>[
    'Grogu',
    'Mace Windu',
    'Obi-Wan Kenobi',
    'Han Solo',
    'Luke Skywalker',
    'Darth Vader',
    'Yoda',
    'Ahsoka Tano',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('ルーレット1'),
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => RoulettePage_1()),
              );
              },
            ),
            ElevatedButton(
              child: const Text('ルーレット2'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RoulettePage_2(items)),
                );
              },
            ),
            const Text(
              'うおおおおおお',
            ),
          ],
        ),
      ),
    );
  }
}
