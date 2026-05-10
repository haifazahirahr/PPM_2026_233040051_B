import 'package:flutter/material.dart';

//latihan4
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: const Center(child: Text('Home')),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(Icons.home),
          Icon(Icons.shopping_cart),
          Icon(Icons.favorite),
          Icon(Icons.person),
        ],
      ),
    ),
  ));
}