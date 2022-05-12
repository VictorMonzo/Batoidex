import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:batoidex_bat/services/firebase/FirebaseAuth.dart';
import 'package:batoidex_bat/ui/profile/widget/numbers_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/appbar_widget.dart';
import 'widget/button_widget.dart';
import 'widget/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userAuth = FirebaseAuth.instance.currentUser!;
  final userData = MyFunctions.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userAuth.photoURL ??
                userData.imagePath ??
                'https://via.placeholder.com/150',
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(
              userData.name ??
                  userAuth.displayName ??
                  'You don\'t have a name yet',
              userAuth.email),
          const SizedBox(height: 24),
          NumbersWidget(
              pokeFavorites: userData.numPokeFavs,
              verifiedEmail: userAuth.emailVerified,
              creationDate: userData.creationDate ?? 'No date'),
          const SizedBox(height: 48),
          buildAbout(userData.about ??
              'Edit your profile if you want to add a description'),
        ],
      ),
    );
  }

  Widget buildName(name, email) => Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Sign Out',
        onClicked: () => MyFirebaseAuthService().signOut(),
      );

  Widget buildAbout(about) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
