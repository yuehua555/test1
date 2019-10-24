import 'dart:async' show Future;
import 'train_model.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lpinyin/lpinyin.dart';


///城市选择器：https://github.com/hanxu317317/city_pickers
///得到火车站的省市名称，以及通过用户选择的省市在城市选择器的第三列显示查询到的车站名
///数据源构造格式参考 https://github.com/hanxu317317/city_pickers/blob/master/lib/meta/province.dart
class GetTrainProvCityStation {

  static Map<String, dynamic> metaTrainCities = Map<String, dynamic>(); // 城市
  static Map<String, String> metaTrainProvinces = Map<String, String>(); //省

  /// 以rest的方式得到原始数据，
  /// 并构造后赋值给 metaTrainProvinces 和 metaTrainCities
  static void getTrainProvCtiy() async {
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
    if (response.statusCode == 200) {
      // 请求成功

      TrainData trainData = TrainData.fromJson(response.data);

      ///trainData.content 是所有省和城市的列表信息
      trainData.content.forEach((train) {
        metaTrainProvinces[train.adCode.toString()] = train.title;

        Map<String, dynamic> secondCtiyMap = Map<String, dynamic>();
        train.downLines.forEach((secondCity){
          secondCtiyMap[secondCity.adCode.toString()] = {'name': secondCity.title, 'alpha': secondCity.adCode.toString()};
        });

        metaTrainCities[train.adCode.toString()]= secondCtiyMap;
      });

      print(metaTrainProvinces);
   //  print(metaTrainCities);
    } else {
      print('请求失败，状态码为:' + response.statusCode.toString());
    }
  }
}

void main() {
  GetTrainProvCityStation.getTrainProvCtiy();
}
