import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcelementapp/utilisateur/chargement.dart';

class Connexion extends StatefulWidget {

  final Function basculer;
  Connexion({this.basculer});

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String mdp = '';

  bool chargement = false;

  final _keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return chargement ? Chargement() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/BDE.png',height: 100.0,width: 100.0),
                Center(
                    child: Text('bienvenue',
                        style: Theme.of(context).textTheme.title)
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'email',
                      border: OutlineInputBorder()
                  ),
                  validator: (val) => val.isEmpty ? 'entrez un email' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder()
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 8 ? 'entrez un mot de passe' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () async {
                    if(_keyForm.currentState.validate()){

                      setState(() => chargement = true);

                      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: mdp);
                      if(result == null){
                        setState(() => chargement = false);
                      }

                    }
                  },
                  color: Colors.amber,
                  child: Text('Connexion'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                OutlineButton(
                  onPressed: (){
                    setState(() {
                      widget.basculer();
                    });
                  },
                  borderSide:BorderSide(width: 1.0, color: Colors.black),
                  child: Text('Créer un compte'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


