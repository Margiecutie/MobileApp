import 'package:flutter/material.dart';
import 'home.dart';
import 'egg_hatching_guide.dart';
import 'pets_data.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => GardenPetApp(),
      '/guide': (context) => EggHatchingGuidePage(pets: pets),
    },
  ));
}
