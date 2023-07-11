import 'dart:math';
import 'dart:convert';
import 'package:afk_admin/providers/bolest_provider.dart';
import 'package:afk_admin/providers/clanarina_provider.dart';
import 'package:afk_admin/providers/pozicija_provider.dart';
import 'package:afk_admin/providers/stadion_provider.dart';
import 'package:afk_admin/providers/statistika_provider.dart';
import 'package:afk_admin/providers/termin_provider.dart';
import 'package:afk_admin/providers/transakcijski_racun_provider.dart';
import 'package:afk_admin/providers/trening_provider.dart';
import 'package:afk_admin/screens/bolest_list_screen.dart';
import 'package:afk_admin/screens/home_screen.dart';
import 'package:afk_admin/screens/korisnici_list_screen.dart';
import 'package:afk_admin/screens/reset_password_screen.dart';
import 'package:http/http.dart' as http;
import 'package:afk_admin/providers/korisnik_provider.dart';
import 'package:afk_admin/providers/platum_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:afk_admin/screens/plata_list_screen.dart';
import 'package:afk_admin/screens/korisnik_details_screen.dart';
import 'package:afk_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:afk_admin/widgets/makePayment.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
// import 'package:afk_admin/api/client.dart';

import 'models/korisnik.dart';

void main() async {
  // await dotenv.load(fileName: "lib/.env");
  runApp(MultiProvider(providers:
  [
    ChangeNotifierProvider(create: (_) => PlatumProvider()),
    ChangeNotifierProvider(create: (_) => KorisnikProvider()),
    ChangeNotifierProvider(create: (_) => UlogaProvider()),
    ChangeNotifierProvider(create: (_) => BolestProvider()),
    ChangeNotifierProvider(create: (_) => ClanarinaProvider()),
    ChangeNotifierProvider(create: (_) => PozicijaProvider()),
    ChangeNotifierProvider(create: (_) => StadionProvider()),
    ChangeNotifierProvider(create: (_) => StatistikaProvider()),
    ChangeNotifierProvider(create: (_) => TerminProvider()),
    ChangeNotifierProvider(create: (_) => TransakcijskiRacunProvider()),
    ChangeNotifierProvider(create: (_) => TreningProvider()),

  ],
  child: const MyMaterialApp(),));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AFK Material app',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),

    );
  }
}

class LoginPage extends StatelessWidget {
 LoginPage({super.key});

  final TextEditingController _usernamecontroller=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();

  late PlatumProvider _plataProvider;
  late KorisnikProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
     
    _plataProvider=context.read<PlatumProvider>();
    _korisniciProvider=context.read<KorisnikProvider>();

    return 
        Scaffold(
          appBar: AppBar(
            title: const Text("Login"),),
            body: Center(
              child: 
              Container(
                constraints: const BoxConstraints(maxHeight: 400,maxWidth: 400),
                child: Card(
                  child: Column(children: [
                    //Image.network("https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/285px-Manchester_United_FC_crest.svg.png", height: 100,width: 100,),
                    // Image.asset("assets/images/manchesterunited.png", height: 100,width: 100,),
                    const SizedBox(height: 20,),
                    const Text('Aplikacija Fudbalskog Kluba',
                     style: TextStyle(fontSize: 30),),
                      const SizedBox(height: 20,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.email),
                      ),
                      controller: _usernamecontroller,
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: 'Enter your secure password',
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                      controller: _passwordcontroller,
                    ),
                    // const SizedBox(height: 20,),
                    // ElevatedButton(onPressed: () async{
                      
                    //   }),
                    const SizedBox(height: 20,),
                    ElevatedButton(onPressed:() async {
                      var username=_usernamecontroller.text;
                      var password=_passwordcontroller.text;
                      print("login proceed u:($username) p:($password)");

                      Authorization.username=username;
                      Authorization.password=password;
                      
                      try {
                          var data=await _korisniciProvider.get(filter: {
                        'KorisnickoIme':username,
                        }
                      );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                // builder: (context) => HomePage(naziv: username,),
                                builder: (context) => KorisnikDetailsScreen(korisnik: data.result.first,),

                              ),
                            );
                        } on Exception catch (e) {
                          showDialog(context: context, builder: (BuildContext context) => 
                          AlertDialog(
                            title: const Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(onPressed: ()=>{
                                Navigator.pop(context),
                                _usernamecontroller.text="",
                                _passwordcontroller.text=""
                              }, child: const Text("OK"))
                            ],
                          ));
                        }
                    }, child: const Text("Login")),
                    const SizedBox(height: 20,),

                    ElevatedButton(onPressed: (){
                      
                        Navigator.of(context).push(
                        MaterialPageRoute(
                  
                        builder: (context) => ContactPage(),
                            ),
                            );
                          }, 
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                     ),
                    ),

                    // const SizedBox(height: 20,),
                    // ElevatedButton(onPressed: (){
                    //   makePayment();
                    // }, 
                    // child: const Text('Go to Payment'),
                    // )


                  ]),
                ),
              ),
            ),
        );
  }
  
// Future<Korisnik?> authenticateUser(String username, String password) async {
//   final url = Uri.parse('https://localhost:7181/Korisnik');

//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'username': username, 'password': password}),
//   );

//   if (response.statusCode == 200) {
//     final jsonResponse = jsonDecode(response.body);
//     return Korisnik.fromJson(jsonResponse);
//   } else {
//     return null;
//   }
// }
}



// Login endpoint
// Future<String> login(String username, String password) async {
//   // Perform authentication and validate credentials
//   bool isValidCredentials = await authenticate(username, password);
  
//   if (isValidCredentials) {
//     // Generate a JWT token
//     final token = generateJwtToken(username);
//     return token;
//   } else {
//     throw Exception('Invalid credentials');
//   }
// }

// // Generate JWT token
// String generateJwtToken(String username) {
//   // Generate token with desired payload (e.g., username and expiration time)
//   final payload = {
//     'username': username,
//     'exp': DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000,
//   };

//   // Sign the token using a secret key
//   final token = JwtDecoder.encode(payload, 'your_secret_key');
//   return token;
// }




































