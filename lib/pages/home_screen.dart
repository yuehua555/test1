import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('主页'),
        ),
        body:Center(
          child: Text('主页面'),
        )
    );
  }
}