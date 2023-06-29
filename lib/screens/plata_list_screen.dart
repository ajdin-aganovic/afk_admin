import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/plata_provider.dart';
import 'package:afk_admin/screens/plata_details_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
// import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/plata.dart';

class PlataListScreen extends StatefulWidget {
  const PlataListScreen({super.key});

  @override
  State<PlataListScreen> createState() => _PlataListScreenState();
}

class _PlataListScreenState extends State<PlataListScreen> {
  late PlataProvider _plataProvider;
  SearchResult<Plata>? result;
   
  final TextEditingController _statemachinecontroller=TextEditingController();
  final TextEditingController _iznosMaxcontroller=TextEditingController();
  final TextEditingController _iznosMincontroller=TextEditingController();


  @override void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _plataProvider=context.read<PlataProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: const Text("Plata list"),
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
      child: Row(children: [
                    Expanded(
                      child: 
                        TextField(
                            decoration: const InputDecoration(labelText: "Iznos minimalna"), 
                            controller:_iznosMincontroller,
                          ),
                    ),
              const SizedBox(width: 8,), 

                    Expanded(child:
                    
                          TextField(
                            decoration: const InputDecoration(labelText: "Iznos maximalna"), 
                            controller:_iznosMaxcontroller,
                          ),
                    
                    ),
              const SizedBox(
                height: 8,
              ),
              Expanded(child:
                    
                          TextField(
                            decoration: const InputDecoration(labelText: "State machine"), 
                            controller:_statemachinecontroller
                          ),
                    
                    ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(onPressed:() async{
                  print("logout successful");
                  
                  var data=await _plataProvider.get(filter: {
                    'MinIznos':_iznosMincontroller.text,
                    'MaxIznos':_iznosMaxcontroller.text,
                    'StateMachine':_statemachinecontroller.text
                  }
                  );
          
                  setState(() {
                    result=data;
                  });
          
                  print("data: ${data.result[0].stateMachine}");
          
          
                }, child: const Text("Load data")),
      ],
        ),
    
      );
  }

  Widget _buildDataListView() {
    return Expanded(child: SingleChildScrollView(child: DataTable(
                columns: const [
                    DataColumn(label: Expanded(
                    child: Text("ID",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Iznos plate (KM)",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("ID Korisnika",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Status",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    ),
                    ),

                    DataColumn(label: Expanded(
                    child: Text("Datum slanja",
                    style: TextStyle(fontStyle: FontStyle.italic),),
                    
                    ),
                    ),

              ],

              rows: 
                result?.result.map((Plata e) => DataRow(
                  onSelectChanged: (yxc)=>{
                    if(yxc==true)
                    {
                      print('selected: ${e.plataId}'),
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> PlataDetailsScreen(plata: e,)
                          )
                      ) 
                    }
                  },
                  cells: [
                  DataCell(Text(e.plataId?.toString()??"")),
                  DataCell(Text(e.iznos?.toString()??"")),
                  DataCell(Text(e.korisnikId?.toString()??"")),
                  DataCell(Text(e.stateMachine ??"")),
                  DataCell(Text(e.datumSlanja.toString() ??""))

                  ]
                )).toList()??[]
              
              ),
            )
          );
  }
}