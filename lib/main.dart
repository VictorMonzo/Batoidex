import 'package:batoidex_bat/ui/pokemon/pokedex_screen.dart';
import 'package:batoidex_bat/ui/background/background.dart';
import 'package:batoidex_bat/ui/forms/login_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Pokedex());
}

class Pokedex extends StatelessWidget {
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pokedex(),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batoidex',
      home: Scaffold(
        body: Stack(
          children: [
            Background(),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
