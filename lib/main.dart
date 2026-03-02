import 'package:flutter/material.dart';
import 'package:flutter_forum/screens/affichageMessage.dart';
import 'package:flutter_forum/screens/listeUtilisateur.dart';
import 'package:flutter_forum/screens/inscription.dart';
import 'package:flutter_forum/screens/connexion.dart';
import 'screens/myhomepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env.local");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const MyHomePage(title: 'Accueil Forum'),
      routes: {
        '/affichage': (context) => const AffichagePage(),
        '/listeUtilisateur': (context) => const ListeUtilisateurPage(),
        '/inscription': (context) => MyCustomForm(),
        '/connexion': (context) => LoginForm(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
