import 'package:json_annotation/json_annotation.dart';

part 'all_trains_on_station_model.g.dart';

@JsonSerializable()
class AllTrainsOnStation {
  final int code;
  final String message;
  final List<Trains> content;

  AllTrainsOnStation({this.code, this.message, this.content});

  factory AllTrainsOnStation.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Content'] as List;
    List<Trains> trainsList = list.map((i) => Trains.fromJson(i)).toList();

    return AllTrainsOnStation(
        code: parsedJson['Code'],
        message: parsedJson['Message'],
        content: trainsList);
  }
}

//content
@JsonSerializable()
class Trains {
  final String no;
  final SS sS;
  final IS iS;
  final TS tS;

  Trains({this.no, this.sS, this.iS, this.tS});

  factory Trains.fromJson(Map<String, dynamic> parsedJson) {
    return Trains(
        no: parsedJson['No'],
        sS: SS.fromJson(parsedJson['SS']),
        iS: IS.fromJson(parsedJson['IS']),
        tS: TS.fromJson(parsedJson['TS']));
  }
}

//SS 始发站
@JsonSerializable()
class SS {
  final int id;
  final String name;
  final int seq;
  final String arrT;
  final String depT;
  final int runDur;
  final int km;

  SS(
      {this.id,
      this.name,
      this.seq,
      this.arrT,
      this.depT,
      this.runDur,
      this.km});

  factory SS.fromJson(Map<String, dynamic> parsedJson) {
    return SS(
        id: parsedJson['ID'],
        name: parsedJson['Name'],
        seq: parsedJson['Seq'],
        arrT: parsedJson['ArrT'],
        depT: parsedJson['DepT'],
        runDur: parsedJson['RunDur'],
        km: parsedJson['Km']);
  }
}

//IS 当前站
@JsonSerializable()
class IS {
  final int id;
  final String name;
  final int seq;
  final String arrT;
  final String depT;
  final int runDur;
  final int km;

  IS(
      {this.id,
      this.name,
      this.seq,
      this.arrT,
      this.depT,
      this.runDur,
      this.km});

  factory IS.fromJson(Map<String, dynamic> parsedJson) {
    return IS(
        id: parsedJson['ID'],
        name: parsedJson['Name'],
        seq: parsedJson['Seq'],
        arrT: parsedJson['ArrT'],
        depT: parsedJson['DepT'],
        runDur: parsedJson['RunDur'],
        km: parsedJson['Km']);
  }
}

//TS 终点站
@JsonSerializable()
class TS {
  final int id;
  final String name;
  final int seq;
  final String arrT;
  final String depT;
  final int runDur;
  final int km;

  TS(
      {this.id,
      this.name,
      this.seq,
      this.arrT,
      this.depT,
      this.runDur,
      this.km});

  factory TS.fromJson(Map<String, dynamic> parsedJson) {
    return TS(
        id: parsedJson['ID'],
        name: parsedJson['Name'],
        seq: parsedJson['Seq'],
        arrT: parsedJson['ArrT'],
        depT: parsedJson['DepT'],
        runDur: parsedJson['RunDur'],
        km: parsedJson['Km']);
  }
}
