import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
              child: const Text("S'inscrire"),
            ),
            const SizedBox(height: 20),

            // Bouton pour aller vers la liste des utilisateurs
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listeUtilisateur');
              },
              child: const Text('Voir les utilisateurs'),
            ),
            const SizedBox(height: 20),
            // Bouton pour aller vers l'affichage des messages
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/affichage');
              },
              child: const Text('Voir les messages'),
            ),
          ],
        ),
      ),
    );
  }
}
