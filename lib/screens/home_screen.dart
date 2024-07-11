import 'package:afk_admin/screens/igrac_opcije_screen.dart';
import 'package:afk_admin/screens/medicinsko_opcije_screen.dart';
import 'package:afk_admin/screens/proizvod_list_screen.dart';
import 'package:afk_admin/screens/uprava_opcije_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/screens/korisnik_details_screen.dart';
import 'package:afk_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:afk_admin/api/client.dart';

import '../models/korisnik.dart';
import '../models/search_result.dart';
import 'administracija_opcije_screen.dart';

class HomePage extends StatefulWidget {
  final Korisnik? loggovaniUser;
  const HomePage({this.loggovaniUser, super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  
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
      // _korisnikResult=await _korisnikProvider.get();
      _korisnikResult=await _korisnikProvider.get(filter:{
        'KorisnickoIme':Authorization.username
      });

      // print(_korisnikResult);
  }


  @override
  Widget build(BuildContext context) {
    // // var izabrani=_korisnikResult?.result.where((element) => widget.korisnik!.korisnikId==element.korisnikId);
    var izabrani=_korisnikResult?.result.first;
    // var izabrani=_korisnikProvider.get();
    // _korisnikResult=_korisnikProvider.get() as SearchResult<Korisnik>?;
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
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: 
                        Column(
                          children: [
                              const SizedBox(height: 12,),
                              const Text('Aplikacija Fudbalskog Kluba',
                              style: TextStyle(fontSize: 30),), 
                              const SizedBox(height: 12,),
                              // Text('Dobrodošli ${widget.loggovaniUser?.korisnickoIme??"nazad"}',
                              Text('Dobrodošli ${Authorization.username}',

                              
                              // Text('Dobrodošli ${widget.korisnik?.korisnickoIme}',
                              style: const TextStyle(fontSize: 30),),
                              const SizedBox(height: 24,),
                                          
      

                              
                            Row(
                              children: [
                                Row(
                                  
                                  children: [
                                    SizedBox(height: 80, width: 200, child: 
                                    
                                    ElevatedButton(onPressed: (){
                                    if(Authorization.ulogaKorisnika=="Administrator"||Authorization.ulogaKorisnika=="Analiticar"
                                    ||Authorization.ulogaKorisnika=="Racunovodja")
                                    // if(1==1)
                                    { 
                                    Navigator.of(context).push(
                                    MaterialPageRoute(
                                    builder: (context) => AdminScreen()
                                    ),
                                    );
                                    }
                                      else
                                      {
                                         showDialog(context: context, builder: (BuildContext context) => 
                                    AlertDialog(
                                      title: const Text("Vi niste administrator."),
                                      content: const Text("Pokušajte ponovo"),
                                      actions: [
                                        TextButton(onPressed: ()=>{
                                          Navigator.pop(context),
                                        }, child: const Text("OK"))
                                      ],
                                    ));
                                      }
                                    }, child: const Text("Idite na administratorski dio")),
                                    
                                    )
                                  ],
                                ),


                                Row(
                                  children: [
                                    SizedBox(height: 80, width: 200, child: 
                                    ElevatedButton(onPressed: (){
                                    if(Authorization.ulogaKorisnika=="Glavni trener"||Authorization.ulogaKorisnika=="Pomocni trener")
                                    // if(1==1)
                           { 
                                    Navigator.of(context).push(
                                    MaterialPageRoute(
                                    builder: (context) => UpravaScreen()
                                    ),
                                    );
                                    }
                                      else
                                      {
                                         showDialog(context: context, builder: (BuildContext context) => 
                                    AlertDialog(
                                      title: const Text("Vi niste uprava."),
                                      content: const Text("Pokušajte ponovo"),
                                      actions: [
                                        TextButton(onPressed: ()=>{
                                          Navigator.pop(context),
                                        }, child: const Text("OK"))
                                      ],
                                    ));
                                      }
                                    }, child: const Text("Idite na upravni dio")),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            
                                 Row(
                                   children: [
                                     Row(
                                       children: [
                                        SizedBox(height: 80, width: 200, child: 
                                         ElevatedButton(onPressed: (){
                            if(Authorization.ulogaKorisnika=="Doktor"||Authorization.ulogaKorisnika=="Bolnicar")
                            // if(1==1)
                           { 
                            Navigator.of(context).push(
                            MaterialPageRoute(
                            builder: (context) => MedicinskoScreen()
                            ),
                            );
                            }
                              else
                              {
                                         showDialog(context: context, builder: (BuildContext context) => 
                            AlertDialog(
                              title: const Text("Vi niste medicinsko osoblje."),
                              content: const Text("Pokušajte ponovo"),
                              actions: [
                                TextButton(onPressed: ()=>{
                                          Navigator.pop(context),
                                }, child: const Text("OK"))
                              ],
                            ));
                              }
                            }, child: const Text("Idite na medicinski dio")),
                                        ),
                                       ],
                                     ),


                           
                          Row(
                            children: [
                              SizedBox(height: 80, width: 200, child: 
                              ElevatedButton(onPressed: (){
                                if(Authorization.ulogaKorisnika=="Igrac"||Authorization.ulogaKorisnika=="Junior")
                                // if(1==1)
                               { 
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => IgracScreen()
                                ),
                                );
                                }
                                  else
                                  {
                                         showDialog(context: context, builder: (BuildContext context) => 
                                          AlertDialog(
                                            title: const Text("Vi niste član."),
                                            content: const Text("Pokušajte ponovo"),
                                            actions: [
                                              TextButton(onPressed: ()=>{
                                                Navigator.pop(context),
                                              }, child: const Text("OK"))
                                            ],
                                          ));
                                  }
                                }, child: const Text("Idite na igrački dio")),
                              ),
                            ],
                          ),
                                   ],
                                 ),

                            
                            
                            Row(
                              children: [
                                SizedBox(height: 80, width: 200, child: 
                                ElevatedButton(onPressed: () async {
                                  
                                  try {
                                    
                                    var data1313=_korisnikProvider.get(filter: {
                                      'KorisnickoIme':Authorization.username
                                    });

                                    setState(() {
                                      _korisnikResult!=data1313;
                                    });

                                    var pronadjeniKorisnik=_korisnikResult!.result.first;
                                  
                                    Navigator.of(context).push(
                                    MaterialPageRoute(
                                    builder: (context) => KorisnikDetailsScreen(korisnik: pronadjeniKorisnik,)
                                    ),
                                    );

                                  } on Exception catch (e) {
                                    showDialog(context: context, builder: (BuildContext context) => 
                                        AlertDialog(
                                          title: const Text("Greška"),
                                          content: Text(e.toString()),
                                          actions: [
                                            TextButton(onPressed: ()=>{
                                              Navigator.pop(context),
                                            }, child: const Text("OK"))
                                          ],
                                        ));
                                  }


                                }, child: const Text("Detalji o računu"),


                                ),

                                
                                ),

                                SizedBox(height: 80, width: 200, child: 
                                  ElevatedButton(onPressed: (){
                                    
                                    Navigator.of(context).push(
                                    MaterialPageRoute(
                                    builder: (context) => ProizvodListScreen()
                                    ),
                                    );
                                    
                                      
                                    }, child: const Text("Idite u Prodavnicu")),
                                  ),
                                
                              ],
                            )
                            
                          ],
                        ),
                      
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

}