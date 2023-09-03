import 'dart:math';

import 'package:afk_admin/screens/korisnici_editable_screen.dart';
import 'package:afk_admin/screens/korisnici_list_screen.dart';
import 'package:afk_admin/screens/password_reset_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../models/korisnik.dart';
import '../models/search_result.dart';
import '../providers/korisnik_provider.dart';

import 'dart:typed_data';
import 'package:crypto/crypto.dart';

import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/widgets/master_screen.dart';
import 'package:intl/intl.dart';

import '../models/korisnik.dart';
import '../models/termin.dart';
import '../models/uloga.dart';


class InsertScreen extends StatefulWidget {
  Korisnik? korisnik;

  InsertScreen(
    // int? korisnikId, 
    {this.korisnik, super.key});
  @override
  _InsertScreenState createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  // final _korisnikIdController = TextEditingController();
  // final _imeController = TextEditingController();
  // final _prezimeController = TextEditingController();
  // final _korisnickoImeController = TextEditingController();
  // final _emailController = TextEditingController();
  final _lozinkaController = TextEditingController();
  final _lozinkaProvjeraController = TextEditingController();
  // final _strucnaSpremaController = TextEditingController();
  // final _datumRodjenjaController = TextEditingController();
  // final _podUgovoromController = TextEditingController();
  // final _podUgovoromOdController = TextEditingController();
  // final _podUgovoromDoController = TextEditingController();
  // final _ulogaController = TextEditingController();
  // Add controllers for other properties of Korisnik
  Map<String,dynamic>_initialValue={};
final ScrollController _vertical = ScrollController();
  late KorisnikProvider _korisnikProvider;
  

  SearchResult<Korisnik>? _korisnikResult;

