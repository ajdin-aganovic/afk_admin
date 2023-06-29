


import '../models/tip_korisnika.dart';
import 'base_provider.dart';

class TipKorisnikaProvider extends BaseProvider<TipKorisnika>{

  TipKorisnikaProvider():super("TipKorisnika");

  @override
  TipKorisnika fromJson(data) {
    // TODO: implement fromJson
    return TipKorisnika.fromJson(data);
  }

}