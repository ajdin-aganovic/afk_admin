import 'package:afk_admin/main.dart';
import 'package:afk_admin/screens/plata_details_screen.dart';
import 'package:afk_admin/screens/plata_list_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MasterScreenWidget extends StatefulWidget {
  Widget?child;
  String? title;
  Widget? title_widget;

  MasterScreenWidget({this.child, this.title, this.title_widget, super.key});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
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
              title: const Text("Back"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Plata list"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PlataListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Plata details"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlataDetailsScreen(),
                  ),
                );
              },
            ),
            // ListTile(
            //   title: Text("Korisnici list"),
            //   onTap: (){
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => KorisniciDetailsScreen(),
            //       ),
            //     );
            //   },
            // )
          ],
        ),
       ),
      body: widget.child!,


    );
  }
}