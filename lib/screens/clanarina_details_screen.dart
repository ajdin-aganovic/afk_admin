
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/clanarina_provider.dart';
import 'package:afk_admin/screens/clanarina_list_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';

import '../models/korisnik.dart';
import '../models/clanarina.dart';
import '../providers/korisnik_provider.dart';

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

  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? _korisnikResult;

  late ClanarinaProvider _clanarinaProvider;
  SearchResult<Clanarina>? _clanarinaResult;
  // bool isLoading=true;

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

  String? vratiBoolVrijednost(bool? vrijednost)
  {
    if(vrijednost==true)
      return 'Placena';
    else
      return 'Nije placena';
  }

  _initialValue= {
    'clanarinaId':widget.clanarina?.clanarinaId.toString()??"0",
    'korisnikId':widget.clanarina?.korisnikId.toString()??"2",
    'iznosClanarine': widget.clanarina?.iznosClanarine.toString()??"---", 
    'dug':widget.clanarina?.dug.toString()??"0",
    'datumPlacanja':widget.clanarina?.datumPlacanja!.toString()??defaultDate,
    'placena':widget.clanarina?.placena??false,
  };

    _clanarinaProvider=context.read<ClanarinaProvider>(); 
    _korisnikProvider=context.read<KorisnikProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
    _clanarinaResult=await _clanarinaProvider.get();
    _korisnikResult=await _korisnikProvider.get();
      
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
              child: 
                FormBuilderDropdown(
                      name: 'korisnikId',
                      decoration: const InputDecoration(labelText: 'Korisnik'),
                      items: 
                      List<DropdownMenuItem>.from(
                        _korisnikResult?.result.map(
                          (e) => DropdownMenuItem(
                            value: e.korisnikId.toString(),
                            child: Text(e.korisnickoIme??"Nema imena"),
                            )).toList()??[]),

                      onChanged: (value) {
                        setState(() {
                          
                          print("Odabrana $value");
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo Vas unesite Ulogu';
                        }
                        return null;
                      },
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
          
          Expanded(
              child:
              FormBuilderDropdown(
                      name: 'placena',
                      decoration: const InputDecoration(labelText: 'Placena'),
                      items: const[ 
                        DropdownMenuItem(value: true, child: Text('Da'),), 
                        DropdownMenuItem(value: false, child: Text('Ne'),), 
                      ],
                      onChanged: (value) {
                        setState(() {
                          // widget.korisnik?.strucnaSprema = value!.toString();
                          widget.clanarina?.placena=value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo Vas unesite da li je placena clanarina!';
                        }
                        return null;
                      },
                    ),
            ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Datum placanja", 
                          ), 
                          name: 'datumPlacanja',
                      ),
                    ),

          ElevatedButton(onPressed: () async{
                // _formKey.currentState?.saveAndValidate();
                setState(() {});
              }, child: const Text("Osvježi podatke")),
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
                    builder: (context) => ClanarinaListScreen(),
                  ),
                );
              }, child: const Text("Sve članarine")),
              ElevatedButton(onPressed: () async{
                  showDialog(context: context, builder: (BuildContext context) => 
                    AlertDialog(
                      title: const Text("Upozorenje!!!"),
                      content: Text("Da li ste sigurni da želite izbrisati članarinu ${widget.clanarina!.clanarinaId}?"),
                      actions: [
                        
                        TextButton(onPressed: () async =>{
                          
                          await _clanarinaProvider.delete(widget.clanarina!.clanarinaId!),

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ClanarinaListScreen(),
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