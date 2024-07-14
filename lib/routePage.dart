import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/chessBoard.dart';
import 'package:project/trending.dart';

import 'httpRequest.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _selectedIndex = 0;
  static List<Widget> _pageOptions = [];

  @override
  void initState() {
    super.initState();

    _pageOptions = [
      TrendingPage(),
      HttpPage(),
      ChessBoardPage(),
    ];
  }

  void _changePage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_play),
              label: 'Play Chess'),
        ],
        currentIndex: _selectedIndex,
        onTap: _changePage,
      ),
    );
  }
}
