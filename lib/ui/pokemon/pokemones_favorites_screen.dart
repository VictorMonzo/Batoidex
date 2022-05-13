import 'package:batoidex_bat/services/firebase/FirebaseData.dart';
import 'package:batoidex_bat/ui/pokemon/pokemon_detail_screen.dart';
import 'package:batoidex_bat/ui/pokemon/widget/pokemon_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/pokemon_card.dart';
import '../../services/MyColors.dart';

class PokemonesFavoritesScreen extends StatefulWidget {
  const PokemonesFavoritesScreen({Key? key}) : super(key: key);

  @override
  State<PokemonesFavoritesScreen> createState() =>
      _PokemonesFavoritesScreenState();
}

class _PokemonesFavoritesScreenState extends State<PokemonesFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
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
              'Favorites',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        Positioned(
          top: 150,
          bottom: 0,
          width: width,
          child: StreamBuilder<List<PokemonCard>>(
            stream: MyFirebaseData().getPokeFavorites(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text('Something went wrong! ${snapshot.hasError}'));
              } else if (snapshot.hasData) {
                final pokemones = snapshot.data!;

                return Column(
                  children: [
                    Expanded(
                        child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1.4),
                      itemCount: pokemones.length,
                      itemBuilder: (context, index) =>
                          PokemonCardWidget(pokemon: pokemones[index]),
                    )),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildPokemonCard(PokemonCard pokemon) => InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          child: Container(
            decoration: BoxDecoration(
              color: MyColors().getColor(pokemon.type),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                  pokemon.name,
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
                        left: 8.0, right: 8.0, top: 4, bottom: 4),
                    child: Text(
                      pokemon.type,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black26,
                  ),
                ),
              ),
              Positioned(
                  bottom: 5,
                  right: 5,
                  child: Hero(
                    tag: pokemon.id,
                    child: CachedNetworkImage(
                      imageUrl: pokemon.img,
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
                        pokemonDetail: pokemon,
                        color: MyColors().getColor(pokemon.type),
                        heroTag: pokemon.id,
                      )));
        },
      );
}
