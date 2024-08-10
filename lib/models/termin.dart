import 'package:json_annotation/json_annotation.dart';
part 'termin.g.dart';

@JsonSerializable()
class Termin{
int? terminId;

String? sifraTermina;

String? tipTermina;

int? stadionId;

DateTime? datum;

String? rezultat;



  Termin(this.terminId, this.sifraTermina, this.tipTermina, this.stadionId, this.datum, this.rezultat);
  // factory Korisnici.fromJson(Map<String,dynamic>json)=>_$KorisniciFromJson(json);

  factory Termin.fromJson(Map<String,dynamic>json)=>_$TerminFromJson(json);
  Map<String,dynamic>toJson()=>_$TerminToJson(this);
}