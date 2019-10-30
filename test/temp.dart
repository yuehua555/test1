import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new CupertinoApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _devices = ['ppp'];
  var count = 0;
  var _height = 300.0;
  FixedExtentScrollController controller = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    print('build! ${_devices.length}');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: _height,
            child: CupertinoPicker.builder(
                itemExtent: 60.0,
                scrollController: controller,
                onSelectedItemChanged: (index) {
                  print(index);
                },
                itemBuilder: (context, index) {
                  print('itemBuilder');
                  return Center(
                    child: Text(
                      'item :' + _devices[index],
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                childCount: _devices.length),
          ),
          Container(
            height: 80,
            child: CupertinoPicker(
                itemExtent: 20,
                onSelectedItemChanged: (position) {
                  setState(() {
                    _devices.add("test " + count.toString());
                    count += 1;
                    _height = 300.01;
                  });
                  Timer(const Duration(milliseconds: 50), () {
                    if (mounted) {
                      setState(() {
                        _height = 300.0;
                      });
                    }
                  });
                },
                children: <Widget>[
                  Text('1'),
                  Text('2'),
                  Text('3'),
                ]),
          )
        ],
      ),
    );
  }
}
