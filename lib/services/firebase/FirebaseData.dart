import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:batoidex_bat/model/user_data.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future savePokeFavorite(int id, String name, String type, String img) async {
    final docPokeFav = FirebaseFirestore.instance
        .collection(COLLECTION_USER)
        .doc(getUid())
        .collection(COLLECTION_POKE_FAVORITES)
        .doc('$id');

    final json = {
      'id': id,
      'name': name,
      'type': type,
      'img': img
    };

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

  // para obtener todos los pokefavs ver el video del que he visto muchos videos

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
