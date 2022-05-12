import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_data.dart';

class MyFunctions {
  toast(msg, color) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: color,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static const myUser = UserData(
      imagePath:
          'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
      name: 'Sarah Abs',
      about:
          'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
      isDarkMode: false,
      creationDate: '11/11/11',
      numPokeFavs: 23);
}
