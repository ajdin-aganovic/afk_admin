import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/screens/korisnik_details_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
// import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/korisnik.dart';

class KorisniciListScreen extends StatefulWidget {
  // Korisnik? korisnik;
  // Authorization? noviObjekt;
  const KorisniciListScreen({super.key});

  @override
  State<KorisniciListScreen> createState() => _KorisniciListScreen();
}

class _KorisniciListScreen extends State<KorisniciListScreen> {
  late KorisnikProvider _korisniciProvider;
  SearchResult<Korisnik>? result;
  SearchResult<Korisnik>? _korisnikResult;
   
  final TextEditingController _fullNameSearch=TextEditingController();
  final TextEditingController _podUgovorom=TextEditingController();
  final TextEditingController _korisnickoIme=TextEditingController();

  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();

 
  @override void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _korisniciProvider=context.read<KorisnikProvider>();
    
  }

    String? vratiBoolVrijednost(bool? vrijednost)
  {
    if(vrijednost==true)
      return 'Da';
    else
      return 'Ne';
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Lista korisnika"),
      child: Container(
        child: Column(children: [
          _buildSearch(),
          _buildDataListView(),
          
        // ElevatedButton(onPressed: (){
        // Navigator.of(context).push(
        // MaterialPageRoute(
        // builder: (context) => InsertScreen()
        // ),
        //   );
        //   }, child: Text("Add new Korisnik")),
        ],
        ),

        
      )
    );
  }

  Widget _buildSearch(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: 
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
                    Expanded(
                      child: 
                        TextField(
                            decoration: const InputDecoration(labelText: "Pretraga po korisničkom imenu"), 
                            controller:_korisnickoIme,
                          ),
                    ),
              const SizedBox(width: 8,), 

                    Expanded(child:
                    
                          TextField(
                            decoration: const InputDecoration(labelText: "Pretraga po ugovoru"), 
                            controller:_podUgovorom,
                          ),
                    
                    ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                // child:
                    
                //           TextField(
                //             decoration: const InputDecoration(labelText: "Pretraga po stručnoj spremi"), 
                //             controller:_fullNameSearch
                //           ),
                  child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Pretraga po stručnoj spremi"),
              value: _fullNameSearch.text.isNotEmpty ? _fullNameSearch.text : null,
              items: [
                DropdownMenuItem(value: 'SSS', child: Text('SSS')),
                DropdownMenuItem(value: 'VSS', child: Text('VSS')),
                DropdownMenuItem(value: 'BA', child: Text('BA')),
                DropdownMenuItem(value: 'MA', child: Text('MA')),
                DropdownMenuItem(value: '*', child: Text('Bez odabira')),
              ],
              onChanged: (value) {
                setState(() {
                  _fullNameSearch.text = value ?? ''; // Update the controller's text with the selected value
                });
              },
            ),    
                    ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(onPressed:() async{
                  // print("logout successful");
                  
                  var data=await _korisniciProvider.get(filter: {
                    'StrucnaSprema':_fullNameSearch.text,
                    'PodUgovorom':_podUgovorom.text,
                    'KorisnickoIme':_korisnickoIme.text,
                    'Izbrisan':false,
                  }
                  );
          
                  setState(() {
                    result=data;
                  });
          
                  print("podaci: učitani");
          
          
                }, child: const Text("Učitaj podatke")),
      ],
        ),
    
      );
  }

  
  // String? ime;
  // String? prezime;
  // String? email;
  // String? lozinka;
  // String? strucnaSprema;
  // DateTime? datumRodjenja;
  // bool? podUgovorom;
  // DateTime? podUgovoromOd;
  // DateTime? podUgovoromDo;
  // String? korisnickoIme;

  Widget _buildDataListView() {
    return 
    Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
        height: 500,
        width: 1500,
        child: 
            Scrollbar(
              controller: _vertical,
              thumbVisibility: true,
              trackVisibility: true,
              child: Scrollbar(
                controller: _horizontal,
                thumbVisibility: true,
                trackVisibility: true,
                notificationPredicate: (notif) => notif.depth == 1,
                child: SingleChildScrollView(
                  controller: _vertical,
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    controller: _horizontal,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: const [
                    // DataColumn(label: Expanded(
                    //         child: Text("ID",
                    //         style: TextStyle(fontStyle: FontStyle.italic),),
                            
                    //         ),
                    //         ),
        
                            DataColumn(label: Expanded(
                            child: Text("Ime",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Prezime",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Email",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Stručna sprema",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Datum rođenja",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Pod ugovorom",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Pod ugovorom od",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Pod ugovorom do",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Korisničko ime",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
        
                            DataColumn(label: Expanded(
                            child: Text("Uloga",
                            style: TextStyle(fontStyle: FontStyle.italic),),
                            
                            ),
                            ),
                            
        
                      ],
        
                      rows: 
                        result?.result.map((Korisnik e) => DataRow(
                          onSelectChanged: (yxc)=>{
                            if(yxc==true)
                            {
                              print('odabrani: ${e.korisnikId}'),
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=> KorisnikDetailsScreen(korisnik: e,)
                                  )
                              ) 
                            }
                           
                          },
                          cells: [
                          // DataCell(Text(e.korisnikId?.toString()??"")),
                          DataCell(Text(e.ime ??"")),
                          DataCell(Text(e.prezime ??"")),
                          DataCell(Text(e.email ??"")),
                          DataCell(Text(e.strucnaSprema ??"")),
                          DataCell(Text(e.datumRodjenja.toString() ??"")),
                          DataCell(Text(vratiBoolVrijednost(e.podUgovorom) ??"")),
                          DataCell(Text(e.podUgovoromOd.toString() ??"")),
                          DataCell(Text(e.podUgovoromDo.toString() ??"")),
                          DataCell(Text(e.korisnickoIme ??"")),
                          DataCell(Text(e.uloga ??"")),
        
                          ]
                        )).toList()??[]
                      
                      ),
                    
                      ),
                      
                  ),
                  
                ),
              // ),
            ),
                      
        ),
      ),
    );
    
  }
}

