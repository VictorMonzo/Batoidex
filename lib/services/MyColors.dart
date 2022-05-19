import 'package:flutter/material.dart';

class MyColors {
  final redDegradedLight = const Color(0xfff8a55f);
  final redDegradedDark = const Color(0xfff1665f);

  final blueDegradedLight = const Color(0xff0ce8f9);
  final blueDegradedDark = const Color(0xff45b7fe);

  final greenLight = const Color(0xff6bff8c);

  ColorSwatch<int> getColor(type) {
    switch (type) {
      case 'Grass':
        return Colors.greenAccent;
      case 'Fore':
        return Colors.redAccent;
      case 'Water':
        return Colors.blue;
      case 'Electric':
        return Colors.yellow;
      case 'Rock':
        return Colors.grey;
      case 'Ground':
        return Colors.brown;
      case 'Psychic':
        return Colors.indigo;
      case 'Fighting':
        return Colors.orange;
      case 'Bug':
        return Colors.lightGreenAccent;
      case 'Ghost':
        return Colors.deepPurple;
      case 'Normal':
        return Colors.grey;
      case 'Poison':
        return Colors.deepPurpleAccent;
      default:
        return Colors.pink;
    }
  }

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      dividerColor: isDarkTheme ? Colors.white : Colors.black,




      colorScheme: isDarkTheme ? const ColorScheme.dark(primary: Colors.blue) : const ColorScheme.light(primary: Colors.blue),


      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,


      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),

      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(
          0xffCBDCF8),
      buttonColor: isDarkTheme ? const Color(0xff3B3B3B) : const Color(
          0xffF1F5FB),

      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(
          0xffEECED3),

      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(
          0xffFCE192),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(
          0xff4285F4),

      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(
          0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme
          .of(context)
          .buttonTheme
          .copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}