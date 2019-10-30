import 'package:flutter/material.dart';
import 'package:test1/pages/search_page.dart';
import './train/train.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('斑头雁旅行'),
      ),
      body: Column(
        children: <Widget>[
          //搜索按钮
          OutlineButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Text('搜索感兴趣的地方'),
            textColor: Colors.black,
            splashColor: Colors.green,
            highlightColor: Colors.black,
            shape: BeveledRectangleBorder(
              side: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            children: <Widget>[
              // 旅程智能规划，景点分类浏览行
              GestureDetector(
                child: Image.asset(
                  'asset/images/compass1.jpg',
                  width: 150,
                  height: 150,
                ),
                onTap: () => debugPrint('clicked'),
              ),

              Image.asset(
                'asset/images/mountain1.jpg',
                width: 150,
                height: 150,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              // 火车时刻查询，航班信息查询，经典路线浏览行
              GestureDetector(
                child: Image.asset(
                  'asset/images/train1.jpg',
                  width: 150,
                  height: 150,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Train()));
                },
              ),
              Image.asset(
                'asset/images/airport1.jpg',
                width: 100,
                height: 100,
              ),
              Image.asset(
                'asset/images/route.jpg',
                width: 100,
                height: 100,
              ),
            ],
          )
        ],
      ),
    );
    /*body: ListView(
          children: <Widget>[
            //搜索按钮
            OutlineButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              child: Text('搜索感兴趣的地方'),
              textColor: Colors.black,
              splashColor: Colors.green,
              highlightColor: Colors.black,
              shape: BeveledRectangleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // 旅程智能规划，景点分类浏览行
            GestureDetector(
              child: Image.asset(
                'asset/images/compass1.jpg',
                width: 150,
                height: 150,
              ),
              onTap: () => debugPrint('clicked'),
            ),

            Image.asset(
              'asset/images/mountain1.jpg',
              width: 150,
              height: 150,
            ),
            // 火车时刻查询，航班信息查询，经典路线浏览行
            Image.asset(
              'asset/images/train1.jpg',
              width: 150,
              height: 150,
            ),
            Image.asset(
              'asset/images/airport1.jpg',
              width: 150,
              height: 150,
            ),
            Image.asset(
              'asset/images/route.jpg',
              width: 150,
              height: 150,
            ),
          ],
        ));*/
  }
}
