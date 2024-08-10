import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/termin_provider.dart';
import 'package:afk_admin/screens/termin_list_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../models/stadion.dart';
import '../models/termin.dart';
import '../providers/stadion_provider.dart';

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
  
  late StadionProvider _stadionProvider;
  SearchResult<Stadion>? stadionResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

String defaultDate;
    if(DateTime.now().month<10&&DateTime.now().day<10) {
      defaultDate="${DateTime.now().year}-0${DateTime.now().month}-0${DateTime.now().day}";
    } else if(DateTime.now().day<10)
      defaultDate="${DateTime.now().year}-${DateTime.now().month}-0${DateTime.now().day}";
    else if(DateTime.now().month<10)
      defaultDate="${DateTime.now().year}-0${DateTime.now().month}-${DateTime.now().day}";
    else
      defaultDate="${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

      

  _initialValue= {
    'terminId':widget.termin?.terminId.toString()??"0",
    'sifraTermina':widget.termin?.sifraTermina??"---",
    'tipTermina': widget.termin?.tipTermina??"Drugo", 
    'stadionId':widget.termin?.stadionId.toString()??"1",
    'rezultat':widget.termin?.rezultat.toString()??"-",
    'datum':widget.termin?.datum!.toIso8601String()??'GGGG-MM-DD'
    // 'datum':widget.termin!=null?widget.termin?.datum!.toIso8601String():'GGGG-MM-DD'
  };

    _terminProvider=context.read<TerminProvider>(); 
    _stadionProvider=context.read<StadionProvider>();
  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
    _terminResult=await _terminProvider.get();
    stadionResult=await _stadionProvider.get();
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
          Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Datum termina", 
                prefixIcon: Icon(Icons.date_range)
                ), 
                name: 'datum',
            ),
          ),
          Expanded(
              child:
              FormBuilderDropdown(
                      name: 'tipTermina',
                      decoration: const InputDecoration(labelText: 'Tip termina'),
                      items: const[ 
                        DropdownMenuItem(value: 'Domaca utakmica', child: Text('Domaca utakmica'),), 
                        DropdownMenuItem(value: 'Gostujuca utakmica', child: Text('Gostujuca utakmica'),), 
                        DropdownMenuItem(value: 'Opsti pregled', child: Text('Opsti pregled'),), 
                        DropdownMenuItem(value: 'Neutralni teren', child: Text('Neutralni teren'),), 
                        DropdownMenuItem(value: 'Drugo', child: Text('Drugo'),), 
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.korisnik?.strucnaSprema = value!.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo Vas unesite tip termina';
                        }
                        return null;
                      },
                    ),
            ),
          
         Expanded(
              child: 
                FormBuilderDropdown(
                      name: 'stadionId',
                      decoration: const InputDecoration(labelText: 'Stadion'),
                      items: 
                      List<DropdownMenuItem>.from(
                        stadionResult?.result.map(
                          (e) => DropdownMenuItem(
                            value: e.stadionId.toString(),
                            child: Text(e.nazivStadiona??"Nema imena"),
                            )).toList()??[]),

                      onChanged: (value) {
                        setState(() {
                          
                          print("Odabrani $value");
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo Vas unesite Stadion';
                        }
                        return null;
                      },
                    ),
                    ),

                    Expanded(
            child: FormBuilderTextField (
                decoration: const InputDecoration(labelText: "Rezultat termina"), 
                
                name: 'rezultat',
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
                      builder: (context) => TerminListScreen(),

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
                setState(() {
                  
                });
              }, child: const Text("Osvježi podatke")),
              ElevatedButton(onPressed: () async{
                // _formKey.currentState?.saveAndValidate();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TerminListScreen(),
                  ),
                );
              }, child: const Text("Svi termini")),
              ElevatedButton(onPressed: () async{
                  showDialog(context: context, builder: (BuildContext context) => 
                  AlertDialog(
                    title: const Text("Upozorenje!!!"),
                    content: Text("Da li ste sigurni da želite izbrisati termin ${widget.termin!.terminId}?"),
                    actions: [
                      
                      TextButton(onPressed: () async =>{
                        
                        await _terminProvider.delete(widget.termin!.terminId!),

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TerminListScreen(),
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