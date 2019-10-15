import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/user_screen.dart';

// 底部导航栏
class BottomNavigationBars extends StatefulWidget {
  @override
  _BottomNavigationBarsState createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {

  final _bottomNavigationColor = Colors.green; // 底部导航按钮的默认颜色
  int _currentIndex = 0; // 当前页面索引，默认为首页
  List<Widget> pagesList = List(); // 页面列表

  @override
  void initState() {
    //装载页面
    pagesList
    ..add(HomeScreen())
    ..add(UserScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pagesList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航按钮
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title:
              Text('斑头雁旅行', style: TextStyle(color: _bottomNavigationColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
                color: _bottomNavigationColor,
              ),
              title:
              Text('我的', style: TextStyle(color: _bottomNavigationColor)))
        ],
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );

  }
}
