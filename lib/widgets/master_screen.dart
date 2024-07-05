import 'package:afk_admin/main.dart';
import 'package:afk_admin/models/search_result.dart';
import 'package:flutter/material.dart';


import '../models/korisnik.dart';
import '../screens/home_screen.dart';

// ignore: must_be_immutable
class MasterScreenWidget extends StatefulWidget {
  Widget?child;
  String? title;
  Widget? title_widget;
  bool DozvoljenAppBar=false;
  Korisnik? korisnik;
  MasterScreenWidget({this.child, this.title, this.title_widget, this.korisnik, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {

  SearchResult<Korisnik>? _korisnikResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title_widget?? Text(widget.title??""),
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Početna"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Nazad"),
              onTap: (){
                Navigator.pop(context);
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
            
          ],
        ),
       ),
      body: widget.child!,


    );
  }
}