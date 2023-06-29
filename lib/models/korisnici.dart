import 'package:json_annotation/json_annotation.dart';
part 'korisnici.g.dart';

@JsonSerializable()
class Korisnici{
   int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? lozinka;
  int? ulogaId;
  String? strucnaSprema;
  DateTime? datumRodjenja;
  int? bolestId;
  int? tipKorisnikaId;
  int? transakcijskiRacunId;
  bool? podUgovorom;
  DateTime? podUgovoromOd;
  DateTime? podUgovoromDo;
  String? korisnickoIme;


  Korisnici(this.bolestId, this.datumRodjenja, this.email, this.ime, this.korisnickoIme, this.korisnikId, this.lozinka, this.podUgovorom,
  this.podUgovoromDo, this.podUgovoromOd, this.prezime, this.strucnaSprema, this.tipKorisnikaId, this.transakcijskiRacunId, this.ulogaId);
  // factory Korisnici.fromJson(Map<String,dynamic>json)=>_$KorisniciFromJson(json);

  factory Korisnici.fromJson(Map<String,dynamic>json)=>_$KorisniciFromJson(json);
  Map<String,dynamic>toJson()=>_$KorisniciToJson(this);
}

//  public int KorisnikId { get; set; }

//         public string? Ime { get; set; }

//         public string? Prezime { get; set; }

//         public string? Email { get; set; }

//         public string? Lozinka { get; set; }

//         public int UlogaId { get; set; }

//         public string? StrucnaSprema { get; set; }

//         public DateTime? DatumRodjenja { get; set; }

//         public int? BolestId { get; set; }
//         public int TipKorisnikaId { get; set; }
//         public int? TransakcijskiRacunId { get; set; }
//         public bool? PodUgovorom { get; set; }
//         public DateTime? PodUgovoromOd { get; set; }
//         public DateTime? PodUgovoromDo { get; set; }
//         public string? KorisnickoIme { get; set; }