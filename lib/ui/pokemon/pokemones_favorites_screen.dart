import 'package:flutter/material.dart';

class PokemonesFavoritesScreen extends StatefulWidget {
  const PokemonesFavoritesScreen({Key? key}) : super(key: key);

  @override
  State<PokemonesFavoritesScreen> createState() =>
      _PokemonesFavoritesScreenState();
}

class _PokemonesFavoritesScreenState extends State<PokemonesFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pokemones screen'),
    );
  }
}
