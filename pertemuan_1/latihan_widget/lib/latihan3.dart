import 'package:flutter/material.dart';

//latihan3
void main() {
  runApp(MaterialApp(
   home: Scaffold(
       body: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: const [
             Icon(Icons.star),
           Icon(Icons.favorite),
           Icon(Icons.thumb_up),
           ],
       ),
           ],
       ),
   ),
  ));
}