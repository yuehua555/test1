import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';

class Train extends StatefulWidget {
  @override
  _TrainState createState() => _TrainState();
}

class _TrainState extends State<Train> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('铁路信息'),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(
            'asset/images/CRH.jpg',
            width: 500,
            height: 100,
          ),
          RaisedButton(
            onPressed: () => CityPickers.showCityPicker(
            context: context,
          ),
            child: Text('车站时刻表'),
          )
        ],
      ),
    );
  }
}
