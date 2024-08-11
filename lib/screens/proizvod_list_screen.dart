import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/proizvod_provider.dart';
import 'package:afk_admin/screens/proizvod_details_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../models/proizvod.dart';
import '../utils/util.dart';

class ProizvodListScreen extends StatefulWidget {
  Korisnik?korisnik;
  ProizvodListScreen({this.korisnik, super.key});

  @override
  State<ProizvodListScreen> createState() => _ProizvodListScreen();
}

class _ProizvodListScreen extends State<ProizvodListScreen> {
  late ProizvodProvider _proizvodProvider;
  SearchResult<Proizvod>? result;

  // late TransakcijskiRacunProvider _transakcijskiRacunProvider;

  final TextEditingController _stateMachine=TextEditingController();
  // final TextEditingController _minIznos=TextEditingController();
  // final TextEditingController _maxIznos=TextEditingController();

  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();


  @override void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _proizvodProvider=context.read<ProizvodProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Lista proizvoda"),
      child: Container(
        child: Column(children: [
          _buildSearch(),
          _buildDataListView(),
          
        ],),

        
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
              // child: 
              // TextField(
              //     decoration: 
              //     const InputDecoration(labelText: "Pretraga po stanju"), 
              //     controller:_stateMachine,
              //   ),
              child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Pretraga po stanju"),
              value: _stateMachine.text.isNotEmpty ? _stateMachine.text : null,
              items: [
                DropdownMenuItem(value: 'active', child: Text('Aktivna')),
                DropdownMenuItem(value: 'draft', child: Text('Nije aktivna')),
              ],
              onChanged: (value) {
                setState(() {
                  _stateMachine.text = value ?? ''; // Update the controller's text with the selected value
                });
              },
            ),
            ), 
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(onPressed:() async{
                
            var data=await _proizvodProvider.get(filter: {
              'StateMachine':_stateMachine.text,
            }
              
            );
        
            setState(() {
              result=data;
              
            });
            }, 
            child: const Text("Učitaj podatke")),
        ],
      ),
    
    );
  }

Widget _buildDataListView() {
  return 
  // SizedBox(
  //   height: 500,
  //   width: 400,
  //   child: 
    Expanded(
      child: SingleChildScrollView(
        child: Scrollbar(
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
                child: 
                DataTable(
                    columns: const [
                        // DataColumn(label: Expanded(
                        // child: Text("ID",
                        // style: TextStyle(fontStyle: FontStyle.italic),),
                        
                        // ),
                        // ),
        
                        DataColumn(label: Expanded(
                        child: Text("Naziv proizvoda",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),
        
                        DataColumn(label: Expanded(
                        child: Text("Kategorija proizvoda",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),

                        DataColumn(label: Expanded(
                        child: Text("Cijena proizvoda",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),

                        DataColumn(label: Expanded(
                        child: Text("Količina proizvoda",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),
        
                        DataColumn(label: Expanded(
                        child: Text("Status proizvoda",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),
        
                        DataColumn(label: Expanded(
                        child: Text("Izmijeni status",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        
                        ),
                        ),
                        ],
        
                  rows: 
                    result?.result.map((Proizvod e) => DataRow(
                      onSelectChanged: (yxc)=>{
                        if((Authorization.ulogaKorisnika=="Administrator"
                        // ||Authorization.ulogaKorisnika=="Glavni trener"
                        )&&yxc==true)
                          {
                            print('odabrani: ${e.proizvodId}'),
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> ProizvodDetailsScreen(proizvod: e,)
                              )
                          ) 
                          }
                        else
                        {
                          showDialog(context: context, builder: (BuildContext context) => 
                            AlertDialog(
                              title: Text("Izabrali ste ${e.proizvodId}"),
                              content: Text("${e.naziv}/${e.kategorija}"),
                              actions: [
                                TextButton(onPressed: ()=>{
                                  Navigator.pop(context),
                                }, child: const Text("OK"))
                              ],
                            )),
                        }
                      },
                      cells: [
                      // DataCell(Text(e.proizvodId.toString()??"0")),
                      DataCell(Text(e.naziv??"---")),
                      DataCell(Text(e.kategorija??"---")),
                      DataCell(Text(e.cijena.toString()??"0")),
                      DataCell(Text(e.kolicina.toString() ??"0")),
                      DataCell(Text(e.stateMachine ??"")),
                      DataCell(const Text("Uredi"), onTap: () async => {
                            if(Authorization.ulogaKorisnika=="Administrator"&&e.stateMachine!.contains("active"))
                            {
                              // Navigator.of(context).push(
                              //       MaterialPageRoute(builder: (context)=> InsertScreen(korisnik: e,)
                              //       )
                              //   ) 
                             await _proizvodProvider.hidePlatum(e.proizvodId!),
                              showDialog(context: context, builder: (BuildContext context) => 
                                  AlertDialog(
                                    title: const Text("Uspješna operacija!"),
                                    content: const Text("Proizvod je deaktiviran"),
                                    actions: [
                                      TextButton(onPressed: ()=>{
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=> ProizvodListScreen()
                                            )
                                        ) 
                                      }, child: const Text("OK"))
                                    ],
                                  )),
                            }
                            else if(Authorization.ulogaKorisnika=="Administrator"&&e.stateMachine!.contains("draft"))
                            {
                               await _proizvodProvider.activatePlatum(e.proizvodId!),
                              showDialog(context: context, builder: (BuildContext context) => 
                                  AlertDialog(
                                    title: const Text("Uspješna operacija!"),
                                    content: const Text("Proizvod je aktiviran"),
                                    actions: [
                                      TextButton(onPressed: ()=>{
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context)=> ProizvodListScreen()
                                            )
                                        ) 
                                      }, child: const Text("OK"))
                                    ],
                                  )),
                            }
                            else
                            {
                              showDialog(context: context, builder: (BuildContext context) => 
                                  AlertDialog(
                                    title: const Text("Upozorenje!"),
                                    content: const Text("Neautorizovani poziv funkcije.\nNemate pravo pristupa ovoj komandi!"),
                                    actions: [
                                      TextButton(onPressed: ()=>{
                                        Navigator.pop(context),
                                      }, child: const Text("OK"))
                                    ],
                                  )),
                            }
                          })
        
                      ]
                    )).toList()??[]
                  
                  ),
              ),
            ),
          ),
        // ),
          ),
      ),
    );
}
}
 