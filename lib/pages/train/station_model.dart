import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

@JsonSerializable()
class StationsData {
  final int code;
  final String message;
  final List<Site> content;

  TrainData({this.code, this.message, this.content});

  factory TrainData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Content'] as List;
    List<Site> stationsList = list.map((i) => stationsList.fromJson(i)).toList();

    return TrainData(
        code: parsedJson['Code'],
        message: parsedJson['Message'],
        content: stationsList);
  }
}

//content
@JsonSerializable()
class Stations {

}


@JsonSerializable()
class TrainPass {
  final boolean g;
  final boolean d;
  final boolean c;
  final boolean z;
  final boolean t;
  final boolean k;
  final boolean o;

  TrainPass({
    this.g
});

}


@JsonSerializable()
class Site {
  final int id;
  final String k;
  final String name;
  final String loc;
  final int type;
  final int href;
  final String img;
  final String province;
  final String prefecture;
  final String country;

  Site({this.id, this.k, this.name,this.loc, this.type, this.href, this.img,this.province,
    this.prefecture, this.country});

  return Site(
  id: parsedJson['Id'],
  k: parsedJson['K'],
  name: parsedJson['Name'],
  loc: parsedJson['Loc'],
  type: parsedJson['Type'],
  href: parsedJson['Href'],
  img: parsedJson['Img'],
  province: parsedJson['Province'],
  prefecture: parsedJson['Prefecture'],
  country: parsedJson['Country']
  );

}