import 'package:afk_admin/screens/bolest_details_screen.dart';
import 'package:afk_admin/screens/bolest_list_screen.dart';
import 'package:afk_admin/screens/termin_details_screen.dart';
import 'package:afk_admin/screens/termin_list_screen.dart';
import 'package:afk_admin/screens/transakcijski_racun_list_screen.dart';
import 'package:afk_admin/screens/trening_details_screen.dart';
import 'package:afk_admin/screens/trening_list_screen.dart';
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

class MedicinskoScreen extends StatefulWidget {
  Korisnik? korisnik;
  MedicinskoScreen({this.korisnik, super.key});

  @override
  State<MedicinskoScreen> createState() => _MedicinskoScreen();
}

class _MedicinskoScreen extends State<MedicinskoScreen>{
  
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
                                  }, child: const Text("Idi na Platne liste")),),
                                 
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
                                  }, child: const Text("Idi na Listu korisnika")),),
                                  
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
                          builder: (context) => TerminListScreen()
                          ),
                      );
                      
                      }, child: const Text("Idi na Termine")),),
                                    
                      SizedBox(height: 50, width: 300, child: 
                                    
                          ElevatedButton(onPressed: (){
                          Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => TerminDetailsScreen()
                          ),
                      );
                      }, child: const Text("Dodaj novi termin")),),

                      ]
                    ),

                    Row(
                                children:[
                                 
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
                              }, child: const Text("Dodaj novi trening")),),
                                  
                                ],
                              ),

                    Row(children: [
                          SizedBox(height: 50, width: 300, child: 
                                            
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => BolestListScreen()
                                  ),
                              );
                              }, child: const Text("Idi na bolesti")),),
                              SizedBox(height: 50, width: 300, child: 
                                            
                                  ElevatedButton(onPressed: (){
                                  Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => BolestDetailsScreen()
                                  ),
                              );
                              }, child: const Text("Dodaj novu bolest")),),
        
                    ]
                    ),
                    
                      
                    

                          
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