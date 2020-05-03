import 'package:flutter/material.dart';
import 'package:harcelementapp/authentification/controlAuth.dart';
import 'package:provider/provider.dart';

void main() => runApp((MonApp()));

class MonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Utilisateur>.value(
      value: StreamProvideAuth().utilisateur,
      child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Passerelle(),
      ),
    );
  }
}
