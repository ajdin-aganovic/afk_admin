import 'package:afk_admin/models/platum.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/models/transakcijski_racun.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/transakcijski_racun_provider.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import '../models/korisnik.dart';
import '../models/uloga.dart';

class PlatumDetailsScreen extends StatefulWidget {
Korisnik?korisnik;
  Platum? platum;

  PlatumDetailsScreen({this.platum, this.korisnik, super.key});

  @override
  State<PlatumDetailsScreen> createState() => _PlatumDetailsScreen();
}

class _PlatumDetailsScreen extends State<PlatumDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late PlatumProvider _platumProvider;
  late TransakcijskiRacunProvider _transakcijskiRacunProvider;

  SearchResult<Platum>? _platumResult;
  SearchResult<TransakcijskiRacun>? _transakcijskiRacunResult;
 
  // bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _initialValue= {
    'plataId':widget.platum?.plataId.toString(),
    'transakcijskiRacunId':widget.platum?.transakcijskiRacunId.toString(),
    'stateMachine': widget.platum?.stateMachine, 
    'iznos':widget.platum?.iznos.toString(),
    'datumSlanja':widget.platum?.datumSlanja.toString()
  };

  _platumProvider=context.read<PlatumProvider>(); 
  _transakcijskiRacunProvider=context.read<TransakcijskiRacunProvider>();

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
      _transakcijskiRacunResult=await _transakcijskiRacunProvider.get();
      _platumResult=await _platumProvider.get();
      // print(_platumResult);
      // print(_transakcijskiRacunResult);

      // setState(() {
      //   isLoading=false;
      // });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Plata ID: ${widget.platum?.plataId}' ?? "Platum details",
      child: buildForm()
      // Column(
      //   children: [
      //     isLoading?Container():buildForm(),
      //     ElevatedButton(onPressed: (){

      //     }, child: Text("Save"))
      //   ],
      // )
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
                decoration: const InputDecoration(labelText: "Plata ID"), 

                name: 'plataId',
                
                    ),
            ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Transakcijski Racun Id"), 
                
                name: 'transakcijskiRacunId',
                
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
                            decoration: const InputDecoration(labelText: "State Machine"), 

                name: 'stateMachine',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Iznos"), 

                name: 'iznos',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Datum Slanja"), 

                name: 'datumSlanja',
                
            ),
          ),
          ElevatedButton(onPressed: () async{
                _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                print(_formKey.currentState?.value);
                try{
                  if(widget.platum==null) {
                    await _platumProvider.insert(_formKey.currentState?.value);
                  } else {
                    await _platumProvider.update(widget.platum!.plataId!, _formKey.currentState?.value);
                  }

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