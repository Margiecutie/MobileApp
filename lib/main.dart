import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFF7B3F00),
      appBar: AppBar(
        title: Text(
          'Grow A Garden Pet Info',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Color(0xFF59C639),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF59C639),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.pets, color: Colors.white),           // Dog
              Icon(Icons.pets, color: Colors.brown),            // Chicken
              Icon(Icons.pets, color: Colors.blue),           // Cat (placeholder)
              Icon(Icons.home, color: Colors.white),           // Home
              Icon(Icons.pets, color: Colors.deepOrange),   // Cow (nature themed)
              Icon(Icons.pets, color: Colors.purple),     // Dragonfly (closest)
              Icon(Icons.pets, color: Colors.red),     // Owl (placeholder)
            ],
          ),
        ),
      ),
    ),
  ));
}
