import 'package:batoidex_bat/services/firebase/FirebaseAuth.dart';
import 'package:batoidex_bat/services/firebase/FirebaseData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/DarkThemeProvider.dart';

AppBar buildAppBar(BuildContext context) {
  final themeChange = Provider.of<DarkThemeProvider>(context);

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: InkWell(
      child: Icon(
          themeChange.darkTheme
              ? CupertinoIcons.sun_max_fill
              : CupertinoIcons.moon_stars,
          color: Theme.of(context).dividerColor),
      onTap: () async {
        themeChange.darkTheme = !(await MyFirebaseData().getIsDarkTheme());
      },
    ),
    actions: [
      TextButton(
        onPressed: () => MyFirebaseAuthService().signOut(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Sign Out',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xfff1665f))),
            SizedBox(
              width: 5,
            ),
            Icon(
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
