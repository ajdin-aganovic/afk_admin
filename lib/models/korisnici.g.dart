// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnici _$KorisniciFromJson(Map<String, dynamic> json) => Korisnici(
      json['bolestId'] as int?,
      json['datumRodjenja'] == null
          ? null
          : DateTime.parse(json['datumRodjenja'] as String),
      json['email'] as String?,
      json['ime'] as String?,
      json['korisnickoIme'] as String?,
      json['korisnikId'] as int?,
      json['lozinka'] as String?,
      json['podUgovorom'] as bool?,
      json['podUgovoromDo'] == null
          ? null
          : DateTime.parse(json['podUgovoromDo'] as String),
      json['podUgovoromOd'] == null
          ? null
          : DateTime.parse(json['podUgovoromOd'] as String),
      json['prezime'] as String?,
      json['strucnaSprema'] as String?,
      json['tipKorisnikaId'] as int?,
      json['transakcijskiRacunId'] as int?,
      json['ulogaId'] as int?,
    );

Map<String, dynamic> _$KorisniciToJson(Korisnici instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'lozinka': instance.lozinka,
      'ulogaId': instance.ulogaId,
      'strucnaSprema': instance.strucnaSprema,
      'datumRodjenja': instance.datumRodjenja?.toIso8601String(),
      'bolestId': instance.bolestId,
      'tipKorisnikaId': instance.tipKorisnikaId,
      'transakcijskiRacunId': instance.transakcijskiRacunId,
      'podUgovorom': instance.podUgovorom,
      'podUgovoromOd': instance.podUgovoromOd?.toIso8601String(),
      'podUgovoromDo': instance.podUgovoromDo?.toIso8601String(),
      'korisnickoIme': instance.korisnickoIme,
    };
