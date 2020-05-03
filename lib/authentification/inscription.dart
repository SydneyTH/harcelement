import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcelementapp/utilisateur/chargement.dart';

class Inscription extends StatefulWidget {

  final Function basculer;
  Inscription({this.basculer});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  //collection user depuis firestore
  final CollectionReference collectionUser = Firestore.instance.collection(('utilisateurs'));
  
  String nomComplet = '';
  String email = '';
  String mdp = '';
  String confirmMdp = '';

  bool chargement = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    FirebaseAuth.instance.currentUser().then((FirebaseUser user){
      setState(() {
        this.currentUser = user;
      });
    });

    String _idUser(){
      if(currentUser != null){
        return currentUser.uid;
      }else{
        return "pas d'utilisateur de ce nom";
      }
    }
    return chargement ? Chargement() : Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key : _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch ,
              children: <Widget>[
                Image.asset('assets/BDE.png', height: 100.0, width: 100.0),
                SizedBox(height: 30.0),
                Center(
                  child: Text("Création profil application",
                    style: Theme.of(context).textTheme.title),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nom Complet',
                    border: OutlineInputBorder()
                  ),
                  validator: (val) => val.isEmpty ? 'Entrez un nom' : null,
                  onChanged: (val) => nomComplet = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder()
                  ),
                  validator: (val) => val.length == null ? 'entrez un email'
                      '' : null,
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder()
                  ),
                  validator: (val) => val.length < 8 ? 'Entrez un mot de passe '
                      'passe d\' au moins 8 caractères' : null,
                  onChanged: (val) => mdp = val,
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirmer mot de passe',
                      border: OutlineInputBorder()
                  ),
                  onChanged: (val) => confirmMdp = val,
                  validator: (val) => confirmMdp!=mdp ? 'le mot de passe ne correspond pas' : null,
                  obscureText: true,
                ),
                SizedBox(height: 30.0),
                FlatButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {

                      setState(() => chargement = true);
                      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: mdp);

                          await collectionUser.document(_idUser()).setData({
                        'idUser' : _idUser(),
                        'nomComplet' : nomComplet,
                        'emailUser' : email,
                      });

                      if(result == null){
                        setState(() => chargement = true);
                      }
                    }
                  },
                  color: Colors.amber,
                  child: Text("inscription"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
                OutlineButton(
                  onPressed: (){
                    setState(() {
                      widget.basculer();
                    });
                  },
                  borderSide:BorderSide(width: 1.0, color: Colors.black),
                  child: Text('Connexion'),
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