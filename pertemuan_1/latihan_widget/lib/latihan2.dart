import 'package:flutter/material.dart';

//latihan2
void main() {
   runApp(MaterialApp(
     home: Scaffold(
       body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(child: Text('BOX')),
        ),
       ),
     ),
   ));
}
