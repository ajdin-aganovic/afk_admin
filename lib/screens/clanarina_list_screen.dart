import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/clanarina_provider.dart';
import 'package:afk_admin/screens/plata_details_screen.dart';
import 'package:afk_admin/screens/clanarina_details_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../models/korisnik.dart';
import '../models/platum.dart';
import '../models/clanarina.dart';
import '../providers/transakcijski_racun_provider.dart';

class ClanarinaListScreen extends StatefulWidget {
  Korisnik?korisnik;
  ClanarinaListScreen({this.korisnik, super.key});

  @override
  State<ClanarinaListScreen> createState() => _ClanarinaListScreen();
}

class _ClanarinaListScreen extends State<ClanarinaListScreen> {
  late ClanarinaProvider _clanarinaProvider;
  SearchResult<Clanarina>? result;

  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();


  @override void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _clanarinaProvider=context.read<ClanarinaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Lista članarina"),
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
                
            var data=await _clanarinaProvider.get(
            );
        
            setState(() {
              result=data;
              
            });
            }, 
            child: const Text("Load data")),
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
                    DataColumn(label: Expanded(
                    child: Text("ID",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("KorisnikId",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Iznos članarine",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Dug",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),
                    ],

              rows: 
                result?.result.map((Clanarina e) => DataRow(
                  onSelectChanged: (yxc)=>{
                    if(yxc==true)
                    {
                      print('selected: ${e.clanarinaId}'),
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> ClanarinaDetailsScreen(clanarina: e,)
                          )
                      ) 
                    }
                  },
                  cells: [
                  DataCell(Text(e.clanarinaId.toString()??"0")),
                  DataCell(Text(e.korisnikId.toString()??"---")),
                  DataCell(Text(e.iznosClanarine.toString()??"---")),
                  DataCell(Text(e.dug.toString()??"0")),
                  // DataCell(Text(e.datumClanarinaa.toString()??DateTime.now().toString())),

                  ]
                )).toList()??[]
              
              ),
          ),
        ),
      ),
    // ),
  );
}
}
 