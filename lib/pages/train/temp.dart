import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'train_model.dart';
import 'dart:io';
import 'package:dio/dio.dart';

Future<String> _loadADataAsset() async {
  return await rootBundle.loadString('asset/train_data.json');
}

void main() async {
  var dio = Dio(BaseOptions(
    baseUrl: 'https://test001.btylx.com:6688/',
    connectTimeout: 5000, // 5s
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

    try {
      //String jsonString = await _loadADataAsset();
      //final jsonResponse = json.decode(response.data);
      TrainData trainData = TrainData.fromJson(response.data);
      print(trainData.code.toString() +
          "," +
          trainData.message +
          ',Content:' +
          trainData.content.toString());
    } catch (e) {
      print(e);
    }
  } else {
    print('请求失败，状态码为:' + response.statusCode.toString());
  }
}
