import 'dart:math';

import 'package:flutter/material.dart';
import 'train_model.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lpinyin/lpinyin.dart';
import 'picker.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_picker/flutter_picker.dart';
import 'station_model.dart';

class Train extends StatefulWidget {
  @override
  _TrainState createState() => _TrainState();
}

class _TrainState extends State<Train> {
  //省, 是一个数组，数组元素是Map<int, String>
  // 以 AdCode 为key，value是对应的 title
  List<Map<int, String>> _metaTrainProvinces;

  //市，以省的AdCode为key，
  // value是一个Map<int, dynamic>，key是这个市的AdCode，
  // value是一个Map<String, String>，key包括name, title, K, value是相应的数据
  Map<int, dynamic> _metaTrainCities;

  // 第二列的城市显示数组
  // 以第一列省的AdCode作为查询条件，在_metaTrainCities中查出相对应的城市组成一个
  // Map数组，key 就是 K，value 是 title
  List<Map<String, String>> _secondCities;

  // 第三列火车站名，通过市的RegionK 得到，是一个数组，数组元素是Map<String, String>
  // key 是 K ，value 是 name
  List<Map<String, String>> _railwayStations;

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
            child: Text('车站时刻表'),
            onPressed: () {
              //getTrainProvCtiy().whenComplete(() {
              /*
                CityPickers.showCityPicker(
                    context: context,
                    showType: ShowType.pca,
                    citiesData: _metaTrainCities,
                    provincesData: _metaTrainProvinces); */
/*
              Picker(
                  //adapter: CustomTrainStationPickerAdapter(),
                  adapter: DateTimePickerAdapter(),
                  changeToFirst: true,
                  hideHeader: false,
                  onConfirm: (Picker picker, List value) {
                    print(value.toString());
                    print(picker.adapter.text);
                  }).showModal(this.context);
              // });
              */
              getTrainProvCtiy().whenComplete(() {
                Widget provincePicker;
                Widget cityPicker;
                Widget stationPicker;

                List<Widget> currentCities;
                List<Widget> currentStations;
                FixedExtentScrollController provinceController =
                    FixedExtentScrollController();
                FixedExtentScrollController cityController =
                    FixedExtentScrollController();
                FixedExtentScrollController stationController =
                    FixedExtentScrollController();

                List<Widget> _buildProvinceViews() {
                  List<Widget> items = [];
                  for (int i = 0; i < _metaTrainProvinces.length; i++) {
                    String _text = _metaTrainProvinces[i].values.toString();
                    items.add(Text('$_text'));
                  }
                  return items;
                }

                List<Widget> _buildCityViews(int code) {
                  List<Widget> items = [];
                  getSecondCities(code);
                  for (int i = 0; i < _secondCities.length; i++) {
                    String _text = _secondCities[i].values.toString();
                    items.add(Text('$_text'));
                  }
                  return items;
                }

                currentCities =
                    _buildCityViews(_metaTrainProvinces[0].keys.first);

                List<Widget> _buildStaionViews(String k) {
                  List<Widget> items = [];
                  getTrainStationFromC(k);
                  String _text;
                  if (_railwayStations == null) {
                    items.add(Text('无'));
                    return items;
                  } else {
                    for (int i = 0; i < _railwayStations.length; i++) {
                      String _text = _railwayStations[i].values.toString();
                      items.add(Text('$_text'));
                    }
                    return items;
                  }
                }

                currentStations =
                    _buildStaionViews(_secondCities[0].keys.first);

                provincePicker = CupertinoPicker(
                    itemExtent: 20,
                    onSelectedItemChanged: (position) {
                      print('The position is $position');
                      // 如果省有变化，则需修改第二列市，以及通过第二列修改第三列
                      setState(() {
                        //cityController.jumpTo(0);
                        //cityController.selectedItem = 0;
                        cityController.position.notifyListeners();
                        currentCities.add(Text('test'));
                        cityController.jumpTo(0);
                        currentStations.clear();
                        currentStations.add(Text('test'));
                        print(currentCities);
                      });
                    },
                    children: _buildProvinceViews());

                cityPicker = CupertinoPicker(
                    itemExtent: 20,
                    scrollController: cityController,
                    onSelectedItemChanged: (position) {
                      print('The position is $position');
                    },
                    children: currentCities);

                stationPicker = CupertinoPicker(
                    itemExtent: 20,
                    scrollController: stationController,
                    onSelectedItemChanged: (position) {
                      print('The position is $position');
                    },
                    children: currentStations);

                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          setState((){});
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 20,
                                child: Row(children: <Widget>[
                                  FlatButton(
                                      onPressed: null,
                                      child: Text("取消"),
                                      color: Colors.blue,
                                      textColor: Colors.black),
                                  FlatButton(
                                      onPressed: null,
                                      child: Text("确定"),
                                      color: Colors.blue,
                                      textColor: Colors.black),
                                ]),
                              ),
                              Container(
                                height: 300,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: provincePicker,
                                    ),
                                    Expanded(
                                      child: cityPicker,
                                    ),
                                    Expanded(
                                      child: stationPicker,
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }).then((val) {
                  // 打印 点击返回的数据
                  print(val);
                });
              });
            },
          )
        ],
      ),
    );
  }

  /// 以rest的方式得到原始数据，
  /// https://test001.btylx.com:6688/api/TcgRegDef  POST
  /// 得到火车站的省市名称.并构造后赋值给 _metaTrainProvinces 和 _metaTrainCities
  Future getTrainProvCtiy() async {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://test001.btylx.com:6688/',
      connectTimeout: 5000,
      // 5s
      receiveTimeout: 10000,

      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        "api": "1.0.0",
        HttpHeaders.acceptEncodingHeader: 'gzip, deflate'
      },
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    ));

    // dio.interceptors.add(LogInterceptor(responseBody: true));

    Response response;
    response = await dio.post('api/TcgRegDef');
    //sleep(Duration(microseconds: 3000));
    if (response.statusCode == 200) {
      // 请求成功

      TrainData trainData = TrainData.fromJson(response.data);
      _metaTrainProvinces = List();
      _metaTrainCities = Map<int, dynamic>();

      ///trainData.content 是所有省和城市的列表信息
      trainData.content.forEach((train) {
        _metaTrainProvinces.add({train.adCode: train.title});

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

      // 对省的数组按照省的AdCode就是键进行比较排序
      _metaTrainProvinces.sort((a, b) => a.keys.first.compareTo(b.keys.first));
      print(_metaTrainProvinces);

      /*
      _metaTrainCities.forEach((ctiyCode, item) {
        print(ctiyCode);
        print(item.runtimeType);
      });*/
      //print(_metaTrainCities[640000]);

    } else {
      print('请求失败，状态码为:' + response.statusCode.toString());
    }

    // return true;
  }

  /// 通过用户选择的市K值在选择器的第三列显示查询到的车站名
  /// 调用Rest API
  /// https://test001.btylx.com:6688/railwayStation?regionK=$K  GET
  /// 得到原始数据，构造后赋值给_railwayStations
  Future getTrainStationFromC(String K) async {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://test001.btylx.com:6688/',
      connectTimeout: 5000,
      // 5s
      receiveTimeout: 5000,

      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        "api": "1.0.0",
        HttpHeaders.acceptEncodingHeader: 'gzip, deflate'
      },
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    ));

    //dio.interceptors.add(LogInterceptor(responseBody: true));

    Response response;
    response = await dio.get('railwayStation?regionK=$K');
    _railwayStations = List();
    if (response.statusCode == 200) {
      // 请求成功
      print(response.data);

      //如果 Content 为空说明没有车站，不需要解析
      if ((response.data)['Content'] != null) {
        StationsData stationsData = StationsData.fromJson(response.data);
        stationsData.content.forEach((Stations stations) {
          _railwayStations.add({stations.site.k: stations.site.name});
        });
        print(_railwayStations);
      }
    } else {
      print('请求失败，状态码为:' + response.statusCode.toString());
    }

    //print('provinces: ' + _metaTrainProvinces.toString());
    //print('cities: ' + _secondCities.toString());
    print('stations:' + _railwayStations.toString());
  }

  ///根据省的 Adcode 构造第二列城市数组
  List<Map<String, String>> getSecondCities(int adCode) {
    Map<int, dynamic> cities = _metaTrainCities[adCode];
    _secondCities = List();
    cities.forEach((code, city) {
      //print(code);
      //print(city);
      Map<String, String> item = city;
      _secondCities.add({item['K']: item['title']});
    });
    print(_secondCities);
  }
}

