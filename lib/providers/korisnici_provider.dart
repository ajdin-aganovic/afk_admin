

import 'package:afk_admin/models/korisnici.dart';

import 'base_provider.dart';

class KorisniciProvider extends BaseProvider<Korisnici>{

  KorisniciProvider():super("Korisnici");

  @override
  Korisnici fromJson(data) {
    // TODO: implement fromJson
    return Korisnici.fromJson(data);
  }

}