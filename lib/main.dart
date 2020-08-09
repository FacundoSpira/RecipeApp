import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.dart';
import 'package:recipe_app/pages/infoPage.dart';
import 'package:recipe_app/pages/edit_add.dart';
import 'package:recipe_app/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => Loading(),
      '/infoPage': (context) => InfoPage(),
      '/home': (context) => Home(),
      '/edit_add': (context) => EditAdd(),
    },
  ));
}
