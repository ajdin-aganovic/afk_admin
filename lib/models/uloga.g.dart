// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uloga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Uloga _$UlogaFromJson(Map<String, dynamic> json) => Uloga(
      json['nazivUloge'] as String?,
      json['tipKorisnikaId'] as int?,
      json['ulogaId'] as int?,
    );

Map<String, dynamic> _$UlogaToJson(Uloga instance) => <String, dynamic>{
      'ulogaId': instance.ulogaId,
      'nazivUloge': instance.nazivUloge,
      'tipKorisnikaId': instance.tipKorisnikaId,
    };
