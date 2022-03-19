import 'dart:convert';

import 'package:batoidex_bat/pokemon_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokeApi =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late List pokedex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: -50,
          right: -50,
          child: Image.asset(
            'images/pokeball.png',
            width: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        const Positioned(
            top: 80,
            left: 20,
            child: Text(
              'Batoidex',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        Positioned(
          top: 150,
          bottom: 0,
          width: width,
          child: Column(
            children: [
              pokedex != null
                  ? Expanded(
                      child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1.4),
                      itemCount: pokedex.length,
                      itemBuilder: (context, index) {
                        var type = pokedex[index]['type'][0];
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: getColor(type),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Stack(children: [
                                Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset(
                                      'images/pokeball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )),
                                Positioned(
                                  top: 20,
                                  left: 10,
                                  child: Text(
                                    pokedex[index]['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 45,
                                  left: 20,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        type.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: Hero(
                                      tag: index,
                                      child: CachedNetworkImage(
                                        imageUrl: pokedex[index]['img'],
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )),
                              ]),
                            ),
                          ),
                          onTap: () {
                            // TODO Open detal screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PokemonDetailScreen(
                                          pokemonDetail: pokedex[index],
                                          color: getColor(type),
                                          heroTag: index,
                                        )));
                          },
                        );
                      },
                    ))
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ],
    ));
  }

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });
  }

  ColorSwatch<int> getColor(type) {
    switch (type) {
      case 'Grass':
        return Colors.greenAccent;
      case 'Fore':
        return Colors.redAccent;
      case 'Water':
        return Colors.blue;
      case 'Electric':
        return Colors.yellow;
      case 'Rock':
        return Colors.grey;
      case 'Ground':
        return Colors.brown;
      case 'Psychic':
        return Colors.indigo;
      case 'Fighting':
        return Colors.orange;
      case 'Bug':
        return Colors.lightGreenAccent;
      case 'Ghost':
        return Colors.deepPurple;
      case 'Normal':
        return Colors.grey;
      case 'Poison':
        return Colors.deepPurpleAccent;
      default:
        return Colors.pink;
    }
  }
}
