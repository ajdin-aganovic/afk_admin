import 'package:afk_admin/models/korisnik.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/screens/bolest_list_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:afk_admin/screens/korisnik_details_screen.dart';
import 'package:provider/provider.dart';

import '../models/platum.dart';
import '../models/uloga.dart';

class KorisnikDetailsScreen extends StatefulWidget {

  Korisnik? korisnik;

  KorisnikDetailsScreen({this.korisnik, super.key});

  @override
  State<KorisnikDetailsScreen> createState() => _KorisnikDetailsScreen();
}

class _KorisnikDetailsScreen extends State<KorisnikDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late KorisnikProvider _korisnikProvider;
  

  SearchResult<Korisnik>? _korisnikResult;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  _initialValue= {
  'korisnikId' : widget.korisnik?.korisnikId.toString(),
  'ime':widget.korisnik?.ime,
  'prezime':widget.korisnik?.prezime,
  'korisnickoIme':widget.korisnik?.korisnickoIme,
  'email':widget.korisnik?.email,
  'lozinkaHash':widget.korisnik?.lozinkaHash,
  'lozinkaSalt':widget.korisnik?.lozinkaSalt,
  'strucnaSprema':widget.korisnik?.strucnaSprema,
  'datumRodjenja':widget.korisnik?.datumRodjenja.toString(),
  'podUgovorom':widget.korisnik?.podUgovorom.toString(),
  'podUgovoromOd':widget.korisnik?.podUgovoromOd.toString(),
  'podUgovoromDo':widget.korisnik?.podUgovoromDo.toString(),
  };

  _korisnikProvider=context.read<KorisnikProvider>();

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
      _korisnikResult=await _korisnikProvider.get();
      // print(_korisnikResult);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      // ignore: sort_child_properties_last
      title: 'Korisnički ID ${widget.korisnik?.korisnikId}' ?? "Korisnici details",
      child: 
        // Row(children: [
        buildForm(),
        // zaboravljenPassword()

        // ],)
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
                decoration: const InputDecoration(labelText: "KorisnikID"), 
                readOnly: true,
                name: 'korisnikId',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Ime"), 
                readOnly: true,
                name: 'ime',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Prezime"), 
                readOnly: true,

                name: 'prezime',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Korisničko ime"), 
                readOnly: true,

                name: 'korisnickoIme',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Email"), 
                readOnly: true,

                name: 'email',
                
            ),
          ),
          // Expanded(
          //   child: FormBuilderTextField (
          //       decoration: const InputDecoration(labelText: "Password"), 

          //       name: 'password',
                
          //   ),
          // ),
          // Expanded(
          //   child: FormBuilderTextField (
          //       decoration: const InputDecoration(labelText: "PasswordPotvrda"), 
                
          //       name: 'passwordPotvrda',
                
          //   ),
          // ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Stručna sprema"), 
                readOnly: true,

                name: 'strucnaSprema',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Datum rođenja"), 
                readOnly: true,

                name: 'datumRodjenja',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Pod ugovorom"), 
                readOnly: true,

                name: 'podUgovorom',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Pod ugovorm od"), 
                readOnly: true,

                name: 'podUgovoromOd',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Pod ugovorom do"), 
                readOnly: true,

                name: 'podUgovoromDo',
                
            ),
          ),
          
          Padding(padding: EdgeInsets.all(10),
            child:
             FloatingActionButton(onPressed: () async{
              
              _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
              try {
                if(widget.korisnik==null) {
                  await _korisnikProvider.insert(_formKey.currentState?.value);
                } else {
                  await _korisnikProvider.update(widget.korisnik!.korisnikId!, _formKey.currentState?.value);
                }
              } 
              on Exception catch (e) {
                showDialog(context: context, builder: (BuildContext context) => 
                          AlertDialog(
                            title: const Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(onPressed: ()=>{
                                Navigator.pop(context),
                              }, child: const Text("OK"))
                            ],
                          ));
              }
           }, 
           // ignore: prefer_const_constructors
           child: Text("Save")
           ))
          ],
        ),
      ),
          
      
        
    
    );
           
    
  }

FormBuilder zaboravljenPassword() {
  return FormBuilder(child: 
  Text("Dob"));
  }
}