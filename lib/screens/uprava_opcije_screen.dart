import 'package:afk_admin/screens/clanarina_details_screen.dart';
import 'package:afk_admin/screens/clanarina_list_screen.dart';
import 'package:afk_admin/screens/pozicija_details_screen.dart';
import 'package:afk_admin/screens/pozicija_list_screen.dart';
import 'package:afk_admin/screens/statistika_details_screen.dart';
import 'package:afk_admin/screens/statistika_list_screen.dart';
import 'package:afk_admin/screens/termin_details_screen.dart';
import 'package:afk_admin/screens/termin_list_screen.dart';
import 'package:afk_admin/screens/transakcijski_racun_details.dart';
import 'package:afk_admin/screens/transakcijski_racun_list_screen.dart';
import 'package:afk_admin/screens/trening_details_screen.dart';
import 'package:afk_admin/screens/trening_list_screen.dart';
import 'package:afk_admin/screens/uloga_list_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/screens/plata_list_screen.dart';
import 'package:afk_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:afk_admin/api/client.dart';

import '../models/korisnik.dart';
import '../models/search_result.dart';
import 'korisnici_editable_screen.dart';

class UpravaScreen extends StatefulWidget {
  Korisnik? korisnik;
  UpravaScreen({this.korisnik, super.key});

  @override
  State<UpravaScreen> createState() => _UpravaScreen();
}

class _UpravaScreen extends State<UpravaScreen>{
  
  final _formKey=GlobalKey<FormBuilderState>();
   final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();
  
final Map<String,dynamic>_initialValue={};

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

Future<String> getUser() async
{
var data=await _korisnikProvider.get(filter: {
    'KorisnickoIme':Authorization.username,
    });
var korisnickoIme= data.result.first.korisnickoIme;
if(korisnickoIme!=null) {
  return korisnickoIme;
} else {
  return 'Nije pronađen';
}
}

  @override
  Widget build(BuildContext context) {

    var izabrani=_korisnikResult?.result.first;
    // TODO: implement build
   return 
    SizedBox(
      height: 500,
    width: 600,
      child: 
      Scaffold(
        appBar: AppBar(
          title: const Text("Početna"),),
          body: Center(
            child: 
            SingleChildScrollView(
              // constraints: const BoxConstraints(maxHeight: 600,maxWidth: 400),
              child: 
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: 
                          Column(
                            children: [
                            const SizedBox(height: 12,),
                            const Text('Aplikacija Fudbalskog Kluba',
                            style: TextStyle(fontSize: 30),), 
                            const SizedBox(height: 12,),
                            Text('Dobrodošli ${Authorization.username}',
                            // Text('Dobrodošli ${_korisnikResult?.result.first.korisnickoIme}',

                            style: const TextStyle(fontSize: 30),),

                              Row(
                                children: [

                                    SizedBox(height: 50, width: 300, child: 
                                                
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => PlatumListScreen()
                                  ),
                                  );
                                  }, child: const Text("Idi na Platnu listu")),),
                                 SizedBox(height: 50, width: 300, child: 
                                                
                                      ElevatedButton(onPressed: (){
                                  //     Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //     builder: (context) => PlatumDetailsScreen()
                                  //     ),
                                  // );
                                  }, child: const Text("Idi na 'Najbolji igrači'")))
                                ]
                              ),


                              Row(children: [
                                SizedBox(height: 50, width: 300, child: 
                                                
                                      ElevatedButton(onPressed: (){
                                      Navigator.of(context).push(
                                      MaterialPageRoute(
                                      builder: (context) => TransakcijskiRacunListScreen()
                                      ),
                                  );
                                  }, child: const Text("Idi na Transakcijske račune")),),
                                SizedBox(height: 50, width: 300, child: 
                                                
                                      ElevatedButton(onPressed: (){
                                      Navigator.of(context).push(
                                      MaterialPageRoute(
                                      builder: (context) => TransakcijskiRacunDetailsScreen()
                                      ),
                                  );
                                  }, child: const Text("Dodaj novi Transakcijski račun")),),
                              ]
                              ),
                             
                            ],
                          ),
                        
                      ),
                    Row(
                      children: [
                       SizedBox(height: 50, width: 300, child: 
                                            
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => TerminListScreen()
                                  ),
                              );
                              
                              }, child: const Text("Idi na Termin")),),
                                            
                              SizedBox(height: 50, width: 300, child: 
                                            
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => TerminDetailsScreen()
                                  ),
                              );
                              }, child: const Text("Dodaj novi Termin")),),
                      ]
                    ),
                    Row(children: [
                            SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => ClanarinaListScreen()
                              ),
                          );
                          }, child: const Text("Idi na Članarina")),),
                          
                         SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => ClanarinaDetailsScreen()
                              ),
                          );
                          }, child: const Text("Dodaj novu Članarinu")),  ),
        
                    ]
                    ),
                    Row(children: [
                           SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => PozicijaListScreen()
                              ),
                          );
                          }, child: const Text("Idi na Pozicije")),),
                          
                          SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => PozicijaDetailsScreen()
                              ),
                          );
                          }, child: const Text("Dodaj novu Poziciju")),  ),
                      ],
                    ),

                    Row(children: [
                         SizedBox(height: 50, width: 300, child: 
                                            
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => TreningListScreen()
                                  ),
                              );
                              }, child: const Text("Idi na Treninge")),),
                              
                              SizedBox(height: 50, width: 300, child: 
                                            
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => TreningDetailsScreen()
                                  ),
                              );
                              }, child: const Text("Dodaj novi Trening")), ),
                      ],
                    ),
                      
                    Row(
                      children: [
                         SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => StatistikaListScreen()
                              ),
                          );
                          }, child: const Text("Idi na Statistike")),),
                          
                         SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => StatistikaDetailsScreen()
                              ),
                          );
                          }, child: const Text("Dodaj novu Statistiku")), ),
                      ]
                    ),

                          Row(children: [

                          SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => UlogaListScreen()
                              ),
                          );
                          }, child: const Text("Idi na Uloge")),),
                          
                          SizedBox(height: 50, width: 300, child: 
                                        
                              ElevatedButton(onPressed: (){
                              Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => const KorisniciEditableScreen()
                              ),
                          );
                          }, child: const Text("Idi na Korisnike")), ),
                      ],
                    )
                    ]),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

}