class pickers extends StatefulWidget {
  pickers({Key, key}) : super(key: key);

  @override
  _pickersState createState() => _pickersState();
}

class _pickersState extends State<pickers> {
  //省, 是一个数组，数组元素是Map<int, String>
  // 以 AdCode 为key，value是对应的 title
  List<Map<int, String>> _metaTrainProvinces;

  //市，以省的AdCode为key，
  // value是一个Map<int, dynamic>，key是这个市的AdCode，
  // value是一个Map<String, String>，key包括name, title, K, value是相应的数据
  Map<int, dynamic> _metaTrainCities;

  // 第二列的城市显示数组
  // 以第一列省的AdCode作为查询条件，在_metaTrainCities中查出相对应的城市组成一个
  // Map数组，key 就是 K，value 是 title
  List<Map<String, String>> _secondCities;

  // 第三列火车站名，通过市的RegionK 得到，是一个数组，数组元素是Map<String, String>
  // key 是 K ，value 是 name
  List<Map<String, String>> _railwayStations;

  Widget provincePicker;
  Widget cityPicker;
  Widget stationPicker;

  List<Widget> currentCities;
  List<Widget> currentStations;
  FixedExtentScrollController provinceController =
      FixedExtentScrollController();
  FixedExtentScrollController cityController = FixedExtentScrollController();
  FixedExtentScrollController stationController = FixedExtentScrollController();

