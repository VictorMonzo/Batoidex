import 'package:flutter/material.dart';

class PokemonSearchScreen extends StatefulWidget {
  const PokemonSearchScreen({Key? key}) : super(key: key);

  @override
  State<PokemonSearchScreen> createState() => _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends State<PokemonSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Search pokemon"),
    );
  }
}
