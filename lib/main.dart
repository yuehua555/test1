import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '斑头雁旅行',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      //home: BottomNavigationBars(), // 底部导航栏
      home: SplashScreen(), //app启动初始动画
    );
  }
}
