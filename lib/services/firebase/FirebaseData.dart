import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:batoidex_bat/model/pokemon_card.dart';
import 'package:batoidex_bat/model/user_data.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyFirebaseData {
  final String COLLECTION_USER = 'users';
  final String COLLECTION_POKE_FAVORITES = 'poke_favorites';

  /// WRITE DATA
  Future saveImagePath(File image) async {
    final docUser =
        FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());

    convertToBase64(image).then((String result) async {
      final json = {'image_path': result};

      await docUser.update(json);

      MyFunctions().toast(
          'Modified profile picture successfully', MyColors().greenLight);
    }).catchError(MyFunctions()
        .toast('Failed to save the image', MyColors().redDegradedDark));
  }

  Future saveUserCreationData(String creationData) async {
    final docUser =
        FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());

    final json = {'data_creation': creationData};

    await docUser.set(json);
  }

  Future saveUserData(String name, String about) async {
    final docUser =
        FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());

    final json = {'name': name, 'about': about};

    await docUser.update(json);

    MyFunctions().toast('User modified successfully', MyColors().greenLight);
  }

  Future saveUserNumFavorites() async {
    final docUser =
        FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());

    final int numPokeFavs = await getPokeFavoritesLenght();

    final json = {'num_poke_favorites': numPokeFavs};

    await docUser.update(json);
  }

  /// FAVORITES
  Future<bool> getPokeFavoriteById(int id) async {
    final docPokeFav = FirebaseFirestore.instance
        .collection(COLLECTION_USER)
        .doc(getUid())
        .collection(COLLECTION_POKE_FAVORITES)
        .doc('$id');

    final snapshot = await docPokeFav.get();

    return snapshot.exists ? true : false;
  }

  Future savePokeFavorite(pokemon) async {
    final docPokeFav = FirebaseFirestore.instance
        .collection(COLLECTION_USER)
        .doc(getUid())
        .collection(COLLECTION_POKE_FAVORITES)
        .doc('${pokemon['id']}');

    String? nextEvolution, prevEvolution;

    if (pokemon['next_evolution'] != null) {
      if (pokemon['next_evolution'].length == 2) {
        nextEvolution =
            '${pokemon['next_evolution'][0]['name']} ${pokemon['next_evolution'][1]['name']}';
      } else {
        nextEvolution = '${pokemon['next_evolution'][0]['name']}';
      }
    }

    if (pokemon['prev_evolution'] != null) {
      if (pokemon['prev_evolution'].length == 2) {
        prevEvolution =
            '${pokemon['prev_evolution'][0]['name']} ${pokemon['prev_evolution'][1]['name']}';
      } else {
        prevEvolution = '${pokemon['prev_evolution'][0]['name']}';
      }
    }

    final json = PokemonCard(
            id: pokemon['id'],
            img: pokemon['img'],
            name: pokemon['name'],
            type: pokemon['type'][0],
            types: pokemon['type']
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),
            weakness: pokemon['weaknesses']
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),
            spawnTime: pokemon['spawn_time'],
            weight: pokemon['weight'],
            height: pokemon['height'],
            nextEvolution: nextEvolution,
            prevEvolution: prevEvolution)
        .toJson();

    await docPokeFav.set(json);

    MyFunctions().toast('Pokemon saved as a favorite', MyColors().greenLight);
  }

  Future deletePokeFavorite(int id) async {
    final docPokeFav = FirebaseFirestore.instance
        .collection(COLLECTION_USER)
        .doc(getUid())
        .collection(COLLECTION_POKE_FAVORITES)
        .doc('$id');

    await docPokeFav.delete();

    MyFunctions().toast('Pokemon removed from favorite', MyColors().greenLight);
  }

  Stream<List<PokemonCard>> getPokeFavorites() => FirebaseFirestore.instance
      .collection(COLLECTION_USER)
      .doc(getUid())
      .collection(COLLECTION_POKE_FAVORITES)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList());

  Future<int> getPokeFavoritesLenght() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USER)
        .doc(getUid())
        .collection(COLLECTION_POKE_FAVORITES)
        .snapshots()
        .length;
  }

  /// READ DATA
  Future<UserData?> readData() async {
    final docUser =
        FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserData.fromJson(snapshot.data()!);
    }
    return null;
  }

  getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String> convertToBase64(File image) async {
    Uint8List imagebytes = await image.readAsBytes();
    return base64.encode(imagebytes);
  }

  Uint8List convertToBytes(String imageBase64) {
    return base64.decode(imageBase64);
  }
}
