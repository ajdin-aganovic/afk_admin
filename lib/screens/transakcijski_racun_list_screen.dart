import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/screens/plata_details_screen.dart';
import 'package:afk_admin/screens/transakcijski_racun_details.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../models/korisnik.dart';
import '../models/platum.dart';
import '../models/transakcijski_racun.dart';
import '../providers/transakcijski_racun_provider.dart';

class TransakcijskiRacunListScreen extends StatefulWidget {
  Korisnik?korisnik;
  TransakcijskiRacunListScreen({this.korisnik, super.key});

  @override
  State<TransakcijskiRacunListScreen> createState() => _TransakcijskiRacunListScreen();
}

class _TransakcijskiRacunListScreen extends State<TransakcijskiRacunListScreen> {
  // late PlatumProvider _platumProvider;
  // SearchResult<Platum>? resultPlatum;
  SearchResult<TransakcijskiRacun>? resultTrans;

  late TransakcijskiRacunProvider _transakcijskiRacunProvider;
  late KorisnikProvider _korisnikProvider;

   
  final TextEditingController _brojRacuna=TextEditingController();

  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();


  @override void didChangeDependencies() {
    super.didChangeDependencies();
    _transakcijskiRacunProvider=context.read<TransakcijskiRacunProvider>();
    // _platumProvider=context.read<PlatumProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Lista transakcijskih računa"),
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            Expanded(
              child: 
              TextField(
                  decoration: 
                  const InputDecoration(labelText: "Pretraga po stanju"), 
                  controller:_brojRacuna,
                ),
            ),
            const SizedBox(width: 8,), 
            ElevatedButton(onPressed:() async{
                
            var data=await _transakcijskiRacunProvider.get(filter: {
              'BrojRacuna':_brojRacuna.text,
            }
            );
        
            setState(() {
              resultTrans=data;
            });
        
            // print("data: ${data.result[0].transakcijskiRacunId}");
          
          
            }, 
            child: const Text("Učitaj podatke")),
        ],
      ),
    
    );
  }

  
  //  int? transakcijskiRacunId;
  // String? brojRacuna;
  // String? adresaPrebivalista;
  // String? nazivBanke;

Widget _buildDataListView() {
  return 
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
                    child: Text("Broj računa",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Adresa prebivališta",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Banka",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    ],

              rows: 
                resultTrans?.result.map((TransakcijskiRacun e) => DataRow(
                  onSelectChanged: (yxc)=>{
                    if(yxc==true)
                    {
                      print('selected: ${e.transakcijskiRacunId}'),
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> TransakcijskiRacunDetailsScreen(transakcijskiRacun: e,)
                          )
                      ) 
                    }
                  },
                  cells: [
                  DataCell(Text(e.transakcijskiRacunId?.toString()??"")),
                  DataCell(Text(e.brojRacuna??"")),
                  DataCell(Text(e.adresaPrebivalista ??"")),
                  DataCell(Text(e.nazivBanke??"")),

                  ]
                )).toList()??[]
              
              ),
          ),
        ),
      ),
  );
}
}
 