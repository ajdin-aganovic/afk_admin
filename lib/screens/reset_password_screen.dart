import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}):super(key:key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final usernameController = TextEditingController();
  final recipientController = TextEditingController();

  final ScrollController _horizontal = ScrollController(), _vertical=ScrollController();
  String get envServiceId=>dotenv.env['EMAILJS_SERVICE']??"https://google.com";
  String get envTemplateId=>dotenv.env['EMAILJS_TEMPLATE']??"https://youtube.com";
  String get envUserId=>dotenv.env['EMAILJS_USER']??"https://instagram.com";
  String get envUrl=>dotenv.env['EMAILJS_URL']??"https://instagram.com";

  
  Future sendEmail()async{
    final url=Uri.parse(envUrl);
    final serviceId=envServiceId;
    final templateId=envTemplateId;
    final userId=envUserId;
    final response=await http.post(url,
    headers:{'Content-Type':'application/json'},
    body: json.encode({
      "service_id":serviceId,
      "template_id":templateId,
      "user_id":userId,
      "template_params":{
        "name":nameController.text,
        "user_name":usernameController.text,
        "message":messageController.text,
        "subject":subjectController.text,
        "user_email":emailController.text,
        "recipient_email":recipientController.text,
      }
      })
    );
    return response.statusCode;
  }

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),

      home: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.grey[400],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
            child: Center(
              child: SizedBox(
                      height: 500,
                      width: 800,
                        child: Form(
              child: Column(children: [
                Expanded(
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      // icon: const Icon(Icons.account_circle),
                      labelText: 'Ime i prezime',
                      hintText: 'Vaše ime i prezime'),
                  ),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      // icon: const Icon(Icons.account_circle),
                      labelText: 'Korisničko ime',
                      hintText: 'Vaše korisničko ime'),
                  ),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      // icon: const Icon(Icons.account_circle),
                      labelText: 'Message',
                      hintText: 'Vaša poruka za ovaj mail'),
                  ),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: TextFormField(
                    controller: subjectController,
                    decoration: const InputDecoration(
                      // icon: const Icon(Icons.account_circle),
                      labelText: 'Zaboravljena lozinka',
                      enabled: true,

                      ),
                  ),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      // icon: const Icon(Icons.account_circle),
                      labelText: 'Email',
                      hintText: 'Vaš email'),
                  ),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: TextFormField(
                    controller: recipientController,
                    decoration: const InputDecoration(
                      // icon: const Icon(Icons.account_circle),
                      labelText: 'Email korisničke podrške',
                      hintText: 'Administratorski email'),
                  ),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    sendEmail();
                    nameController.text="";
                    subjectController.text="";
                    emailController.text="";
                    messageController.text="";
                    usernameController.text="";
                    recipientController.text="";
                    Navigator.pop(context);
                  }, child: const Text("Pošalji", 
                  style: TextStyle(fontSize: 20),)),
                ),
                const SizedBox(height: 25,),
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    nameController.text="";
                    subjectController.text="";
                    emailController.text="";
                    messageController.text="";
                    usernameController.text="";
                    recipientController.text="";
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
                  }, child: const Text("Nazad na login", 
                  style: TextStyle(fontSize: 20),)),
                )
              ]),
                        ),
                      ),
            ),
      ),
    ),
      //   ),
      //     ),
      // ),
      // ),
    );

  }
}