// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
// import 'dart:convert';

// import '../models/korisnik.dart';


// class InsertScreen extends StatefulWidget {
//   @override
//   _InsertScreenState createState() => _InsertScreenState();
// }

// class _InsertScreenState extends State<InsertScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _korisnikIdController = TextEditingController();
//   final _imeController = TextEditingController();
//   final _prezimeController = TextEditingController();
//   final _korisnickoImeController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _lozinkaHashController = TextEditingController();
//   final _lozinkaSaltController = TextEditingController();
//   final _strucnaSpremaController = TextEditingController();
//   final _datumRodjenjaController = TextEditingController();
//   final _podUgovoromController = TextEditingController();
//   final _podUgovoromOdController = TextEditingController();
//   final _podUgovoromDoController = TextEditingController();
//   // Add controllers for other properties of Korisnik

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Insert Korisnik'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _korisnikIdController,
//                 decoration: InputDecoration(labelText: 'KorisnikId'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _imeController,
//                 decoration: InputDecoration(labelText: 'Ime'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Ime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _prezimeController,
//                 decoration: InputDecoration(labelText: 'Prezime'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _korisnickoImeController,
//                 decoration: InputDecoration(labelText: 'KorisnickoIme'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _lozinkaHashController,
//                 decoration: InputDecoration(labelText: 'lozinkaHash'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _lozinkaSaltController,
//                 decoration: InputDecoration(labelText: 'lozinkaSalt'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _strucnaSpremaController,
//                 decoration: InputDecoration(labelText: 'StrucnaSprema'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _datumRodjenjaController,
//                 decoration: InputDecoration(labelText: 'DatumRodjenja'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _podUgovoromController,
//                 decoration: InputDecoration(labelText: 'PodUgovorom'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _podUgovoromOdController,
//                 decoration: InputDecoration(labelText: 'PodUgovoromOd'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _podUgovoromDoController,
//                 decoration: InputDecoration(labelText: 'PodUgovoromDo'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _prezimeController,
//                 decoration: InputDecoration(labelText: 'Prezime'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the Prezime';
//                   }
//                   return null;
//                 },
//               ),
//               // Add form fields for other properties of Korisnik
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Create a Korisnik object using the entered values
//                     final Korisnik korisnik = Korisnik(
//                       'korisnikId':_korisnikIdController.text,
//                       'ime': _imeController.text,
//                       'prezime': _prezimeController.text,
//                       'korisnickoIme':_korisnickoImeController.text,
//                       'email':_emailController.text,
//                       'lozinkaHash':_lozinkaHashController.text,
//                       'lozinkaSalt':_lozinkaSaltController.text,
//                       'strucnaSprema':_strucnaSpremaController.text,
//                       'datumRodjenja':_datumRodjenjaController.text,
//                       'podUgovorom':_podUgovoromController.text,
//                       'podUgovoromOd':_podUgovoromOdController.text,
//                       'podUgovoromDo':_podUgovoromDoController.text,
//                       // Assign other properties of Korisnik
//                     );

              
//                     // Call the insertKorisnik method to perform the insert operation
//                     insertKorisnik(korisnik);

//                     // Navigate back to the previous screen
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text('Insert'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> insertKorisnik(Korisnik korisnik) async {
//   final url = Uri.parse('https://localhost:7181/Korisnik/');

//   final response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(korisnik.toJson()),
//   );

//   if (response.statusCode == 201) {
//     // Insert operation successful
//   } else {
//     // Insert operation failed
//     print('Insert operation failed: ${response.body}');
//   }
// }

// }