 @override
  void initState()
  {
     super.initState();
    // if(widget.korisnik?.korisnikId!=null)
    // {
    //   _initialValue={
    //     _korisnikIdController.text : widget.korisnik?.korisnikId.toString(),
    //     _imeController.text:widget.korisnik?.ime,
    //     _prezimeController.text:widget.korisnik?.prezime,
    //     _korisnickoImeController.text:widget.korisnik?.korisnickoIme,
    //     _emailController.text:widget.korisnik?.email,
    //     _strucnaSpremaController.text:widget.korisnik?.strucnaSprema,
    //     _datumRodjenjaController.text:widget.korisnik?.datumRodjenja.toString(),
    //     _podUgovoromController.text:widget.korisnik?.podUgovorom.toString(),
    //     _podUgovoromOdController.text:widget.korisnik?.podUgovoromOd.toString(),
    //     _podUgovoromDoController.text:widget.korisnik?.podUgovoromDo.toString(),
    //     _ulogaController.text:widget.korisnik?.uloga,
    //   };
    // }
    // else
    // {
    //  _datumRodjenjaController.text="";
    //  _podUgovoromOdController.text="";
    //  _podUgovoromDoController.text="";
    // }
    String defaultDate;
    if(DateTime.now().month<10&&DateTime.now().day<10)
      defaultDate="${DateTime.now().year}-0${DateTime.now().month}-0${DateTime.now().day}";
    else if(DateTime.now().day<10)
      defaultDate="${DateTime.now().year}-${DateTime.now().month}-0${DateTime.now().day}";
    else if(DateTime.now().month<10)
      defaultDate="${DateTime.now().year}-0${DateTime.now().month}-${DateTime.now().day}";
    else
      defaultDate="${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

      
    var korisnikHash=widget.korisnik?.lozinkaHash.toString();
    var korisnikSalt=widget.korisnik?.lozinkaSalt.toString();
    if(widget.korisnik==null)
    {_initialValue={
      'korisnikId':"0",
      // 'ime':"",
      // 'prezime':"Unesite prezime",
      // 'email':"Unesite email",
      'strucnaSprema':"No option",
      'datumRodjenja':defaultDate,
      'podUgovorom':false,
      'podUgovoromOd':defaultDate,
      'podUgovoromDo':defaultDate,
      'uloga':"Bez uloge",
      // 'korisnickoIme':"Unesite korisničko ime",
      
    };}
    else
    {_initialValue={
      'korisnikId':widget.korisnik?.korisnikId.toString()??'nema zapisan',
      'ime':widget.korisnik?.ime??'nema zapisan',
      'prezime':widget.korisnik?.prezime??'nema zapisan',
      'email':widget.korisnik?.email.toString()??'nema zapisan',
      'password':widget.korisnik?.lozinkaHash.toString()??'nema zapisan',
      'passwordPotvrda':widget.korisnik?.lozinkaSalt.toString()??'nema zapisan',
      'strucnaSprema':widget.korisnik?.strucnaSprema.toString()??"No option",
      'datumRodjenja':DateFormat('yyyy-MM-dd').format(widget.korisnik!.datumRodjenja!)??defaultDate,
      // 'datumRodjenja':widget.korisnik?.datumRodjenja.toString(),
      'podUgovorom':widget.korisnik?.podUgovorom??true,
      'podUgovoromOd':DateFormat('yyyy-MM-dd').format(widget.korisnik!.podUgovoromOd!)??defaultDate,
      'podUgovoromDo':DateFormat('yyyy-MM-dd').format(widget.korisnik!.podUgovoromDo!)??defaultDate,
      'uloga':widget.korisnik?.uloga.toString()??"Bez uloge",
      'korisnickoIme':widget.korisnik?.korisnickoIme.toString()??'nema zapisan',
      
    };}
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

  FormBuilder buildForm()
  {
    return 
    FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      
        child: 
        Padding(
          padding: const EdgeInsets.all(10.0),
          
          child: 
           SizedBox(
            height: 800,
            width: 900,
            
               child: 
               Column(children: [
                      Expanded(
                        child: FormBuilderTextField (
                          // readOnly: true,
                          decoration: const InputDecoration(labelText: "Korisnik ID"), 
                          
                          name: 'korisnikId',
                          
                              ),
                      ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Ime", hintText:'Unesi ime',), 
                          
                          name: 'ime',
                      ),
                    ),   
                    Expanded(
                      child: FormBuilderTextField (
                                      decoration: const InputDecoration(labelText: "Prezime", 
                                      hintText:'Unesi prezime',), 
                           
                          name: 'prezime',
                          
                      ),
                    ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Korisničko ime",
                          hintText:'Unesi korisničko ime',), 
                          name: 'korisnickoIme',
                      ),
                    ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Email"
                          , hintText:'Unesi email',), 
                          name: 'email',
                      ),
                    ),
                            
                    // Expanded(
                    //   child: FormBuilderTextField (
                    //     controller: _lozinkaController,
                    //       decoration: const InputDecoration(labelText: "Lozinka"), 
                    //       obscureText: true,
                    //       name: 'password',
                    //   ),
                    // ),
                           
                    // Expanded(
                    //   child: FormBuilderTextField (
                    //     controller: _lozinkaProvjeraController,
                    //       decoration: const InputDecoration(labelText: "Potvrdi lozinku"), 
                    //       obscureText: true,
                    //       name: 'passwordPotvrda',
                    //       validator: (value) {
                    //             if (value != _lozinkaController.text) {
                    //               return 'Passwords do not match';
                    //             }
                    //             return null;
                    //           },
                    //   ),
                    // ),
                           
                    Expanded(
                      child:
                      FormBuilderDropdown(
                              name: 'strucnaSprema',
                              decoration: InputDecoration(labelText: 'Stručna sprema'),
                              items: const[ 
                                DropdownMenuItem(value: 'SSS', child: Text('SSS'),), 
                                DropdownMenuItem(value: 'VSS', child: Text('VSS'),), 
                                DropdownMenuItem(value: 'BA', child: Text('BA'),), 
                                DropdownMenuItem(value: 'MA', child: Text('MA'),), 
                                DropdownMenuItem(value: 'No option', child: Text('No option'),), 
                              ],
                              onChanged: (value) {
                                setState(() {
                                  widget.korisnik?.strucnaSprema = value!.toString();
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter the Stručna sprema';
                                }
                                return null;
                              },
                            ),
                    ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Datum rođenja"), 
                          name: 'datumRodjenja',
                      ),
                    ),
                           
                    Expanded(
                      child:
                      FormBuilderDropdown(
                        
                              name: 'podUgovorom',
                              decoration: InputDecoration(labelText: 'Pod ugovorom'),
                              items: const[ 
                                DropdownMenuItem(value: true, child: Text('Yes'),), 
                                DropdownMenuItem(value: false, child: Text('No'),), 
                              ],
                              onChanged: (value) {
                                setState(() {
                                  widget.korisnik?.podUgovorom = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter the Pod ugovorom';
                                }
                                return null;
                              },
                            ),
                    ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Pod ugovorom od"), 
                          name: 'podUgovoromOd',
                      ),
                    ),
                           
                    Expanded(
                      child: FormBuilderTextField (
                          decoration: const InputDecoration(labelText: "Pod ugovorom do"), 
                          name: 'podUgovoromDo',
                      ),
                    ),
                           
                    Expanded(
                      child: 
                       FormBuilderDropdown(
                              name: 'uloga',
                              decoration: InputDecoration(labelText: 'Uloga'),
                              items: const[ 
                                DropdownMenuItem(value: 'Administrator', child: Text('Administrator'),), 
                                DropdownMenuItem(value: 'Glavni trener', child: Text('Glavni trener'),), 
                                DropdownMenuItem(value: 'Pomoćni trener', child: Text('Pomoćni trener'),), 
                                DropdownMenuItem(value: 'Igrač', child: Text('Igrač'),), 
                                DropdownMenuItem(value: 'Doktor', child: Text('Doktor'),), 
                                DropdownMenuItem(value: 'Bez uloge', child: Text('Bez uloge'),), 
                              ],
                              onChanged: (value) {
                                setState(() {
                                  widget.korisnik?.uloga = value!.toString();
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter the Uloga';
                                }
                                return null;
                              },
                            ),
                    ),
             
                    Expanded(child: 
                    Row(children: [
             
                    ElevatedButton(onPressed: () async{
                        String generateSalt() {
                                final random = Random.secure();
                                final List<int> saltBytes = List<int>.generate(16, (_) => random.nextInt(256));
                                return base64Encode(saltBytes);
                                }
                            
                        String generateHash(String password, String salt) {
                        // final salt=generateSalt();
                        final src = base64.decode(salt);
                        final bytes = utf8.encode(password);
                        final dst = Uint8List(src.length + bytes.length);
                    
                        dst.setAll(0, src);
                        dst.setAll(src.length, bytes);
                    
                        final algorithm = sha1;
                        final inArray = algorithm.convert(dst).bytes;
                        return base64.encode(inArray);
                      }
                            
                          String lozinkaOdozgo=_lozinkaController.text;
                          String novaSalt=generateSalt();
                          String novaHash=generateHash(lozinkaOdozgo, novaSalt);
                          _formKey.currentState?.saveAndValidate(focusOnInvalid: false);
                          print(_formKey.currentState?.value);
                          print("${novaHash}");
                           
                            
                            
                          try{
                            if(widget.korisnik==null) {
                              await _korisnikProvider.insert(_formKey.currentState?.value);
                            } else {
                              await _korisnikProvider.update(widget.korisnik!.korisnikId!, _formKey.currentState?.value);
                            }
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                // builder: (context) => HomePage(naziv: username,),
                                builder: (context) => KorisniciEditableScreen(),
                           
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



                        ElevatedButton(onPressed: () async{
                        // _formKey.currentState?.saveAndValidate();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => KorisniciEditableScreen(),
                          ),
                        );
                      }, child: Text("Svi korisnici")),



                      ElevatedButton(onPressed: () async{
                        showDialog(context: context, builder: (BuildContext context) => 
                                  AlertDialog(
                                    title: const Text("Warning!!!"),
                                    content: Text("Are you sure you want to delete ${widget.korisnik!.korisnickoIme}?"),
                                    actions: [
                                      
                                      TextButton(onPressed: () async =>{
                                        
                                        await _korisnikProvider.delete(widget.korisnik!.korisnikId!),

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => KorisniciEditableScreen(),
                                          ),
                                        )
                                    

                                      }, child: const Text("Yes")),
                                      TextButton(onPressed: ()=>{
                                        Navigator.pop(context),
                                      }, child: const Text("No")),
                            
                                    ],
                                  ));
                        
                      }, child: Text("Izbriši")),



                      ElevatedButton(onPressed: () async{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PasswordAdmin(korisnik: widget.korisnik,),
                          ),
                        );
                        
                      }, child: Text("Change password")),
             
             
                    ],))
                    
                    ],
                    
                 
               
             ),
           ),
            
          
        ),
      
    );
  }

  @override
  Widget build(BuildContext context) {
  
    return 
    
    MasterScreenWidget(
      title: 'Insert new korisnik',
      child: 
       buildForm()
      
      );
  }

  Future<void> insertKorisnik(Korisnik korisnik) async {
  final url = Uri.parse('https://localhost:7181/Korisnik/');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(korisnik.toJson()),
  );

  if (response.statusCode > 199 && response.statusCode<300) {
    // Insert operation successful
    print('Insert operation successful: ${response.body} ${response.statusCode}');
  } else {
    // Insert operation failed
    print('Insert operation failed: ${response.body} ${response.statusCode}');
  }
}

}