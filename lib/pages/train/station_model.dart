import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

@JsonSerializable()
class StationsData {
  final int code;
  final String message;
  final List<Stations> content;

  StationsData({this.code, this.message, this.content});

  factory StationsData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Content'] as List;
    List<Stations> stationsList =
        list.map((i) => Stations.fromJson(i)).toList();

    return StationsData(
        code: parsedJson['Code'],
        message: parsedJson['Message'],
        content: stationsList);
  }
}

//content
@JsonSerializable()
class Stations {
  final String grade;
  final bool active;
  final TrainStop trainStop;
  final TrainPass trainPass;
  final Site site;
  final int trainCount;
  final int gTrainCount;
  final int cTrainCount;
  final int dTrainCount;
  final int kTrainCount;
  final int oTrainCount;
  final int tTrainCount;
  final int zTrainCount;

  Stations(
      {this.grade,
      this.active,
      this.trainStop,
      this.trainPass,
      this.site,
      this.trainCount,
      this.gTrainCount,
      this.cTrainCount,
      this.dTrainCount,
      this.kTrainCount,
      this.oTrainCount,
      this.tTrainCount,
      this.zTrainCount});
  factory Stations.fromJson(Map<String, dynamic> parsedJson) {
    return Stations(
        grade: parsedJson['Grade'],
        active: parsedJson['Active'],
        trainStop: TrainStop.fromJson(parsedJson['TrainStop']),
        trainPass: TrainPass.fromJson(parsedJson['TrainPass']),
        site: Site.fromJson(parsedJson['Site']),
        trainCount: parsedJson['TrainCount'],
        gTrainCount: parsedJson['GTrainCount'],
        cTrainCount: parsedJson['CTrainCount'],
        dTrainCount: parsedJson['DTrainCount'],
        kTrainCount: parsedJson['KTrainCount'],
        oTrainCount: parsedJson['OTrainCount'],
        tTrainCount: parsedJson['TTrainCount'],
        zTrainCount: parsedJson['ZTrainCount']);
  }
}

@JsonSerializable()
class TrainStop {
  final bool g;
  final bool d;
  final bool c;
  final bool z;
  final bool t;
  final bool k;
  final bool o;

  TrainStop({this.g, this.d, this.c, this.z, this.t, this.k, this.o});

  factory TrainStop.fromJson(Map<String, dynamic> parsedJson) {
    return TrainStop(
        g: parsedJson['G'],
        d: parsedJson['D'],
        c: parsedJson['C'],
        z: parsedJson['Z'],
        t: parsedJson['T'],
        k: parsedJson['K'],
        o: parsedJson['O']);
  }
}

@JsonSerializable()
class TrainPass {
  final bool g;
  final bool d;
  final bool c;
  final bool z;
  final bool t;
  final bool k;
  final bool o;

  TrainPass({this.g, this.d, this.c, this.z, this.t, this.k, this.o});

  factory TrainPass.fromJson(Map<String, dynamic> parsedJson) {
    return TrainPass(
        g: parsedJson['G'],
        d: parsedJson['D'],
        c: parsedJson['C'],
        z: parsedJson['Z'],
        t: parsedJson['T'],
        k: parsedJson['K'],
        o: parsedJson['O']);
  }
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

  Site(
      {this.id,
      this.k,
      this.name,
      this.loc,
      this.type,
      this.href,
      this.img,
      this.province,
      this.prefecture,
      this.country});

  factory Site.fromJson(Map<String, dynamic> parsedJson) {
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
        country: parsedJson['Country']);
  }
}
