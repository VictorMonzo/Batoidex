import 'package:batoidex_bat/services/firebase/FirebaseAuth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      TextButton(
        onPressed: () => MyFirebaseAuthService().signOut(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.signOut,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfff1665f))),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.exit_to_app,
              size: 24.0,
              color: Color(0xfff1665f),
            ),
          ],
        ),
      ),
    ],
  );
}
