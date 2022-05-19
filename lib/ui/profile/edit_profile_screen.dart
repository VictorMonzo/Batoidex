import 'dart:io';

import 'package:batoidex_bat/model/user_data.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyConstants.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:batoidex_bat/services/firebase/FirebaseData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widget/button_widget.dart';
import 'widget/profile_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final UserData userData;

  const EditProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with WidgetsBindingObserver {
  final userAuth = FirebaseAuth.instance.currentUser!;

  late final TextEditingController nameController;
  late final TextEditingController aboutController;

  File? image;
  String? imageRemoved;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
        text: widget.userData.name ??
            userAuth.displayName ??
            AppLocalizations.of(context)!.youDontHaveNameYet);
    aboutController = TextEditingController(
        text: widget.userData.about ??
            AppLocalizations.of(context)!
                .editYourProfileFfYouWantToAddDescription);
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
            imagePath: imageRemoved ??
                widget.userData.imageUrl ??
                userAuth.photoURL ??
                MyConstants().NO_IMAGE_PROFILE,
            isEdit: true,
            image: image,
            onClicked: () => showImageSource(context),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.fullName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
              Text(
                AppLocalizations.of(context)!.about,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
        text: AppLocalizations.of(context)!.save,
        onClicked: () {
          MyFirebaseData().saveUserData(
              nameController.text.trim(), aboutController.text.trim(), context);

          Navigator.pop(context);
        },
      );

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);

      MyFirebaseData().saveImagePath(imageTemporary, context);
    } on PlatformException catch (e) {
      MyFunctions().toast(
          '${AppLocalizations.of(context)!.failedToPickImage} ${e.message}',
          MyColors().redDegradedDark);
    }
  }

  showImageSource(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(AppLocalizations.of(context)!.camera),
                  onTap: () =>
                      Navigator.of(context).pop(pickImage(ImageSource.camera)),
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: Text(AppLocalizations.of(context)!.gallery),
                  onTap: () =>
                      Navigator.of(context).pop(pickImage(ImageSource.gallery)),
                ),
                if (widget.userData.imageUrl != null ||
                    userAuth.photoURL != null)
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text(AppLocalizations.of(context)!.remove),
                    onTap: () {
                      if (widget.userData.imageUrl != null) {
                        Navigator.of(context)
                            .pop(MyFirebaseData().deleteImagePath(context));

                        setState(() => imageRemoved = userAuth.photoURL ??
                            MyConstants().NO_IMAGE_PROFILE);
                      } else if (userAuth.photoURL != null) {
                        MyFunctions().toast(
                            AppLocalizations.of(context)!
                                .thisIsTheDefaultImageOfYourGoogleAccount,
                            MyColors().redDegradedDark);
                      }
                    },
                  )
              ],
            ));
  }
}
