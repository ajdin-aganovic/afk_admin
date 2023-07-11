// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Termin _$TerminFromJson(Map<String, dynamic> json) => Termin(
      json['terminId'] as int?,
      json['sifraTermina'] as String?,
      json['tipTermina'] as String?,
      json['stadionId'] as int?,
      json['datumTermina'] == null
          ? null
          : DateTime.parse(json['datumTermina'] as String),
    );

Map<String, dynamic> _$TerminToJson(Termin instance) => <String, dynamic>{
      'terminId': instance.terminId,
      'sifraTermina': instance.sifraTermina,
      'tipTermina': instance.tipTermina,
      'stadionId': instance.stadionId,
      'datumTermina': instance.datumTermina?.toIso8601String(),
    };
