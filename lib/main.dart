import 'dart:ffi';

import 'package:batoidex_bat/services/DarkThemeProvider.dart';
import 'package:batoidex_bat/services/MyColors.dart';
import 'package:batoidex_bat/services/MyFunctions.dart';
import 'package:batoidex_bat/services/firebase/FirebaseData.dart';
import 'package:batoidex_bat/ui/background/background.dart';
import 'package:batoidex_bat/ui/forms/login_form.dart';
import 'package:batoidex_bat/ui/forms/verify_email_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:batoidex_bat/services/firebase/GoogleSignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Pokedex());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Pokedex extends StatefulWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getCurrentAppTheme();
    }
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await MyFirebaseData().getIsDarkTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: ChangeNotifierProvider(
        create: (context) => DarkThemeProvider(),
        child: Consumer<DarkThemeProvider>(
            builder: (context, value, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: MyColors.themeData(themeChangeProvider.darkTheme, context),
                  navigatorKey: navigatorKey,
                  title: 'Batoidex',
                  home: Scaffold(
                    body: StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          return const VerifyEmailForm();
                        } else if (snapshot.hasError) {
                          return Stack(children: [
                            Background(),
                            MyFunctions()
                                .buildTextCenterError('Something went wrong!')
                          ]);
                        } else {
                          return Stack(
                              children: [Background(), const LoginForm()]);
                        }
                      },
                    ),
                  ),
                )),
      ),
    );
  }
}
