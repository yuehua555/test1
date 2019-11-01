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

  int totalCount = 0;  // 总的列车线路数
  int upCount = 0;     // 上行列车线路数
  int downCount = 0;   // 下行列车线路数
  static const String GAOTIE = 'G';    // 高铁
  static const String DONCCHE = 'D';   // 动车
  static const String ZHIKUAI = 'Z';   // 直特
  static const String TEKUAI = 'T';    // 特快
  static const String KUAISU = 'K';    // 快速
  static const String LVYOU = 'Y';     // 旅游
  static const String CHENGJIAO = 'S'; // 城郊
  static const String PUTONG ='';      // 普通

  final String stationName = '北京站';

  // 该站所有火车的数组，按照从该站出发的时间排序
  // 即 IS 里的 DepT 转化成时间排序
  // MAP 元素包括是否始发，上行或下行，车辆编号，类型，从该站出发时间，终点站和到达时间
  List<Map<String, String>> _trains = [];


  var temp;
  var str;

  @override
  void initState() {
    super.initState();
    //TrainData trainData = TrainData.fromJson(jsonResponse);
    temp = _loadAStudentAsset().then((value){
      String jsonString =  value;
      final jsonResponse = json.decode(jsonString);

      // 所有列车数据列表　
      var  trainsData = AllTrainsOnStation.fromJson(jsonResponse).content;
      totalCount = trainsData.length;
      for (var source in trainsData) {
        Map<String, String> train = Map();
        String depT;       // 出发时间
        bool isBegin;      // 是否始发站
        bool isUp;         // 上行还是下行，true 为上行
        String type;       // 列车类型 G,D,Z...
        String arrT;       // 终点站到达时间
        String endStation; // 终点站

        train['name'] = source.no;
        train['depT'] = source.iS.depT;
        if (source.sS.id == source.iS.id) {
          isBegin = true;
        } else {
          isBegin = false;
        }
        train['begin'] = (isBegin? '上行' : '下行');
        // 根据列车名字编号的首字母判断列车的类型
        if (num.tryParse(source.no.substring(0,1)) != null ) {
          train['type'] = '普通';
        } else {
          switch(source.no.substring(0,1)) {
            case GAOTIE: train['type'] = '高铁'; break;
            case DONCCHE: train['type'] = '动车'; break;
            case ZHIKUAI: train['type'] = '直快'; break;
            case KUAISU: train['type'] = '快速'; break;
            case LVYOU: train['type'] = '旅游'; break;
            case CHENGJIAO: train['type'] = '城郊'; break;
            default: print('没有这种类型的火车'); break;
          }
        }
        ppp
        if (checkTrainNoUpOrDown(source.no)) {
          upCount++;
        } else {
          downCount++;
        }
      }
      print('TC:'+totalCount.toString()+', UC:' + upCount.toString()+', DC:'+downCount.toString());
    });
    //print(temp);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('xx站')),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text('上\n行\n$upCount'),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text('下\n行\n$downCount'),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("高\n铁\n 0",),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("动\n车\n 0",),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("特\n快\n 0",),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("其\n它\n 0",),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {},
                ),
              )

            ],

          ),
          Container(
            height: 50,
            child: Center(child: Text('出发列车时刻：' + totalCount.toString() + '条'),),
          ),
          Text('3')
        ],
      ),
    );
  }

  /// 判断列车是上行还是下行，
  /// No的末位为偶数是上行，奇数是下行
  /// 返回true是上行，false是下行
  bool checkTrainNoUpOrDown (String trainNo){
      // 得到trainNo的最后一个字符
      String lastChar = trainNo.substring(trainNo.length-1);
      int i = int.parse(lastChar);
      // 如果是偶数返回true
      return i.isEven;
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
