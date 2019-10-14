import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Text('用户'),
        ),
        body:Center(
          child: Text('用户页面'),
        )
    );
  }
}