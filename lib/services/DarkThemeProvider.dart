import 'package:batoidex_bat/services/firebase/FirebaseData.dart';
import 'package:flutter/cupertino.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    MyFirebaseData().saveIsDarkTheme(value);
    notifyListeners();
  }
}