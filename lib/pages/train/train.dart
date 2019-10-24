import 'package:flutter/material.dart';
import 'package:test1/main.dart';
import 'train_model.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lpinyin/lpinyin.dart';
import 'picker.dart';
import 'dart:convert';

class Train extends StatefulWidget {
  @override
  _TrainState createState() => _TrainState();
}

class _TrainState extends State<Train> {
  //省, 以 AdCode 为key，value是对应的 title
  Map<int, String> _metaTrainProvinces = Map<int, String>();

  //市，以省的AdCode为key，
  // value是一个Map<int, dynamic>，key是这个市的AdCode，
  // value是一个Map<String, String>，key包括name, title, K, value是相应的数据
  Map<int, dynamic> _metaTrainCities = Map<int, dynamic>();

  var l = List();

  @override
  void initState() {
    super.initState();
    //getTrainProvCtiy();
  }

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
            onPressed: () {
              //getTrainProvCtiy().whenComplete(() {
              /*
                CityPickers.showCityPicker(
                    context: context,
                    showType: ShowType.pca,
                    citiesData: _metaTrainCities,
                    provincesData: _metaTrainProvinces); */

              Picker(
                  adapter: DateTimePickerAdapter(),
                  changeToFirst: true,
                  hideHeader: false,
                  onConfirm: (Picker picker, List value) {
                    print(value.toString());
                    print(picker.adapter.text);
                  }).showModal(this.context);
              // });
            },
            child: Text('车站时刻表'),
          )
        ],
      ),
    );
  }

  ///城市选择器：https://github.com/hanxu317317/city_pickers
  ///得到火车站的省市名称，以及通过用户选择的省市在城市选择器的第三列显示查询到的车站名
  ///数据源构造格式参考 https://github.com/hanxu317317/city_pickers/blob/master/lib/meta/province.dart
  /// 以rest的方式得到原始数据，
  /// 并构造后赋值给 _metaTrainProvinces 和 _metaTrainCities
  Future getTrainProvCtiy() async {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://test001.btylx.com:6688/',
      connectTimeout: 5000,
      // 5s
      receiveTimeout: 100000,

      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        "api": "1.0.0",
        HttpHeaders.acceptEncodingHeader: 'gzip, deflate'
      },
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    ));

    Response response;
    response = await dio.post('api/TcgRegDef');
    //sleep(Duration(microseconds: 3000));
    if (response.statusCode == 200) {
      // 请求成功

      TrainData trainData = TrainData.fromJson(response.data);
      l = trainData.content;

      ///trainData.content 是所有省和城市的列表信息
      trainData.content.forEach((train) {
        _metaTrainProvinces[train.adCode] = train.title;

        Map<int, dynamic> secondCtiyMap = Map<int, dynamic>();
        train.downLines.forEach((secondCity) {
          secondCtiyMap[secondCity.adCode] = {
            'name': secondCity.name,
            'title': secondCity.title,
            'K': secondCity.k
          };
        });

        _metaTrainCities[train.adCode] = secondCtiyMap;
      });

      print(_metaTrainProvinces);

      _metaTrainCities.forEach((ctiyCode, item) {
        print(ctiyCode);
        print(item);
      });
      // print(_metaTrainCities);
    } else {
      print('请求失败，状态码为:' + response.statusCode.toString());
    }

    // return true;
  }
}

void main() {
  // _TrainState().getTrainProvCtiy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: Train(),
    );
  }
}

const PickerData = '''
[
    {
        "a": [
            {
                "a1": []
            },
            {
                "a2": [
                    5,
                    6,
                    7,
                    8
                ]
            },
            {
                "a3": [
                    9,
                    10,
                    11,
                    12
                ]
            }
        ]
    },
    {
        "b": [
            {
                "b1": [
                    11,
                    22,
                    33,
                    44
                ]
            },
            {
                "b2": [
                    55,
                    66,
                    77,
                    88
                ]
            },
            {
                "b3": [
                    99,
                    1010,
                    1111,
                    1212
                ]
            }
        ]
    },
    {
        "c": [
            {
                "c1": [
                    "a",
                    "b",
                    "c"
                ]
            },
            {
                "c2": [
                    "aa",
                    "bb",
                    "cc"
                ]
            },
            {
                "c3": [
                    "aaa",
                    "bbb",
                    "ccc"
                ]
            }
        ]
    }
]
    ''';
