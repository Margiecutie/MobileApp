import 'package:flutter/material.dart';
import 'home.dart';
import 'egg_hatching_guide.dart';
import 'pets_data.dart';
import 'welcome_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => WelcomePage(),
      '/home': (context) => GardenPetApp(),
      '/guide': (context) => EggHatchingGuidePage(pets: pets),
    },
  ));
}
