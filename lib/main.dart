import 'package:afk_admin/providers/korisnici_provider.dart';
import 'package:afk_admin/providers/plata_provider.dart';
import 'package:afk_admin/providers/tip_korisnika_provider.dart';
import 'package:afk_admin/providers/uloga_provider.dart';
import 'package:afk_admin/screens/plata_list_screen.dart';
import 'package:afk_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:
  [
    ChangeNotifierProvider(create: (_) => PlataProvider()),
    ChangeNotifierProvider(create: (_) => KorisniciProvider()),
    ChangeNotifierProvider(create: (_) => TipKorisnikaProvider()),
    ChangeNotifierProvider(create: (_) => UlogaProvider()),

  ],
  child: const MyMaterialApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LayoutExamples(),
    );
  }
}

class MyHelloWorld extends StatelessWidget{
  String title;
  MyHelloWorld({Key?key, required this.title}):super(key: key);

  @override
  Widget build(BuildContext context){

    return Text(title);
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count=0;
  void incrementCounter()
  {
    setState(() {
    _count++;
    });
  }

  void resetCounter()
  {
    setState(() {
      _count=0;
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Text("You have pushed $_count times"),
        ElevatedButton(onPressed: incrementCounter, child: const Text("Increment ++"),
        ),
        const Text("Press to reset the score"),
        ElevatedButton(onPressed: resetCounter, child: const Text("Reset score"),
        )
      ],
    );
  }
}


class LayoutExamples extends StatelessWidget {
  const LayoutExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text("example text"),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("text1"),
            Text("text2"),
            Text("text3"),
          ],
        ),
        Container(
          height: 150,
          color: Colors.red,
          alignment: Alignment.center,
          child: const Text("example rows"),
        ),
      ],
    );
  }
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

  late PlataProvider _plataProvider;

  @override
  Widget build(BuildContext context) {
    _plataProvider=context.read<PlataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),),
        body: Center(
          child: 
          Container(
            constraints: const BoxConstraints(maxHeight: 400,maxWidth: 400),
            child: Card(
              child: Column(children: [
                //Image.network("https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/285px-Manchester_United_FC_crest.svg.png", height: 100,width: 100,),
                Image.asset("assets/images/manchesterunited.png", height: 100,width: 100,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: _usernamecontroller,
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                  controller: _passwordcontroller,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed:() async {
                  var username=_usernamecontroller.text;
                  var password=_passwordcontroller.text;
                  print("login proceed u:($username) p:($password)");
                  
                  Authorization.username=username;
                  Authorization.password=password;

                  try {
                      await _plataProvider.get();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PlataListScreen(),
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

              ]),
            ),
          ),
        ),
    );
  }
}





































