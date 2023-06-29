import 'package:json_annotation/json_annotation.dart';
part 'tip_korisnika.g.dart';

@JsonSerializable()
class TipKorisnika{
  int? tipKorisnikaId;
  String? nazivTipa;

  TipKorisnika(this.nazivTipa, this.tipKorisnikaId);
  factory TipKorisnika.fromJson(Map<String,dynamic>json)=>_$TipKorisnikaFromJson(json);
  Map<String,dynamic>toJson()=>_$TipKorisnikaToJson(this);
}
