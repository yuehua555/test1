import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'all_trains_on_station_model.dart';
import 'dart:convert';

class AllTrains extends StatefulWidget {
  @override
  _AllTrainsState createState() => _AllTrainsState();
}

class _AllTrainsState extends State<AllTrains> {

  Future<String> _loadAStudentAsset()  {
    return  rootBundle.loadString('asset/example_station_data.json');
  }

  var temp;
  var str;

  @override
  void initState() {
    super.initState();
    //TrainData trainData = TrainData.fromJson(jsonResponse);
    temp = _loadAStudentAsset().then((value){
      String jsonString =  value;
      final jsonResponse = json.decode(jsonString);

      AllTrainsOnStation trainsData = AllTrainsOnStation.fromJson(jsonResponse);
      print(trainsData.content);
    });
    print(temp);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Text('1'),
          Text('2'),
          Text('3')
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      home: AllTrains(),
    );
  }
}
