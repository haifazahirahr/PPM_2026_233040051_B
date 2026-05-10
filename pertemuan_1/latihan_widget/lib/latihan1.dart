import 'package:flutter/material.dart';

//latihan1
void main() {
  runApp(const MaterialApp(
      home: Scaffold(
          body: Center(
              child: Text(
                  'Hello Flutter!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
          ),
      ),
  ));
}

