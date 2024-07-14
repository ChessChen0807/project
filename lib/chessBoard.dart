import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChessBoardPage extends StatefulWidget {
  @override
  _ChessBoardPageState createState() => _ChessBoardPageState();
}

class _ChessBoardPageState extends State<ChessBoardPage> {

  @override
  void initState(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: Column(
          children: [
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.fitHeight
              )
            )
          ]
        )
      )

    );
  }
}