// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationsData _$StationsDataFromJson(Map<String, dynamic> json) {
  return StationsData(
    code: json['code'] as int,
    message: json['message'] as String,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : Stations.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StationsDataToJson(StationsData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'content': instance.content,
    };

Stations _$StationsFromJson(Map<String, dynamic> json) {
  return Stations(
    grade: json['grade'] as String,
    active: json['active'] as bool,
    trainStop: json['trainStop'] == null
        ? null
        : TrainStop.fromJson(json['trainStop'] as Map<String, dynamic>),
    trainPass: json['trainPass'] == null
        ? null
        : TrainPass.fromJson(json['trainPass'] as Map<String, dynamic>),
    site: json['site'] == null
        ? null
        : Site.fromJson(json['site'] as Map<String, dynamic>),
    trainCount: json['trainCount'] as int,
    gTrainCount: json['gTrainCount'] as int,
    cTrainCount: json['cTrainCount'] as int,
    dTrainCount: json['dTrainCount'] as int,
    kTrainCount: json['kTrainCount'] as int,
    oTrainCount: json['oTrainCount'] as int,
    tTrainCount: json['tTrainCount'] as int,
    zTrainCount: json['zTrainCount'] as int,
  );
}

Map<String, dynamic> _$StationsToJson(Stations instance) => <String, dynamic>{
      'grade': instance.grade,
      'active': instance.active,
      'trainStop': instance.trainStop,
      'trainPass': instance.trainPass,
      'site': instance.site,
      'trainCount': instance.trainCount,
      'gTrainCount': instance.gTrainCount,
      'cTrainCount': instance.cTrainCount,
      'dTrainCount': instance.dTrainCount,
      'kTrainCount': instance.kTrainCount,
      'oTrainCount': instance.oTrainCount,
      'tTrainCount': instance.tTrainCount,
      'zTrainCount': instance.zTrainCount,
    };

TrainStop _$TrainStopFromJson(Map<String, dynamic> json) {
  return TrainStop(
    g: json['g'] as bool,
    d: json['d'] as bool,
    c: json['c'] as bool,
    z: json['z'] as bool,
    t: json['t'] as bool,
    k: json['k'] as bool,
    o: json['o'] as bool,
  );
}

Map<String, dynamic> _$TrainStopToJson(TrainStop instance) => <String, dynamic>{
      'g': instance.g,
      'd': instance.d,
      'c': instance.c,
      'z': instance.z,
      't': instance.t,
      'k': instance.k,
      'o': instance.o,
    };

TrainPass _$TrainPassFromJson(Map<String, dynamic> json) {
  return TrainPass(
    g: json['g'] as bool,
    d: json['d'] as bool,
    c: json['c'] as bool,
    z: json['z'] as bool,
    t: json['t'] as bool,
    k: json['k'] as bool,
    o: json['o'] as bool,
  );
}

Map<String, dynamic> _$TrainPassToJson(TrainPass instance) => <String, dynamic>{
      'g': instance.g,
      'd': instance.d,
      'c': instance.c,
      'z': instance.z,
      't': instance.t,
      'k': instance.k,
      'o': instance.o,
    };

Site _$SiteFromJson(Map<String, dynamic> json) {
  return Site(
    id: json['id'] as int,
    k: json['k'] as String,
    name: json['name'] as String,
    loc: json['loc'] as String,
    type: json['type'] as int,
    href: json['href'] as int,
    img: json['img'] as String,
    province: json['province'] as String,
    prefecture: json['prefecture'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'id': instance.id,
      'k': instance.k,
      'name': instance.name,
      'loc': instance.loc,
      'type': instance.type,
      'href': instance.href,
      'img': instance.img,
      'province': instance.province,
      'prefecture': instance.prefecture,
      'country': instance.country,
    };
