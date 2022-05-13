import 'package:flutter/foundation.dart';

class PokemonCard {
  final int id;
  final String img;
  final String name;
  final String type;
  // final String height;
  // final String weight;
  // final String spawnTime;
  // final List<String> weakness;
  // final List<String> evolutions;

  PokemonCard(
      {required this.id,
      required this.img,
      required this.name,
      required this.type});

  static PokemonCard fromJson(Map<String, dynamic> json) => PokemonCard(
      id: json['id'], img: json['img'], name: json['name'], type: json['type']);
}
