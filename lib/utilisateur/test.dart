import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: TutorialHome(),
  ));


}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('harcelement app'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile())
              );
            },
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child:  IconButton(
            onPressed: (){
              print("test");
            },
          iconSize: 200.0,
          icon: Icon(
            Icons.block,
            color: Colors.red,




          ),
        )
      ),

    );
  }
}

class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "retour",
            onPressed: null,
          )
        ],
      ),
      body: Center(
        child: Icon(Icons.accessibility),
       ),
      );

  }
}