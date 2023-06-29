import 'package:json_annotation/json_annotation.dart';
part 'uloga.g.dart';

@JsonSerializable()
class Uloga{
  int? ulogaId;
  String? nazivUloge;
  int? tipKorisnikaId;

  Uloga(this.nazivUloge, this.tipKorisnikaId, this.ulogaId);
  factory Uloga.fromJson(Map<String,dynamic>json)=>_$UlogaFromJson(json);
  Map<String,dynamic>toJson()=>_$UlogaToJson(this);
}
