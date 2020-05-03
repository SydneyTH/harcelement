import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcelementapp/authentification/liaisonAuth.dart';
import 'package:harcelementapp/utilisateur/Accueil.dart';
import 'package:provider/provider.dart';
import 'package:harcelementapp/utilisateur/chargement.dart';

class Utilisateur {
  String idUtil;

  Utilisateur({ this.idUtil });

}


class DonneesUtil {

  String email;
  String nomComplet;

  DonneesUtil({ this.email, this.nomComplet});

}

class StreamProvideAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creation d'un obj utilisateur de la classe firebase
  Utilisateur _utilisateurDeFirebaseUser(FirebaseUser user){
    return user != null ? Utilisateur(idUtil: user.uid) : null;
  }

  //diffusion de l'auth de l'utilisateur
  Stream<Utilisateur> get utilisateur {
    return _auth.onAuthStateChanged.map(_utilisateurDeFirebaseUser);
  }
}

class Passerelle extends StatefulWidget {
  @override
  _PasserelleState createState() => _PasserelleState();
}

class _PasserelleState extends State<Passerelle> {
  @override
  Widget build(BuildContext context) {
    final utilisateur = Provider.of<Utilisateur>(context);

    if (utilisateur == null) {
      return LiaisonPageAuth();
    } else {
      return Accueil();
    }
  }
}

class GetCurrentUserData {
  String idUtil;
  GetCurrentUserData({ this.idUtil });

  //ref collection utilisateur
  final CollectionReference collectionUtil = Firestore.instance.collection('utilisateur');
  DonneesUtil _donneesUtilDeSnapshot(DocumentSnapshot snapshot){
    return DonneesUtil(
      nomComplet: snapshot['nomComplet'],
      email: snapshot['email'],
    );
  }


  //obtention doc util en stream

  Stream<DonneesUtil> get donneesUtil {
    return collectionUtil.document(idUtil).snapshots().map(_donneesUtilDeSnapshot);
  }
}
