import 'package:batoidex_bat/model/user_data.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFirebaseData {
  final String COLLECTION_USER = ' users';

  /// WRITE DATA
  Future saveImagePath(String imagePath) async {
    final docUser =
        FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());

    final json = {'image_path': imagePath};

    await docUser.update(json);

    MyFunctions().toast('Modified profile picture successfully', MyColors().greenLight);
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

  /// READ DATA
  Future<UserData?> readData() async {
    final docUser = FirebaseFirestore.instance.collection(COLLECTION_USER).doc(getUid());
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserData.fromJson(snapshot.data()!);
    }
    return null;
  }

  getUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
