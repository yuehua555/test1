// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'train_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainData _$TrainDataFromJson(Map<String, dynamic> json) {
  return TrainData(
    code: json['code'] as int,
    message: json['message'] as String,
    content: (json['content'] as List)
        ?.map(
            (e) => e == null ? null : Train.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TrainDataToJson(TrainData instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'content': instance.content,
    };

Train _$TrainFromJson(Map<String, dynamic> json) {
  return Train(
    name: json['name'] as String,
    title: json['title'] as String,
    k: json['k'] as String,
    provK: json['provK'] as String,
    prefK: json['prefK'] as String,
    adCode: json['adCode'] as int,
    downLines: (json['downLines'] as List)
        ?.map((e) =>
            e == null ? null : DownLines.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TrainToJson(Train instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'k': instance.k,
      'provK': instance.provK,
      'prefK': instance.prefK,
      'adCode': instance.adCode,
      'downLines': instance.downLines,
    };

DownLines _$DownLinesFromJson(Map<String, dynamic> json) {
  return DownLines(
    name: json['name'] as String,
    title: json['title'] as String,
    k: json['k'] as String,
    provK: json['provK'] as String,
    prefK: json['prefK'] as String,
    adCode: json['adCode'] as int,
    downlines: (json['downlines'] as List)
        ?.map((e) =>
            e == null ? null : DownLines.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DownLinesToJson(DownLines instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'k': instance.k,
      'provK': instance.provK,
      'prefK': instance.prefK,
      'adCode': instance.adCode,
      'downlines': instance.downlines,
    };
