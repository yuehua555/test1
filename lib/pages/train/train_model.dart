import 'package:json_annotation/json_annotation.dart';

part 'train_model.g.dart';

@JsonSerializable()
class TrainData {
  final int code;
  final String message;
  final List<Train> content;

  TrainData({this.code, this.message, this.content});

  factory TrainData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Content'] as List;
    List<Train> lineList = list.map((i) => Train.fromJson(i)).toList();

    return TrainData(
        code: parsedJson['Code'],
        message: parsedJson['Message'],
        content: lineList);
  }
}

//conten
@JsonSerializable()
class Train {
  final String name;
  final String title;
  final String k;
  final String provK;
  final String prefK;
  final int adCode;
  final List<DownLines> downLines;

  Train(
      {this.name,
      this.title,
      this.k,
      this.provK,
      this.prefK,
      this.adCode,
      this.downLines});

  factory Train.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['DownLines'] as List;
    List<DownLines> lineList = list.map((i) => DownLines.fromJson(i)).toList();

    return Train(
        name: parsedJson['Name'],
        title: parsedJson['Title'],
        k: parsedJson['K'],
        provK: parsedJson['ProvK'],
        prefK: parsedJson['PrefK'],
        adCode: parsedJson['AdCode'],
        downLines: lineList);
  }
}

//DownLines
@JsonSerializable()
class DownLines {
  final String name;
  final String title;
  final String k;
  final String provK;
  final String prefK;
  final int adCode;
  final List<DownLines> downlines;

  DownLines(
      {this.name,
      this.title,
      this.k,
      this.provK,
      this.prefK,
      this.adCode,
      this.downlines});

  factory DownLines.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['DownLines'] as List;
    List<DownLines> lineList = list.map((i) => DownLines.fromJson(i)).toList();

    return DownLines(
        name: parsedJson['Name'],
        title: parsedJson['Title'],
        k: parsedJson['K'],
        provK: parsedJson['ProvK'],
        prefK: parsedJson['PrefK'],
        adCode: parsedJson['AdCode'],
        downlines: lineList);
  }
}
