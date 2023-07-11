import 'package:afk_admin/models/platum.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/models/transakcijski_racun.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/termin_provider.dart';
import 'package:afk_admin/providers/transakcijski_racun_provider.dart';
import 'package:afk_admin/screens/termin_list_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../models/korisnik.dart';
import '../models/termin.dart';
import '../models/uloga.dart';

class TerminDetailsScreen extends StatefulWidget {
  Korisnik?korisnik;
  Termin? termin;

  TerminDetailsScreen({this.termin,this.korisnik, super.key});

  @override
  State<TerminDetailsScreen> createState() => _TerminDetailsScreen();
}

class _TerminDetailsScreen extends State<TerminDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late TerminProvider _terminProvider;
  SearchResult<Termin>? _terminResult;
  // bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var godina=DateTime.now().year;
    var mjesec=DateTime.now().month;
    var dan=DateTime.now().day;
  _initialValue= {
    'terminId':widget.termin?.terminId.toString()??"0",
    'sifraTermina':widget.termin?.sifraTermina??"---",
    'tipTermina': widget.termin?.tipTermina??"---", 
    'stadionId':widget.termin?.stadionId.toString()??"0",
    'datumTermina':widget.termin?.datumTermina.toString()??DateTime(godina, mjesec, dan).toString(),
  };

    _terminProvider=context.read<TerminProvider>(); 

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
    _terminResult=await _terminProvider.get();
      
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Termin ID: ${widget.termin?.terminId}' ?? "Termin detalji",
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
                decoration: const InputDecoration(labelText: "Termin ID"), 

                name: 'terminId',
                
                    ),
            ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Šifra termina"), 
                
                name: 'sifraTermina',
            ),
          ),   //od prije ID što radi
          // Expanded(
          //   child: FormBuilderDropdown<String> (
          //     name: 'transakcijskiRacunId',
          //     decoration: InputDecoration
          //       ( labelText: "Transakcijski Racun Id",
          //         suffix: IconButton(icon: const Icon(Icons.close),
          //       onPressed: (){
          //         _formKey.currentState!.fields['transakcijskiRacunId']?.reset();
          //       },
          //       ),
          //       hintText: 'Select Račun',
          //       ), 
          //       items: _transakcijskiRacunResult?.result
          //       .map((item) => DropdownMenuItem(
          //         alignment: AlignmentDirectional.center,
          //         value: item.transakcijskiRacunId.toString(),
          //         child: Text(item.brojRacuna ?? ""),
          //         ))
          //         .toList() ?? [],
          //   ),
          // ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Tip termina"), 

                name: 'tipTermina',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Stadion ID"), 
                name: 'stadionId',
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Datum termina"), 
                name: 'datumTermina',
            ),
          ),
          
          ElevatedButton(onPressed: () async{
                _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                print(_formKey.currentState?.value);
                try{
                  if(widget.termin==null) {
                    await _terminProvider.insert(_formKey.currentState?.value);
                  } else {
                    await _terminProvider.update(widget.termin!.terminId!, _formKey.currentState?.value);
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      // builder: (context) => HomePage(naziv: username,),
                      builder: (context) => TerminListScreen(),

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
              }, child: Text("Save"))
          ],
          ),
        ),
      
    );
  }
}