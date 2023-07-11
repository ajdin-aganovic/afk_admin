import 'package:afk_admin/models/platum.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/models/transakcijski_racun.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/transakcijski_racun_provider.dart';
import 'package:afk_admin/screens/transakcijski_racun_list_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../models/uloga.dart';

class TransakcijskiRacunDetailsScreen extends StatefulWidget {

  Korisnik?korisnik;
  TransakcijskiRacun?transakcijskiRacun;

  TransakcijskiRacunDetailsScreen({this.transakcijskiRacun, this.korisnik, super.key});

  @override
  State<TransakcijskiRacunDetailsScreen> createState() => _TransakcijskiRacunDetailsScreen();
}

class _TransakcijskiRacunDetailsScreen extends State<TransakcijskiRacunDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late TransakcijskiRacunProvider _transakcijskiRacunProvider;
  late PlatumProvider _platumProvider;

  SearchResult<TransakcijskiRacun>? _transakcijskiRacunResult;
  SearchResult<Platum>? _platumResult;
 
  bool isLoading=true;

  @override
  void initState() {  
    // TODO: implement initState
    super.initState();
  _initialValue= {
    'transakcijskiRacunId':widget.transakcijskiRacun?.transakcijskiRacunId.toString()??"0",
    'brojRacuna':widget.transakcijskiRacun?.brojRacuna??"---",
    'adresaPrebivalista': widget.transakcijskiRacun?.adresaPrebivalista??"---", 
    'nazivBanke':widget.transakcijskiRacun?.nazivBanke??"---",
  };

  _transakcijskiRacunProvider=context.read<TransakcijskiRacunProvider>();
  // _platumProvider=context.read<PlatumProvider>(); 

  initForm();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }


  Future initForm()async{
      _transakcijskiRacunResult=await _transakcijskiRacunProvider.get();
      // _platumResult=await _platumProvider.get();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Broj računa: ${widget.transakcijskiRacun?.brojRacuna}' ?? "Detalji računa",
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
                decoration: const InputDecoration(labelText: "Transakcijski račun ID"), 

                name: 'transakcijskiRacunId',
                
                    ),
            ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Broj računa"), 
                
                name: 'brojRacuna',
                
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
                            decoration: const InputDecoration(labelText: "Adresa prebivališta"), 

                name: 'adresaPrebivalista',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Naziv banke"), 

                name: 'nazivBanke',
                
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(onPressed: () async{
                  _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                  // print(_formKey.currentState?.value);
                  try{
                    if(widget.transakcijskiRacun==null) {
                      await _transakcijskiRacunProvider.insert(_formKey.currentState?.value);
                    } else {
                      await _transakcijskiRacunProvider.update(widget.transakcijskiRacun!.transakcijskiRacunId!, _formKey.currentState?.value);
                    }
                Navigator.of(context).push(
                    MaterialPageRoute(
                      // builder: (context) => HomePage(naziv: username,),
                      builder: (context) => TransakcijskiRacunListScreen(),

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
          )
          ],
          ),
        ),
      
    );
  }
}