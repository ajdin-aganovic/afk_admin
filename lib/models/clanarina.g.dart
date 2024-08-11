// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clanarina.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clanarina _$ClanarinaFromJson(Map<String, dynamic> json) => Clanarina(
      json['clanarinaId'] as int?,
      json['korisnikId'] as int?,
      (json['iznosClanarine'] as num?)?.toDouble(),
      (json['dug'] as num?)?.toDouble(),
      json['placena'] as bool?,
      json['datumPlacanja'] == null
        ? null
        : DateTime.parse(json['datumPlacanja'] as String),
    );

Map<String, dynamic> _$ClanarinaToJson(Clanarina instance) => <String, dynamic>{
      'clanarinaId': instance.clanarinaId,
      'korisnikId': instance.korisnikId,
      'iznosClanarine': instance.iznosClanarine,
      'dug': instance.dug,
      'placena': instance.placena,
      'datumPlacanja':instance.datumPlacanja,
    };
