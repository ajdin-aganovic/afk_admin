import 'package:json_annotation/json_annotation.dart';
part 'plata.g.dart';

@JsonSerializable()
class Plata{
  int? plataId;
  String? stateMachine;
  num? iznos;
  int? korisnikId;
  DateTime? datumSlanja;

  Plata(this.plataId, this.iznos, this.stateMachine);
  factory Plata.fromJson(Map<String,dynamic>json)=>_$PlataFromJson(json);
  Map<String,dynamic>toJson()=>_$PlataToJson(this);
}


// "plataId": 0,
// "korisnikId": 0,
// "stateMachine": "string",
// "iznos": 0,
// "datumSlanja": "2023-06-20T12:28:32.348Z",