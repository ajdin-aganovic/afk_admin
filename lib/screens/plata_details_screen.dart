import 'package:afk_admin/models/korisnici.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/models/tip_korisnika.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:afk_admin/providers/korisnici_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:afk_admin/providers/tip_korisnika_provider.dart';
import 'package:provider/provider.dart';

import '../models/plata.dart';
import '../models/uloga.dart';

class PlataDetailsScreen extends StatefulWidget {

  Plata? plata;

  PlataDetailsScreen({this.plata, super.key});

  @override
  State<PlataDetailsScreen> createState() => _PlataDetailsScreenState();
}

class _PlataDetailsScreenState extends State<PlataDetailsScreen> {

  final _formKey=GlobalKey<FormBuilderState>();

  Map<String,dynamic>_initialValue={};

  late UlogaProvider _ulogaProvider;
  late KorisniciProvider _korisniciProvider;
  late TipKorisnikaProvider _tipKorisnikaProvider;

  SearchResult<Uloga>? _ulogaResult;
  SearchResult<TipKorisnika>? _tipKorisnikaResult;
  SearchResult<Korisnici>? _korisniciResult;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _initialValue= {
  'plataId':widget.plata?.plataId.toString(),
  'iznos':widget.plata?.iznos.toString(),
  'korisnikId':widget.plata?.korisnikId.toString(),
  'stateMachine': widget.plata?.stateMachine, 
  'datumSlanja':widget.plata?.datumSlanja.toString(),
  };

  _ulogaProvider=context.read<UlogaProvider>();
    _korisniciProvider=context.read<KorisniciProvider>();
    _tipKorisnikaProvider=context.read<TipKorisnikaProvider>();

  initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    
    // if(widget.plata != null)
    // {
    //   setState(() {
    //     _formKey.currentState?.patchValue({
    //         'statemachine':widget.plata?.stateMachine
    //     });
        
    //   });
    // }
  }


  Future initForm()async{
      _ulogaResult=await _ulogaProvider.get();
      print(_ulogaResult);
      _tipKorisnikaResult=await _tipKorisnikaProvider.get();
      print(_tipKorisnikaResult);
      _korisniciResult=await _korisniciProvider.get();
      print(_korisniciResult);
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: 'Plata ID: ${widget.plata?.plataId.toString()}+ KorisnikID: ${widget.plata?.korisnikId.toString()}' ?? "Plata details",
      child: buildForm(),
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
                            decoration: const InputDecoration(labelText: "Iznos plate (KM)"), 
                
                name: 'iznos',
                
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
                            decoration: const InputDecoration(labelText: "Status plate"), 

                name: 'stateMachine',
                
            ),
          ),
          Expanded(
            child: FormBuilderTextField (
                            decoration: const InputDecoration(labelText: "Datum slanja"), 

                name: 'datumSlanja',
                
            ),
          ),
          ],
          ),
        ),
      
    );
  }
}