import 'package:flutter/material.dart';
import '../../api/user_api.dart';
import '../../userClass.dart';

class ListeUtilisateurPage extends StatefulWidget {
  const ListeUtilisateurPage({super.key});

  @override
  State<ListeUtilisateurPage> createState() => _ListeUtilisateurPageState();
}

class _ListeUtilisateurPageState extends State<ListeUtilisateurPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserApi().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des utilisateurs'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun utilisateur trouvé.'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final u = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(u.email),
                  subtitle: Text(
                    u.roles.isNotEmpty ? u.roles.join(', ') : 'User',
                  ),
                  /* onTap: () {
                    // Vous pourrez ajouter la navigation vers le profil utilisateur
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profil de ${u.email}')),
                    );
                  }, */
                ),
              );
            },
          );
        },
      ),
    );
  }
}
