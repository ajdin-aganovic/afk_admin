import 'package:afk_admin/models/korisnik.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/providers/korisnik_pozicija_provider.dart';
import 'package:afk_admin/screens/korisnici_editable_screen.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:provider/provider.dart';

import '../models/korisnik_pozicija.dart';
import '../models/pozicija.dart';
import '../models/uloga.dart';
import '../providers/pozicija_provider.dart';
import '../utils/util.dart';
import 'home_screen.dart';

class ViseDetaljaScreen extends StatefulWidget {

  Korisnik? korisnik;
  KorisnikPozicija? korisnikPozicija;
  String? usernameKorisnika;
  Uloga? uloga;
  int? korisnikId;

  ViseDetaljaScreen({this.korisnik, this.korisnikId,this.korisnikPozicija, super.key});

  @override
  State<ViseDetaljaScreen> createState() => _ViseDetaljaScreen();
}

class _ViseDetaljaScreen extends State<ViseDetaljaScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? _korisnikResult;

  late PozicijaProvider _pozicijaProvider;
  SearchResult<Pozicija>? _pozicijaResult;
  
  late KorisnikPozicijaProvider _korisnikPozicijaProvider;
  SearchResult<KorisnikPozicija>? _korisnikPozicijaResult;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
    
  // var pronadjeniKorisnik=_korisnikUlogaResult?.result.first;
  // var spremljenaUloga=_ulogaResult?.result.first;


  _initialValue= {
  'korisnikPozicijaId' : widget.korisnikPozicija?.korisnikPozicijaId.toString()??'0',
  'korisnikId' : widget.korisnikPozicija?.korisnikId.toString()??'2',
  'pozicijaId' : widget.korisnikPozicija?.pozicijaId.toString()??"1"
  };

  _korisnikProvider=context.read<KorisnikProvider>();
  _korisnikPozicijaProvider=context.read<KorisnikPozicijaProvider>();
  _pozicijaProvider=context.read<PozicijaProvider>();

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }


  Future initForm()async{
      _korisnikResult=await _korisnikProvider.get();
      _pozicijaResult=await _pozicijaProvider.get();
      _korisnikPozicijaResult=await _korisnikPozicijaProvider.get();
  }

  @override
  Widget build(BuildContext context) {

    return MasterScreenWidget(
      // ignore: sort_child_properties_last
      title: 'Korisnik ${Authorization.username}' ?? "Detalji korisnika",
      child: 
        buildForm(),
       
      );
  }

  Korisnik? getKorisnik(int id)
  {
    var getKorisnikaDetails=_korisnikResult?.result.firstWhere((element) => element.korisnikId==id);
    return getKorisnikaDetails;
  }

  Pozicija? getPozicija(int id)
  {
    var getPozicijaDetails=_pozicijaResult?.result.firstWhere((element) => element.pozicijaId==id);
    return getPozicijaDetails;
  }

  

  FormBuilder buildForm() {
    return 
    FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
        child: 
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: 
          Column(children: [
             Expanded(
              child: FormBuilderTextField (
                // readOnly: true,
                decoration: const InputDecoration(labelText: "KorisnikPozicija ID"), 
                readOnly: true,
                name: 'korisnikPozicijaId',
                
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
                            child: Text("${e.ime} ${e.prezime} / ${e.korisnickoIme}"??"Nema imena"),
                            
                            )).toList()??[]),

                      onChanged: (value) {
                        setState(() {
                          
                          print("Odabrani $value");
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo Vas unesite korisnika';
                        }
                        return null;
                      },
                    ),
                    ),
          Expanded(
              child: 
                FormBuilderDropdown(
                      name: 'pozicijaId',
                      decoration: const InputDecoration(labelText: 'Pozicija'),
                      items: 
                      List<DropdownMenuItem>.from(
                        _pozicijaResult?.result.map(
                          (e) => DropdownMenuItem(
                            value: e.pozicijaId.toString(),
                            child: Text("${e.nazivPozicije} / ${e.kategorijaPozicije}"??"Nema imena"),
                            )).toList()??[]),

                      onChanged: (value) {
                        setState(() {
                          
                          print("Odabrani $value");
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo Vas unesite poziciju';
                        }
                        return null;
                      },
                    ),
                    ),
          
          
            Row(
              children: [
                Column(
                  children: [
                    ElevatedButton(onPressed: () async{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            
                            builder: (context) => const KorisniciEditableScreen(),
                          ),
                        );
                      }, child: const Text("Svi korisnici")),
                  ],
                ),

                Column(
                  children: [
                    ElevatedButton(onPressed: () async{
                        setState(() {
                          
                        });
                      }, child: const Text("Osvježi podatke")),
                  ],
                ),

                  Column(
                    children: [
                      ElevatedButton(onPressed: () async{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }, child: const Text("Početna stranica")),

                      ElevatedButton(onPressed: () async{
                        _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                        print(_formKey.currentState?.value);
                        try{
                          if(widget.korisnikPozicija==null) {
                            await _korisnikPozicijaProvider.insert(_formKey.currentState?.value);
                          } else {
                            await _korisnikPozicijaProvider.update(widget.korisnikPozicija!.korisnikPozicijaId!, _formKey.currentState?.value);
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),

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
                    ],
                  ),
              ],
            ),
              
          ],
        ),
      ),
    );
  }
}