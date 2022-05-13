import 'package:batoidex_bat/model/user_data.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/button_widget.dart';
import 'widget/profile_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserData userData = MyFunctions.myUser;
  final userAuth = FirebaseAuth.instance.currentUser!;

  late final TextEditingController nameController;
  late final TextEditingController aboutController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
        text: userData.name ??
            userAuth.displayName ??
            'You don\'t have a name yet');
    aboutController = TextEditingController(
        text: userData.about ??
            'Edit your profile if you want to add a description');
  }

  @override
  void dispose() {
    nameController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userAuth.photoURL ??
                userData.imagePath ??
                'https://via.placeholder.com/150',
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Full Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: aboutController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 5,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton())
        ],
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Save',
        onClicked: () => MyFunctions()
            .toast(nameController.text.trim(), MyColors().blueDegradedDark),
      );
}
