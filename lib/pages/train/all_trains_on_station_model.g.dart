// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_trains_on_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTrainsOnStation _$AllTrainsOnStationFromJson(Map<String, dynamic> json) {
  return AllTrainsOnStation(
    code: json['code'] as int,
    message: json['message'] as String,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : Trains.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllTrainsOnStationToJson(AllTrainsOnStation instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'content': instance.content,
    };

Trains _$TrainsFromJson(Map<String, dynamic> json) {
  return Trains(
    no: json['no'] as String,
    sS: json['sS'] == null
        ? null
        : SS.fromJson(json['sS'] as Map<String, dynamic>),
    iS: json['iS'] == null
        ? null
        : IS.fromJson(json['iS'] as Map<String, dynamic>),
    tS: json['tS'] == null
        ? null
        : TS.fromJson(json['tS'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TrainsToJson(Trains instance) => <String, dynamic>{
      'no': instance.no,
      'sS': instance.sS,
      'iS': instance.iS,
      'tS': instance.tS,
    };

SS _$SSFromJson(Map<String, dynamic> json) {
  return SS(
    id: json['id'] as int,
    name: json['name'] as String,
    seq: json['seq'] as int,
    arrT: json['arrT'] as String,
    depT: json['depT'] as String,
    runDur: json['runDur'] as int,
    km: json['km'] as int,
  );
}

Map<String, dynamic> _$SSToJson(SS instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seq': instance.seq,
      'arrT': instance.arrT,
      'depT': instance.depT,
      'runDur': instance.runDur,
      'km': instance.km,
    };

IS _$ISFromJson(Map<String, dynamic> json) {
  return IS(
    id: json['id'] as int,
    name: json['name'] as String,
    seq: json['seq'] as int,
    arrT: json['arrT'] as String,
    depT: json['depT'] as String,
    runDur: json['runDur'] as int,
    km: json['km'] as int,
  );
}

Map<String, dynamic> _$ISToJson(IS instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seq': instance.seq,
      'arrT': instance.arrT,
      'depT': instance.depT,
      'runDur': instance.runDur,
      'km': instance.km,
    };

TS _$TSFromJson(Map<String, dynamic> json) {
  return TS(
    id: json['id'] as int,
    name: json['name'] as String,
    seq: json['seq'] as int,
    arrT: json['arrT'] as String,
    depT: json['depT'] as String,
    runDur: json['runDur'] as int,
    km: json['km'] as int,
  );
}

Map<String, dynamic> _$TSToJson(TS instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seq': instance.seq,
      'arrT': instance.arrT,
      'depT': instance.depT,
      'runDur': instance.runDur,
      'km': instance.km,
    };
