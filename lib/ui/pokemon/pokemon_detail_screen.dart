import 'package:batoidex_bat/model/pokemon_card.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:batoidex_bat/services/firebase/FirebaseData.dart';
import 'package:batoidex_bat/ui/pokemon/pokemon_moviments_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatefulWidget {
  final pokemonDetail;
  final PokemonCard? pokemonCard;
  final Color color;
  final int heroTag;

  const PokemonDetailScreen(
      {Key? key,
      this.pokemonDetail,
      this.pokemonCard,
      required this.color,
      required this.heroTag})
      : super(key: key);

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 40,
            left: 1,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 30,
            ),
          ),
          Positioned(
            top: 40,
            right: 7,
            child: FutureBuilder<bool>(
                future: MyFirebaseData().getPokeFavoriteById(
                    widget.pokemonCard?.id ?? widget.pokemonDetail['id']),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return MyFunctions().buildTextCenterError(
                        AppLocalizations.of(context)!.somethingWentWrong);
                  } else if (snapshot.hasData) {
                    return buildIconButton(snapshot.data!);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Positioned(
              top: 90,
              left: 20,
              child: Text(
                widget.pokemonCard?.name ?? widget.pokemonDetail['name'],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )),
          Positioned(
              top: 140,
              left: 20,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                  child: Text(
                    widget.pokemonCard?.types ??
                        widget.pokemonDetail['type'].join(', '),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.black26),
              )),
          Positioned(
              top: height * 0.18,
              right: -30,
              child: Image.asset(
                'images/pokeball.png',
                height: 200,
                fit: BoxFit.fitHeight,
              )),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.name,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          Text(
                            widget.pokemonCard?.name ??
                                widget.pokemonDetail['name'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.height,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          Text(
                            widget.pokemonCard?.height ??
                                widget.pokemonDetail['height'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.weight,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          Text(
                            widget.pokemonCard?.weight ??
                                widget.pokemonDetail['weight'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.spawnTime,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          Text(
                            widget.pokemonCard?.spawnTime ??
                                widget.pokemonDetail['spawn_time'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.weakness,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          Text(
                            widget.pokemonCard?.weakness ??
                                widget.pokemonDetail['weaknesses'].join(', '),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.evolution,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          widget.pokemonCard?.nextEvolution != null
                              ? Text(
                                  '${widget.pokemonCard?.nextEvolution}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : widget.pokemonDetail != null &&
                                      widget.pokemonDetail['next_evolution'] !=
                                          null
                                  ? SizedBox(
                                      height: 20,
                                      width: width * 0.55,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget
                                            .pokemonDetail['next_evolution']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              widget.pokemonDetail[
                                                      'next_evolution'][index]
                                                  ['name'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.maxedOut,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.preForm,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          widget.pokemonCard?.prevEvolution != null
                              ? Text(
                                  '${widget.pokemonCard?.prevEvolution}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              : widget.pokemonDetail != null &&
                                      widget.pokemonDetail['prev_evolution'] !=
                                          null
                                  ? SizedBox(
                                      height: 20,
                                      width: width * 0.55,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget
                                            .pokemonDetail['prev_evolution']
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Text(
                                              widget.pokemonDetail[
                                                      'prev_evolution'][index]
                                                  ['name'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!.justHatched,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 0.3,
                              child: Text(
                                AppLocalizations.of(context)!.movements,
                                style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                ),
                              )),
                          InkWell(
                            child: Text(
                              AppLocalizations.of(context)!.clickHereToSee,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PokemonMovements(
                                            index: widget.pokemonCard?.id ??
                                                widget.pokemonDetail['id'],
                                            img: widget.pokemonCard?.img ??
                                                widget.pokemonDetail['img'],
                                            heroTag: widget.heroTag,
                                          )));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: height * 0.18,
              left: (width / 2) - 100,
              child: Hero(
                tag: widget.heroTag,
                child: CachedNetworkImage(
                  imageUrl:
                      widget.pokemonCard?.img ?? widget.pokemonDetail['img'],
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ))
        ],
      ),
    );
  }

  Widget buildIconButton(bool isFavorite) => IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          isFavorite
              ? MyFirebaseData().deletePokeFavorite(
                  widget.pokemonCard?.id ?? widget.pokemonDetail['id'], context)
              : MyFirebaseData().savePokeFavorite(
                  widget.pokemonCard ?? widget.pokemonDetail, context);

          MyFirebaseData().saveUserNumFavorites();

          setState(() => isFavorite = !isFavorite);
        },
        iconSize: 40,
        color: isFavorite ? MyColors().redDegradedDark : Colors.white,
      );
}
