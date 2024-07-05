import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:afk_admin/screens/uloga_details_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../models/uloga.dart';
import '../utils/util.dart';

class UlogaListScreen extends StatefulWidget {
  Korisnik?korisnik;
  UlogaListScreen({this.korisnik, super.key});

  @override
  State<UlogaListScreen> createState() => _UlogaListScreen();
}

class _UlogaListScreen extends State<UlogaListScreen> {
  late UlogaProvider _ulogaProvider;
  SearchResult<Uloga>? result;

  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();


  @override void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _ulogaProvider=context.read<UlogaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Lista uloga"),
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
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(onPressed:() async{
                
            var data=await _ulogaProvider.get(
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
                child: DataTable(
                    columns: const [
                        // DataColumn(label: Expanded(
                        // child: Text("ID",
                        // style: TextStyle(fontStyle: FontStyle.italic),),
                        
                        // ),
                        // ),
        
                        DataColumn(label: Expanded(
                        child: Text("Naziv uloge",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),
        
                        DataColumn(label: Expanded(
                        child: Text("Podtip uloge",
                        style: TextStyle(fontStyle: FontStyle.italic),),
                        ),
                        ),
        
                        ],
        
                  rows: 
                    result?.result.map((Uloga e) => DataRow(
                      onSelectChanged: (yxc)=>{
                        if((Authorization.ulogaKorisnika=="Administrator")&&yxc==true)
                          {
                            print('odabrana: ${e.ulogaId}'),
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> UlogaDetailsScreen(uloga: e,)
                              )
                          ) 
                          }
                        else
                        {
                          showDialog(context: context, builder: (BuildContext context) => 
                            AlertDialog(
                              title: Text("Izabrali ste ${e.ulogaId}"),
                              content: Text("${e.nazivUloge}/${e.podtipUloge}"),
                              actions: [
                                TextButton(onPressed: ()=>{
                                  Navigator.pop(context),
                                }, child: const Text("OK"))
                              ],
                            )),
                        }
                      },
                      cells: [
                      // DataCell(Text(e.ulogaId.toString()??"0")),
                      DataCell(Text(e.nazivUloge??"---")),
                      DataCell(Text(e.podtipUloge??"---")),
        
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
 