import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:test1/pages/train/all_trains_on_station_model.dart';
import 'train_model.dart';
import 'station_model.dart';
import 'dart:convert';
import 'dart:async';
import 'all_trains_on_station.dart';

void main() => runApp(MyApp());
String ttt = 'test';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ttt,
      home: Train(),
    );
  }
}

class Train extends StatefulWidget {
  @override
  _TrainState createState() => _TrainState();
}

class _TrainState extends State<Train> {
  FixedExtentScrollController stationController = FixedExtentScrollController();
  FixedExtentScrollController ctr1 = FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(ttt)),
        body: Column(children: <Widget>[
          Image.asset(
            'asset/images/CRH.jpg',
            width: 500,
            height: 100,
          ),
          RaisedButton(
              child: Text('车站时刻表'),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => TrainPickers(title: ttt),
                );
              })
        ]));
  }
}

class TrainPickers extends StatefulWidget {
  TrainPickers({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TrainPickersState createState() => new _TrainPickersState();
}

class _TrainPickersState extends State<TrainPickers> {
  //var _devices = ['ppp'];
  var count = 0;
  var _height = 300.0;
  //省, 是一个数组，数组元素是Map<int, String>
  // 以 AdCode 为key，value是对应的 title
  List<Map<int, String>> _metaTrainProvinces = [
    {-1: '加载...'}
  ];

  //市，以省的AdCode为key，
  // value是一个Map<int, dynamic>，key是这个市的AdCode，
  // value是一个Map<String, String>，key包括name, title, K, value是相应的数据
  Map<int, dynamic> _metaTrainCities;

  // 第二列的城市显示数组
  // 以第一列省的AdCode作为查询条件，在_metaTrainCities中查出相对应的城市组成一个
  // Map数组，key 就是 K，value 是 title
  List<Map<String, String>> _secondCities = [
    {'-1': '加载...'}
  ];

  // 第三列火车站名，通过市的RegionK 得到，是一个数组，数组元素是Map<String, String>
  // key 是 K ，value 是 name
  List<Map<String, String>> _railwayStations = [
    {'-1': '加载...'}
  ];

  // List<Widget> currentCities = [Text('加载...')];
  // List<Widget> currentStations;

  Widget provincePicker;
  Widget cityPicker;
  Widget stationPicker;

  FixedExtentScrollController provinceController =
      FixedExtentScrollController();
  FixedExtentScrollController cityController = FixedExtentScrollController();
  FixedExtentScrollController stationController = FixedExtentScrollController();

  //String _Text = '无';
  int stationCount = 1;

  var _provinceBuilderFuture;
  var _stationBuilderFuture;

  @override
  void initState() {
    super.initState();

    // 用 _provinceBuilderFuture 来保存 _getTrainProvCtiy() 的结果，
    // 以避免不必要的重绘
    _provinceBuilderFuture = _getTrainProvCtiy().whenComplete((){
      // 获得省市数据后，
      // 使用第二列的第一个数据的 K 值初始化第三列
      _stationBuilderFuture = _getTrainStationFromC(_secondCities[0].keys.first);
    });
    /*
    _getTrainProvCtiy().whenComplete(() {
      //currentCities = _buildCityViews(_metaTrainProvinces[0].keys.first);
      getTrainStationFromC(_secondCities[0].keys.first);
      //super.initState();
    });

     */
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: Row(children: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("取消"),
                color: Colors.blue,
                textColor: Colors.black),
            FlatButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllTrains()));
                },
                child: Text("确定"),
                color: Colors.blue,
                textColor: Colors.black),
          ]),
        ),
        Container(
          height: 300,
          child: FutureBuilder(
            future: _provinceBuilderFuture,
            builder: ((BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 请求成功，显示数据
                  provincePicker = Container(
                      height: _height,
                      width: 100,
                      child: CupertinoPicker(
                          magnification: 1.0, // 整体放大率
                          useMagnifier: true, // 是否使用放大效果
                          //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
                          itemExtent: 40,
                          scrollController: provinceController,
                          onSelectedItemChanged: (index) {
                            //print('The position is $index');
                            // 如果省有变化，则需修改第二列市，以及通过第二列修改第三列
                            // 由于 CupertinoPicker 有一个bug，所以这里用了一个官方提供的 workaround
                            // see https://github.com/flutter/flutter/issues/22999
                            int currentAdCode =
                                _metaTrainProvinces[index].keys.first;
                            _getSecondCities(currentAdCode);
                            String currentK = _secondCities[0].keys.first;
                            _getTrainStationFromC(currentK).whenComplete(() {
                              setState(() {
                                //_devices.add("test " + count.toString());
                                //getSecondCities(_metaTrainProvinces[index].keys.first);
                                //getTrainStationFromC(_secondCities[index].keys.first);
                                count += 1;
                                _height = 300.01;
                                print(_secondCities);
                              });
                              Timer(const Duration(milliseconds: 50), () {
                                if (mounted) {
                                  setState(() {
                                    _height = 300.0;
                                  });
                                }
                              });
                            });
                          },
                          children: _buildProvinceViews()));

                  cityPicker = Container(
                    height: _height,
                    width: 150,
                    child: CupertinoPicker(
                        magnification: 1.0, // 整体放大率
                        useMagnifier: true, // 是否使用放大效果
                        //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
                        itemExtent: 40, // 所有子节点 统一高度
                        scrollController: cityController,
                        onSelectedItemChanged: (index) {
                          print(index);
                          _getTrainStationFromC(_secondCities[index].keys.first)
                              .whenComplete(() {
                            setState(() {
                              //_devices.add("test " + count.toString());
                              //getTrainStationFromC(_secondCities[index].keys.first);
                              count += 1;
                              _height = 300.01;
                              //print(_railwayStations);
                            });
                            Timer(const Duration(milliseconds: 50), () {
                              if (mounted) {
                                setState(() {
                                  _height = 300.0;
                                });
                              }
                            });
                          });
                        },
                        children: _buildCityViews()
                    ),
                  );

                  stationPicker = FutureBuilder(
                      future: _stationBuilderFuture,
                      builder: ((BuildContext context, AsyncSnapshot snapshot) {
                        // 请求已结束
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // 请求失败，显示错误
                            return Text('Error: ${snapshot.error}');
                          } else {
                            // 请求成功，显示数据
                            return Container(
                                height: _height,
                                width: 100,
                                child: CupertinoPicker(
                                    magnification: 1.0, // 整体放大率
                                    useMagnifier: true, // 是否使用放大效果
                                    //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
                                    itemExtent: 40,
                                    scrollController: stationController,
                                    onSelectedItemChanged: (index) {
                                      print('stationPicker:' + index.toString());
                                    },
                                    children: _buildStationViews()));
                            /*
                      return Container(
                        height: _height,
                        width: 150,
                        child: CupertinoPicker.builder(
                            magnification: 1.0,
                            // 整体放大率
                            useMagnifier: true,
                            // 是否使用放大效果
                            //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
                            itemExtent: 40,
                            // 所有子节点 统一高度
                            scrollController: stationController,
                            onSelectedItemChanged: (index) {
                              print(index);
                            },
                            itemBuilder: (context, index) {
                              //print('stationPicker itemBuilder');
                             // print('railwayStations:' +
                             //     _railwayStations.toString());
                              //_Text = '无';
                              //int stationCount = 1;
                              if (_railwayStations != null) {
                                print(_railwayStations);
                                //print(_railwayStations.length);
                                _Text = _railwayStations[index].values.first;
                                //stationCount = _railwayStations.length;
                              }
                              //print(_Text);
                              return Text(
                                _Text,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                              );
                            },
                            childCount: _railwayStations.length),
                      );

                       */
                          }
                        } else {
                          // 请求未结束，显示loading
                          return Text('加载车站...');
                        }
                      }));


                  return Row(children: <Widget>[
                    provincePicker,
                    cityPicker,
                    stationPicker
                  ]
                  );
                }
              } else {
                // 请求未结束，显示loading
                return Text('加载数据...');
              }
            }),
          ),
        )
      ],
    )
      ;
    /*
    provincePicker = Container(
        height: _height,
        width: 100,
        child: CupertinoPicker(
            magnification:1.0, // 整体放大率
            useMagnifier:true,// 是否使用放大效果
            //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
            itemExtent: 40,
            scrollController: provinceController,
            onSelectedItemChanged: (index) {
              //print('The position is $index');
              // 如果省有变化，则需修改第二列市，以及通过第二列修改第三列
              // 由于 CupertinoPicker 有一个bug，所以这里用了一个官方提供的 workaround
              // see https://github.com/flutter/flutter/issues/22999
              int currentAdCode = _metaTrainProvinces[index].keys.first;
              getSecondCities(currentAdCode);
              String currentK = _secondCities[index].keys.first;
              getTrainStationFromC(currentK).whenComplete((){
                setState(() {
                  //_devices.add("test " + count.toString());
                  //getSecondCities(_metaTrainProvinces[index].keys.first);
                  //getTrainStationFromC(_secondCities[index].keys.first);
                  count += 1;
                  _height = 300.01;
                  print(_secondCities);
                });
                Timer(const Duration(milliseconds: 50), () {
                  if (mounted) {
                    setState(() {
                      _height = 300.0;
                    });
                  }
                });
              });
            },
            children: _buildProvinceViews()));

    cityPicker = Container(
      height: _height,
      width: 150,
      /*child: CupertinoPicker(
            itemExtent: 20,
            scrollController: cityController,
            onSelectedItemChanged: (position) {
              print('The position is $position');
            },
            children: currentCities));

         */
      child: CupertinoPicker.builder(
          magnification:1.0, // 整体放大率
          useMagnifier:true,// 是否使用放大效果
          //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
          itemExtent: 40, // 所有子节点 统一高度
          scrollController: cityController,
          onSelectedItemChanged: (index) {
            print(index);
            getTrainStationFromC(_secondCities[index].keys.first).whenComplete((){
              setState(() {
                //_devices.add("test " + count.toString());
                //getTrainStationFromC(_secondCities[index].keys.first);
                count += 1;
                _height = 300.01;
                print(_railwayStations);
              });
              Timer(const Duration(milliseconds: 50), () {
                if (mounted) {
                  setState(() {
                    _height = 300.0;
                  });
                }
              });
            });

          },
          itemBuilder: (context, index) {
            //print('itemBuilder');
            return Text(
              _secondCities[index].values.first,
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            );
          },
          childCount: _secondCities.length),
    );

    stationPicker = Container(
      height: _height,
      width: 150,
      /*child: CupertinoPicker(
            itemExtent: 20,
            scrollController: cityController,
            onSelectedItemChanged: (position) {
              print('The position is $position');
            },
            children: currentCities));

         */
      child: CupertinoPicker.builder(
          magnification:1.0, // 整体放大率
          useMagnifier:true,// 是否使用放大效果
          //offAxisFraction:10.0,// 球面效果的透视系数,消失点位置
          itemExtent: 40, // 所有子节点 统一高度
          scrollController: stationController,
          onSelectedItemChanged: (index) {
            print(index);
          },
          itemBuilder: (context, index) {
            print('stationPicker itemBuilder');
            print('railwayStations:' + _railwayStations.toString());
            _Text = '无';
            if (_railwayStations != null) {
              _Text = _railwayStations[index].values.first;
            }
            //print(_Text);
            return Text(
            _Text,
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            );
          },
          childCount: _railwayStations.length),
    );

    //print('build! ${_devices.length}');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Row(children: <Widget>[
        provincePicker,
        cityPicker,
        stationPicker
      ]),
    );

     */
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('asset/train_data.json');
  }

  /// 以rest的方式得到原始数据，
  /// https://test001.btylx.com:6688/api/TcgRegDef  POST
  /// 得到火车站的省市名称.并构造后赋值给 _metaTrainProvinces 和 _metaTrainCities
  Future _getTrainProvCtiy() async {
    var dio = Dio(BaseOptions(
      baseUrl: 'https://test001.btylx.com:6688/',
      connectTimeout: 5000,
      // 5s
      sendTimeout: 5000,
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

    dio.interceptors.add(LogInterceptor(responseBody: true));

    Response response;
    try {
      response = await dio.post('api/TcgRegDef');
    } catch (e) {
      print(e);
    }
    //sleep(Duration(microseconds: 3000));
    if (response.statusCode == 200) {
      // 请求成功

      //String jsonString = await _loadAStudentAsset();
      //final jsonResponse = json.decode(jsonString);

      TrainData trainData = TrainData.fromJson(response.data);
      //TrainData trainData = TrainData.fromJson(jsonResponse);
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

      // 使用第一列的第一个数据的 AdCode 初始化第二列
      int currentAdCode =
          _metaTrainProvinces[0].keys.first;
      _getSecondCities(currentAdCode);

      // 使用第二列的第一个数据的 K 值初始化第三列
      //_getTrainStationFromC(_secondCities[0].keys.first);


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

  List<Widget> _buildCityViews() {
    //print(_secondCities);
    List<Widget> items = [];
   // getSecondCities(code);
    for (int i = 0; i < _secondCities.length; i++) {
      String _text = _secondCities[i].values.first;
      items.add(Text('$_text'));
    }
    return items;
  }

  List<Widget> _buildStationViews() {
    print(_railwayStations);
    List<Widget> items = [];

    if(_railwayStations == null || _railwayStations.length == 0) {
      items.add((Text('无')));
      return items;
    }
    for (int i = 0; i < _railwayStations.length; i++) {
      String _text = _railwayStations[i].values.first;
      items.add(Text('$_text'));
    }
    return items;
  }

  ///根据省的 Adcode 构造第二列城市数组
  List<Map<String, String>> _getSecondCities(int adCode) {
    Map<int, dynamic> cities = _metaTrainCities[adCode];
    _secondCities = List();
    cities.forEach((code, city) {
      //print(code);
      //print(city);
      Map<String, String> item = city;
      _secondCities.add({item['K']: item['title']});
    });
    //print(_secondCities);
  }

  List<Widget> _buildProvinceViews() {
    List<Widget> items = [];
    for (int i = 0; i < _metaTrainProvinces.length; i++) {
      String _text = _metaTrainProvinces[i].values.first;
      items.add(Text('$_text'));
    }
    return items;
  }

  /// 通过用户选择的市K值在选择器的第三列显示查询到的车站名
  /// 调用Rest API
  /// https://test001.btylx.com:6688/railwayStation?regionK=$K  GET
  /// 得到原始数据，构造后赋值给_railwayStations
  Future _getTrainStationFromC(String K) async {
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

    dio.interceptors.add(LogInterceptor(responseBody: true));

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
}
