import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/stadion_provider.dart';
import 'package:afk_admin/screens/stadion_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../models/stadion.dart';

class StadionDetailsScreen extends StatefulWidget {
  Korisnik?korisnik;
  Stadion? stadion;

  StadionDetailsScreen({this.stadion,this.korisnik, super.key});

  @override
  State<StadionDetailsScreen> createState() => _StadionDetailsScreen();
}

class _StadionDetailsScreen extends State<StadionDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late StadionProvider _stadionProvider;
  SearchResult<Stadion>? _stadionResult;
  // bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dt=DateTime.now();
    final result = '${dt.year}-${dt.month}-${dt.day} (${dt.hour}:${dt.minute}:${dt.second}})';
  _initialValue= {
    'stadionId':widget.stadion?.stadionId.toString()??"0",
    'nazivStadiona':widget.stadion?.nazivStadiona??"---",
    'kapacitetStadiona': widget.stadion?.kapacitetStadiona.toString()??"---", 
  };

    _stadionProvider=context.read<StadionProvider>(); 

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
    _stadionResult=await _stadionProvider.get();
      
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Stadion ID: ${widget.stadion?.stadionId}' ?? "Stadion detalji",
      child: buildForm()
     
      );
  }

  FormBuilder buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Expanded(
              child: FormBuilderTextField (
                // readOnly: true,
                decoration: const InputDecoration(labelText: "Stadion ID"), 

                name: 'stadionId',
                
                    ),
            ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Naziv"), 
                
                name: 'nazivStadiona',
            ),
          ), 
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Kapacitet stadiona"), 

                name: 'kapacitetStadiona',
                
            ),
          ),
          
          ElevatedButton(onPressed: () async{
                _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                print(_formKey.currentState?.value);
                try{
                  if(widget.stadion==null) {
                    await _stadionProvider.insert(_formKey.currentState?.value);
                  } else {
                    await _stadionProvider.update(widget.stadion!.stadionId!, _formKey.currentState?.value);
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StadionListScreen(),

                    ),
                            );
                } on Exception catch (err) {
                  showDialog(context: context, builder: (BuildContext context) => 
                          AlertDialog(
                            title: const Text("Greška"),
                            content: Text(err.toString()),
                            actions: [
                              TextButton(onPressed: ()=>{
                                Navigator.pop(context),
                              }, child: const Text("OK"))
                            ],
                          ));
                }
              }, child: const Text("Snimi")),
              ElevatedButton(onPressed: () async{
                // _formKey.currentState?.saveAndValidate();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StadionListScreen(),
                  ),
                );
              }, child: const Text("Svi stadioni")),
             ElevatedButton(onPressed: () async{
                  showDialog(context: context, builder: (BuildContext context) => 
            AlertDialog(
              title: const Text("Upozorenje!!!"),
              content: Text("Da li ste sigurni da želite izbrisati stadion ${widget.stadion!.stadionId}?"),
              actions: [
                
                TextButton(onPressed: () async =>{
                  
                  await _stadionProvider.delete(widget.stadion!.stadionId!),

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StadionListScreen(),
                    ),
                  )
              

                }, child: const Text("Da")),
                TextButton(onPressed: ()=>{
                  Navigator.pop(context),
                }, child: const Text("Ne")),
      
              ],
            ));
                        
                      }, child: const Text("Izbriši")),
          ],
          ),
        ),
      
    );
  }
}