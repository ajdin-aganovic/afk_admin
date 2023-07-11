import 'package:json_annotation/json_annotation.dart';
part 'uloga.g.dart';

@JsonSerializable()
class Uloga{
  int? ulogaId;
  String? nazivUloge;
  String? podtipUloge;

  Uloga(this.ulogaId, this.nazivUloge, this.podtipUloge);
  factory Uloga.fromJson(Map<String,dynamic>json)=>_$UlogaFromJson(json);
  Map<String,dynamic>toJson()=>_$UlogaToJson(this);
}
