import 'package:flutter/material.dart';

class MyPetsScreen extends StatefulWidget {
  @override
  _MyPetsScreenState createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis mascotas'),
      ),
      body: ListView(
       children: [
          Wrap(
            children: [
              
            ],
          )
        ],
      ),
    );
  }
}