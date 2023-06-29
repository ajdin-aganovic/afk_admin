

import 'package:afk_admin/models/plata.dart';

import 'base_provider.dart';

class PlataProvider extends BaseProvider<Plata>{
  PlataProvider(): super("Plata");


  @override
  Plata fromJson(data) {
    // TODO: implement fromJson
    return Plata.fromJson(data);
  }

  }