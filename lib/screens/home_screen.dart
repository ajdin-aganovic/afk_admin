import 'dart:math';
import 'dart:convert';
import 'package:afk_admin/providers/bolest_provider.dart';
import 'package:afk_admin/providers/clanarina_provider.dart';
import 'package:afk_admin/providers/pozicija_provider.dart';
import 'package:afk_admin/providers/stadion_provider.dart';
import 'package:afk_admin/providers/statistika_provider.dart';
import 'package:afk_admin/providers/termin_provider.dart';
import 'package:afk_admin/providers/transakcijski_racun_provider.dart';
import 'package:afk_admin/providers/trening_provider.dart';
import 'package:afk_admin/screens/bolest_list_screen.dart';
import 'package:afk_admin/screens/korisnici_list_screen.dart';
import 'package:afk_admin/screens/reset_password_screen.dart';
import 'package:afk_admin/screens/termin_list_screen.dart';
import 'package:afk_admin/screens/trening_list_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;
import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:afk_admin/screens/plata_list_screen.dart';
import 'package:afk_admin/screens/korisnik_details_screen.dart';
import 'package:afk_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:afk_admin/widgets/makePayment.dart';
// import 'package:afk_admin/api/client.dart';

import '../models/korisnik.dart';
import '../models/search_result.dart';

class HomePage extends StatefulWidget {
  Korisnik? korisnik;
  HomePage({this.korisnik, super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  
  final _formKey=GlobalKey<FormBuilderState>();
  
Map<String,dynamic>_initialValue={};

  late KorisnikProvider _korisnikProvider;
  

  SearchResult<Korisnik>? _korisnikResult;

  @override
  void initState(){
    super.initState();
    _korisnikProvider=context.read<KorisnikProvider>();
    initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }

    Future initForm()async{
      _korisnikResult=await _korisnikProvider.get();
      // print(_korisnikResult);
  }


  @override
  Widget build(BuildContext context) {
    var izabrani=this._korisnikResult?.result.first;
    // TODO: implement build
   return 
    Scaffold(
      appBar: AppBar(
        title: const Text("Home"),),
        body: Center(
          child: 
          Container(
            constraints: const BoxConstraints(maxHeight: 600,maxWidth: 400),
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    SizedBox(height: 20,),
                    
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: 
                        Column(
                          children: [
                            SizedBox(height: 12,),
                            Text('Aplikacija Fudbalskog Kluba',
                            style: TextStyle(fontSize: 30),), 
                            SizedBox(height: 12,),
                            Text('Dobrodošli ${izabrani?.korisnickoIme??"nazad"}',
                            style: TextStyle(fontSize: 30),), 
                            SizedBox(height: 12,),
                            ElevatedButton(onPressed: (){
                            Navigator.of(context).push(
                            MaterialPageRoute(
                            builder: (context) => KorisniciListScreen()
                            ),
                        );
                        }, child: Text("Go to Korisnici lista")),
                            SizedBox(height: 12,),
                            ElevatedButton(onPressed: (){
                            Navigator.of(context).push(
                            MaterialPageRoute(
                      
                            builder: (context) => BolestListScreen(),
                                ),
                                );
                              }, child: Text("Go to Bolests")),
                              SizedBox(height: 12,),
                            ElevatedButton(onPressed: (){
                            Navigator.of(context).push(
                            MaterialPageRoute(
                      
                            builder: (context) => TerminListScreen(),
                                ),
                                );
                              }, child: Text("Go to Termins")),
                            SizedBox(height: 12,),
                        ElevatedButton(onPressed: (){
                        Navigator.of(context).push(
                        MaterialPageRoute(
                  
                        builder: (context) => TreningListScreen(),
                            ),
                            );
                          }, child: Text("Go to Trenings")),

                          ],
                        ),
                      
                    ),
                    
                  ]),
                ],
              ),
            ),
          ),
        ),
    );
  }

}