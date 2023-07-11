import 'package:afk_admin/main.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:afk_admin/screens/korisnik_details_screen.dart';
import 'package:afk_admin/screens/plata_details_screen.dart';
import 'package:afk_admin/screens/plata_list_screen.dart';
import 'package:afk_admin/screens/korisnici_list_screen.dart';
import 'package:afk_admin/screens/termin_details_screen.dart';
import 'package:afk_admin/screens/transakcijski_racun_details.dart';
import 'package:afk_admin/screens/transakcijski_racun_list_screen.dart';
import 'package:afk_admin/screens/trening_details_screen.dart';
import 'package:afk_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;


import '../models/korisnik.dart';
import '../screens/home_screen.dart';

// ignore: must_be_immutable
class MasterScreenWidget extends StatefulWidget {
  Widget?child;
  String? title;
  Widget? title_widget;
  bool DozvoljenAppBar=false;

  MasterScreenWidget({this.child, this.title, this.title_widget, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {

  SearchResult<Korisnik>? _korisnikResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title_widget?? Text(widget.title??"")
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Nazad"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Odjava"),
              onTap: (){
                Navigator.of(context).pushAndRemoveUntil<void>
                (
                
                MaterialPageRoute<void>
                (builder: (BuildContext context) => 
                LoginPage()),
                ModalRoute.withName('/Korisnik'),
                  // MaterialPageRoute(
                  //   builder: (context) => LoginPage(),
                  // ),
                );
              },
            ),
            ListTile(
              title: const Text("Početna"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    
                    builder: (context) => HomePage(korisnik: null,),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Pogledaj platnu listu"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  PlatumListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Dodaj novu platu +"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlatumDetailsScreen(platum: null,),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Pogledaj listu transakcijskih računa"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  TransakcijskiRacunListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Dodaj novi transakcijski račun +"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TransakcijskiRacunDetailsScreen(transakcijskiRacun: null,),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Pogledaj listu korisnika"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  KorisniciListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Dodaj novog korisnika +"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KorisnikDetailsScreen(korisnik: null,),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Dodaj novi trening +"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TreningDetailsScreen(trening: null,),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Dodaj novi termin +"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TerminDetailsScreen(termin: null,),
                  ),
                );
              },
            )
          ],
        ),
       ),
      body: widget.child!,


    );
  }
}