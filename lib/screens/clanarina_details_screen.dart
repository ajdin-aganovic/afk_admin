import 'package:afk_admin/models/platum.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/models/transakcijski_racun.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/clanarina_provider.dart';
import 'package:afk_admin/providers/transakcijski_racun_provider.dart';
import 'package:afk_admin/screens/clanarina_list_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../models/korisnik.dart';
import '../models/clanarina.dart';
import '../models/uloga.dart';

class ClanarinaDetailsScreen extends StatefulWidget {
  Korisnik?korisnik;
  Clanarina? clanarina;

  ClanarinaDetailsScreen({this.clanarina,this.korisnik, super.key});

  @override
  State<ClanarinaDetailsScreen> createState() => _ClanarinaDetailsScreen();
}

class _ClanarinaDetailsScreen extends State<ClanarinaDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late ClanarinaProvider _clanarinaProvider;
  SearchResult<Clanarina>? _clanarinaResult;
  // bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dt=DateTime.now();
    final result = '${dt.year}-${dt.month}-${dt.day} (${dt.hour}:${dt.minute}:${dt.second}})';
  _initialValue= {
    'clanarinaId':widget.clanarina?.clanarinaId.toString()??"0",
    'korisnikId':widget.clanarina?.korisnikId.toString()??"---",
    'iznosClanarine': widget.clanarina?.iznosClanarine.toString()??"---", 
    'dug':widget.clanarina?.dug.toString()??"0",
  };

    _clanarinaProvider=context.read<ClanarinaProvider>(); 

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
    _clanarinaResult=await _clanarinaProvider.get();
      
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Clanarina ID: ${widget.clanarina?.clanarinaId}' ?? "Clanarina detalji",
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
                decoration: const InputDecoration(labelText: "Članarina ID"), 

                name: 'clanarinaId',
                
                    ),
            ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Korisnik ID"), 
                
                name: 'korisnikId',
            ),
          ), 
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Iznos članarine"), 

                name: 'iznosClanarine',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Dug"), 
                name: 'dug',
            ),
          ),
          
          ElevatedButton(onPressed: () async{
                _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                print(_formKey.currentState?.value);
                try{
                  if(widget.clanarina==null) {
                    await _clanarinaProvider.insert(_formKey.currentState?.value);
                  } else {
                    await _clanarinaProvider.update(widget.clanarina!.clanarinaId!, _formKey.currentState?.value);
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClanarinaListScreen(),

                    ),
                            );
                } on Exception catch (err) {
                  showDialog(context: context, builder: (BuildContext context) => 
                          AlertDialog(
                            title: const Text("Error"),
                            content: Text(err.toString()),
                            actions: [
                              TextButton(onPressed: ()=>{
                                Navigator.pop(context),
                              }, child: const Text("OK"))
                            ],
                          ));
                }
              }, child: Text("Save")),
              FloatingActionButton(onPressed: () async{
                // _formKey.currentState?.saveAndValidate();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ClanarinaListScreen(),
                  ),
                );
              }, child: Text("Sve članarine")),
              FloatingActionButton(onPressed: () async{
                showDialog(context: context, builder: (BuildContext context) => 
                          AlertDialog(
                            title: const Text("Error"),
                            content: Text("Are you sure you want to delete the Clanarina?"),
                            actions: [
                              TextButton(onPressed: ()=>{
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ClanarinaListScreen(),
                                  ),
                                )
                              }, child: const Text("Yes")),
                              TextButton(onPressed: ()=>{
                                Navigator.pop(context),
                              }, child: const Text("No")),

                            ],
                          ));
                
              }, child: Text("Izbriši")),
          ],
          ),
        ),
      
    );
  }
}