import 'package:flutter/material.dart';
import 'bottom_Navigation_Bars.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '斑头雁旅行',
      theme: ThemeData.light(),
      home: BottomNavigationBars(), // 底部导航栏
    );
  }
}
