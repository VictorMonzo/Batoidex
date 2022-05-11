import 'package:batoidex_bat/services/firebase/FirebaseAuth.dart';
import 'package:batoidex_bat/ui/background/background.dart';
import 'package:batoidex_bat/ui/forms/login_form.dart';
import 'package:batoidex_bat/ui/pokemon/pokedex_screen.dart';
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

class Pokedex extends StatelessWidget {
  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Batoidex',
          home: Scaffold(
            body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return const PokedexScreen();
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something Went Wrong!'));
                } else {
                  return Stack(children: [Background(), const LoginForm()]);
                }
              },
            ),
          ),
        ));
  }

/*//ESTO FUNCIONA
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Batoidex',
          home: Scaffold(
            body: Stack(
              children: [
                Background(),
                const LoginForm(),
              ],
            ),
          ),
        ));
  }*/

/*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batoidex',
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const PokedexScreen();
            } else {
              return Stack(
                children: [
                  Background(),
                  const LoginForm(),
                ],
              );
            }
          },
        ),
      ),
    );
  }*/

/*@override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PokedexScreen();
            } else {
              return Text("aaaaa");
            }
          },
        ), // StreamBuilder
      );*/ // Scaffold
}
