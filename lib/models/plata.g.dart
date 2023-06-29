// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plata _$PlataFromJson(Map<String, dynamic> json) => Plata(
      json['plataId'] as int?,
      json['iznos'] as num?,
      json['stateMachine'] as String?,
    )
      ..korisnikId = json['korisnikId'] as int?
      ..datumSlanja = json['datumSlanja'] == null
          ? null
          : DateTime.parse(json['datumSlanja'] as String);

Map<String, dynamic> _$PlataToJson(Plata instance) => <String, dynamic>{
      'plataId': instance.plataId,
      'stateMachine': instance.stateMachine,
      'iznos': instance.iznos,
      'korisnikId': instance.korisnikId,
      'datumSlanja': instance.datumSlanja?.toIso8601String(),
    };
