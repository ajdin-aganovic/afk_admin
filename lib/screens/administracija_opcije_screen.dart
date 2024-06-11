import 'package:afk_admin/screens/clanarina_details_screen.dart';
import 'package:afk_admin/screens/clanarina_list_screen.dart';
import 'package:afk_admin/screens/korisnici_editable_screen.dart';
import 'package:afk_admin/screens/plata_details_screen.dart';
import 'package:afk_admin/screens/pozicija_details_screen.dart';
import 'package:afk_admin/screens/pozicija_list_screen.dart';
import 'package:afk_admin/screens/proizvod_details_screen.dart';
import 'package:afk_admin/screens/proizvod_list_screen.dart';
import 'package:afk_admin/screens/stadion_details_screen.dart';
import 'package:afk_admin/screens/stadion_screen.dart';
import 'package:afk_admin/screens/statistika_details_screen.dart';
import 'package:afk_admin/screens/statistika_list_screen.dart';
import 'package:afk_admin/screens/transakcijski_racun_details.dart';
import 'package:afk_admin/screens/transakcijski_racun_list_screen.dart';
import 'package:afk_admin/screens/uloga_details_screen.dart';
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
import 'korisnik_dodaj_screen.dart';
import 'lista_igraca_screen.dart';

class AdminScreen extends StatefulWidget {
  Korisnik? korisnik;
  AdminScreen({this.korisnik, super.key});

  @override
  State<AdminScreen> createState() => _AdminScreen();
}

class _AdminScreen extends State<AdminScreen>{
  
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
    // // var izabrani=_korisnikResult?.result.where((element) => widget.korisnik!.korisnikId==element.korisnikId);
    // var izabrani=_korisnikResult?.result.where((element) => _korisnikResult!.result.first.korisnickoIme==element.korisnickoIme)??_korisnikResult?.result.first;
   
    // if(izabrani==null)
    //  { izabrani=_korisnikResult?.result.first;}
    // var izabrani=getUser();
    
    // if(izabrani?.korisnickoIme!=Authorization.username)
    //   {
    //     izabrani;
    //   }

    // var izabrani=_korisnikProvider.get();
    // _korisnikResult=_korisnikProvider.get() as SearchResult<Korisnik>?;

    var izabrani=_korisnikResult?.result.first;
    // TODO: implement build
   return 
    Expanded(
      child: SizedBox(
        height: 700,
      width: 600,
        child: 
        Scaffold(
          appBar: AppBar(
            title: const Text("Home"),),
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
                                    }, child: const Text("Go to Platna lista")),
                                      ),
                                                  
      
      
                                   SizedBox(height: 50, width: 300, child:
                                   
                                        ElevatedButton(onPressed: (){
                                        Navigator.of(context).push(
                                        MaterialPageRoute(
                                        builder: (context) => PlatumDetailsScreen()
                                        ),
                                    );
                                    }, child: const Text("Add new Platna lista")),
                                   ),
                                                  
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
                                    }, child: const Text("Go to Transakcijski račun")),
                                   ),
                                                  
      
                                  SizedBox(height: 50, width: 300, child: 
                                        ElevatedButton(onPressed: (){
                                        Navigator.of(context).push(
                                        MaterialPageRoute(
                                        builder: (context) => TransakcijskiRacunDetailsScreen()
                                        ),
                                    );
                                    }, child: const Text("Add new Transakcijski račun")),
                                  
                                  ),
                                                  
                                ]
                                ),
                                Row(
                                  children:[
                                    SizedBox(height: 50, width: 300, child: 
                                    
                                        ElevatedButton(onPressed: (){
                                        Navigator.of(context).push(
                                        MaterialPageRoute(
                                        builder: (context) => const KorisniciEditableScreen()
                                        ),
                                    );
                                    }, child: const Text("Go to Korisnici lista")),
                                    ),
                                                  
      
                                    SizedBox(height: 50, width: 300, child: 
                                    
                                        ElevatedButton(onPressed: (){
                                        Navigator.of(context).push(
                                        MaterialPageRoute(
                                        builder: (context) => DodajScreen()
                                        ),
                                    );
                                    }, child: const Text("Add new Korisnik")),
                                    ),
                                                  
                                    
                                  ],
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
                                builder: (context) => StadionListScreen()
                                ),
                            );
                            }, child: const Text("Go to Stadion")),
                          ),
                                          
                            
                            SizedBox(height: 50, width: 300, child: 
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => StadionDetailsScreen()
                                ),
                            );
                            }, child: const Text("Add new Stadion")),
                            ),
                                          
      
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
                            }, child: const Text("Go to Članarina")),
                              ),
                                          
                            
                           SizedBox(height: 50, width: 300,child: 
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => ClanarinaDetailsScreen()
                                ),
                            );
                            }, child: const Text("Add new Članarina")),  
                           
                           ),
                                          
          
                      ]
                      ),
                      Row(children: [
                             SizedBox(height: 50, width: 300,child: 
                             
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => PozicijaListScreen()
                                ),
                            );
                            }, child: const Text("Go to Pozicija")),
                             ),
                                          
                            
                            SizedBox(height: 50, width: 300,child: 
                            
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => PozicijaDetailsScreen()
                                ),
                            );
                            }, child: const Text("Add new Pozicija")),  
                            
                            ),
                                          
                        ],
                      ),
                        
                      Row(
                        children: [
                           SizedBox(height: 50, width: 300,child: 
                           
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => StatistikaListScreen()
                                ),
                            );
                            }, child: const Text("Go to Statistika")),
                           ),
                                          
                            
                            SizedBox(height: 50, width: 300, child:
                            
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => StatistikaDetailsScreen()
                                ),
                            );
                            }, child: const Text("Add new Statistika")), 
                            
                            ),
                                          
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
                            }, child: const Text("Go to Uloga")),
                            
                            ),
                                          
                            
                            SizedBox(height: 50, width: 300,child: 
                            
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => UlogaDetailsScreen()
                                ),
                            );
                            }, child: const Text("Add new Uloga")), 
                            ),
                                          
                        ],
                      ),
                      Row(children: [
      
                            SizedBox(height: 50, width: 300, child:
                            
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => const ListaIgracaScreen()
                                ),
                            );
                            }, child: const Text("Go to Lista igrača po pozicijama")),
                            
                            ),
      
                            SizedBox(height: 50, width: 300, child:
                            
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => ProizvodDetailsScreen()
                                ),
                            );
                            }, child: const Text("Add new Proizvod")),
                            
                            ),                
                        ],
                      ),
                      Row(children: [
                        
                            SizedBox(height: 50, width: 300, child:
                            
                                ElevatedButton(onPressed: (){
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => ProizvodListScreen()
                                ),
                            );
                            }, child: const Text("Go to lista Proizvoda")),
                            
                            ),  
                      ],)
                             
                      ]),
                    ],
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

}