  /// 以rest的方式得到原始数据，
  /// https://test001.btylx.com:6688/api/TcgRegDef  POST
  /// 得到火车站的省市名称.并构造后赋值给 _metaTrainProvinces 和 _metaTrainCities
  Future getTrainProvCtiy() async {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://test001.btylx.com:6688/',
      connectTimeout: 5000,
      // 5s
      receiveTimeout: 10000,

      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        "api": "1.0.0",
        HttpHeaders.acceptEncodingHeader: 'gzip, deflate'
      },
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    ));

    // dio.interceptors.add(LogInterceptor(responseBody: true));

    Response response;
    response = await dio.post('api/TcgRegDef');
    //sleep(Duration(microseconds: 3000));
    if (response.statusCode == 200) {
      // 请求成功

      TrainData trainData = TrainData.fromJson(response.data);
      _metaTrainProvinces = List();
      _metaTrainCities = Map<int, dynamic>();

      ///trainData.content 是所有省和城市的列表信息
      trainData.content.forEach((train) {
        _metaTrainProvinces.add({train.adCode: train.title});

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

      // 对省的数组按照省的AdCode就是键进行比较排序
      _metaTrainProvinces.sort((a, b) => a.keys.first.compareTo(b.keys.first));
      print(_metaTrainProvinces);

      /*
      _metaTrainCities.forEach((ctiyCode, item) {
        print(ctiyCode);
        print(item.runtimeType);
      });*/
      //print(_metaTrainCities[640000]);

    } else {
      print('请求失败，状态码为:' + response.statusCode.toString());
    }

    // return true;
  }

  /// 通过用户选择的市K值在选择器的第三列显示查询到的车站名
  /// 调用Rest API
  /// https://test001.btylx.com:6688/railwayStation?regionK=$K  GET
  /// 得到原始数据，构造后赋值给_railwayStations
  Future getTrainStationFromC(String K) async {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://test001.btylx.com:6688/',
      connectTimeout: 5000,
      // 5s
      receiveTimeout: 5000,

      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        "api": "1.0.0",
        HttpHeaders.acceptEncodingHeader: 'gzip, deflate'
      },
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.json,
    ));

    //dio.interceptors.add(LogInterceptor(responseBody: true));

    Response response;
    response = await dio.get('railwayStation?regionK=$K');
    _railwayStations = List();
    if (response.statusCode == 200) {
      // 请求成功
      print(response.data);

      //如果 Content 为空说明没有车站，不需要解析
      if ((response.data)['Content'] != null) {
        StationsData stationsData = StationsData.fromJson(response.data);
        stationsData.content.forEach((Stations stations) {
          _railwayStations.add({stations.site.k: stations.site.name});
        });
        print(_railwayStations);
      }
    } else {
      print('请求失败，状态码为:' + response.statusCode.toString());
    }

    //print('provinces: ' + _metaTrainProvinces.toString());
    //print('cities: ' + _secondCities.toString());
    print('stations:' + _railwayStations.toString());
  }

  ///根据省的 Adcode 构造第二列城市数组
  List<Map<String, String>> getSecondCities(int adCode) {
    Map<int, dynamic> cities = _metaTrainCities[adCode];
    _secondCities = List();
    cities.forEach((code, city) {
      //print(code);
      //print(city);
      Map<String, String> item = city;
      _secondCities.add({item['K']: item['title']});
    });
    print(_secondCities);
  }

  @override
  void initState() {
    super.initState();
    getTrainProvCtiy().whenComplete(() {
      List<Widget> _buildProvinceViews() {
        List<Widget> items = [];
        for (int i = 0; i < _metaTrainProvinces.length; i++) {
          String _text = _metaTrainProvinces[i].values.toString();
          items.add(Text('$_text'));
        }
        return items;
      }

      List<Widget> _buildCityViews(int code) {
        List<Widget> items = [];
        getSecondCities(code);
        for (int i = 0; i < _secondCities.length; i++) {
          String _text = _secondCities[i].values.toString();
          items.add(Text('$_text'));
        }
        return items;
      }

      currentCities = _buildCityViews(_metaTrainProvinces[1].keys.first);

      List<Widget> _buildStaionViews(String k) {
        List<Widget> items = [];
        getTrainStationFromC(k);
        String _text;
        if (_railwayStations == null) {
          items.add(Text('无'));
          return items;
        } else {
          for (int i = 0; i < _railwayStations.length; i++) {
            String _text = _railwayStations[i].values.toString();
            items.add(Text('$_text'));
          }
          return items;
        }
      }

      currentStations = _buildStaionViews(_secondCities[0].keys.first);

      provincePicker = CupertinoPicker(
          itemExtent: 20,
          onSelectedItemChanged: (position) {
            print('The position is $position');
            // 如果省有变化，则需修改第二列市，以及通过第二列修改第三列
            setState(() {
              //cityController.jumpTo(0);
              //cityController.selectedItem = 0;
              //cityController.position.notifyListeners();
              currentCities.removeLast();
              cityController.jumpTo(0);
              stationController.jumpTo(0);
              //currentCities.add(Text('test'));
              currentCities.removeLast();
              print(currentCities);
            });
          },
          children: _buildProvinceViews());

      cityPicker = CupertinoPicker(
          itemExtent: 20,
          scrollController: cityController,
          onSelectedItemChanged: (position) {
            print('The position is $position');
          },
          children: currentCities);

      stationPicker = CupertinoPicker(
          itemExtent: 20,
          scrollController: stationController,
          onSelectedItemChanged: (position) {
            print('The position is $position');
          },
          children: currentCities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 20,
          child: Row(children: <Widget>[
            FlatButton(
                onPressed: null,
                child: Text("取消"),
                color: Colors.blue,
                textColor: Colors.black),
            FlatButton(
                onPressed: null,
                child: Text("确定"),
                color: Colors.blue,
                textColor: Colors.black),
          ]),
        ),
        Container(
          height: 300,
          child: Row(
            children: <Widget>[
              Expanded(
                child: provincePicker,
              ),
              Expanded(
                child: cityPicker,
              ),
              Expanded(
                child: stationPicker,
              )
            ],
          ),
        )
      ],
    );
    ;
  }
}

void main() {
  //_TrainState().getTrainProvCtiy();
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
