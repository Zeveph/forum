import 'package:flutter/material.dart';
import '../../api/user_api.dart';

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmedController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmedController.dispose();
    super.dispose();
  }

Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Loader
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        // Appel API
        int result = await UserApi().registerUser(
          _prenomController.text, // firstName
          _nameController.text, // lastName
          _emailController.text,
          _passwordController.text,
        );

        Navigator.of(context).pop(); // retire le loader

        if (result == 201) {
          // Succès
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Inscription réussie'),
              content: Text(
                'Bonjour, ${_prenomController.text} ${_nameController.text} !',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
              ],
            ),
          );
        } else {
          // Erreur serveur
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Échec de l’inscription'),
              content: Text(
                'Une erreur est survenue : $result. Veuillez réessayer.',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // Exception
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('Erreur lors de l’inscription : $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("S'inscrire")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Color.fromARGB(255, 196, 43, 160),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Veuillez n\'utiliser que des lettres';
                  }
                  return null; // ce return doit être à l'intérieur du validator
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _prenomController,
                // Attention à bien le changer
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Color.fromARGB(255, 196, 43, 160),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre prénom';
                  } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Veuillez n\'utiliser que des lettres';
                  }
                  return null; // ce return doit être à l'intérieur du validator
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Color.fromARGB(255, 196, 43, 160),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tu n'as même pas mis un email...  Tu me déçois beaucoup Samuel !";
                  } else if (!value.contains('@')) {
                    return "Où est notre @ d'amour ? On ne peut rien faire sans lui";
                  } else if (!RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  ).hasMatch(value)) {
                    return "Cet email... Comment te dire... ça ne passe pas, recommence.";
                  }
                  return null; // ce return doit être à l'intérieur du validator
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Color.fromARGB(255, 196, 43, 160),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tu n'as même pas mis de mot de passe...  C'est très décevant!";
                  } else if (value.length < 12) {
                    return "12 caractères minimum, … Pas 11, pas 10 ou moins. 12. Merci.";
                  } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                    return "Il nous faut au moins une petite lettre minuscule… Juste une… C’est pas trop demander.";
                  } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                    return "Il faut une grande majuscule… Juste une… !";
                  } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                    return "Ajoute un chiffre ! Sinon c’est juste un mot, pas un mot de passe.";
                  } else if (!RegExp(r'(?=.*[\W])').hasMatch(value)) {
                    return "Ajoute un symbole, un +, un *, un @, un % mais soit SPECIAL !";
                  }
                  return null; // ce return doit être à l'intérieur du validator
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordConfirmedController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmer le mot de passe',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Color.fromARGB(255, 196, 43, 160),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 196, 43, 160),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tu n’as même pas confirmé le mot de passe… Pourquoi tu me fais ça ?";
                  }

                  if (value != _passwordController.text) {
                    return "Les deux mots de passe ne correspondent PAS. Et ça, c’est une trahison.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
