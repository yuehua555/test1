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

//SS
@JsonSerializable()
class SS {
  final String id;
  final String name;
  final String seq;
  final String arrT;
  final String depT;
  final String runDur;
  final String km;

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

//IS
@JsonSerializable()
class IS {
  final String id;
  final String name;
  final String seq;
  final String arrT;
  final String depT;
  final String runDur;
  final String km;

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

//TS
@JsonSerializable()
class TS {
  final String id;
  final String name;
  final String seq;
  final String arrT;
  final String depT;
  final String runDur;
  final String km;

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
