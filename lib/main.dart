import 'package:batoidex_bat/services/Firebase.dart';
import 'package:batoidex_bat/ui/background/background.dart';
import 'package:batoidex_bat/ui/forms/login_form.dart';
import 'package:batoidex_bat/ui/pokemon/pokedex_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batoidex',
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PokedexScreen();
            } else {
              return Stack(
                children: [
                  Background(),
                  const LoginForm(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
