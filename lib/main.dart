import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototipo/clicks_e_pontos.dart';
import 'package:prototipo/telas.dart';
import 'package:prototipo/widgets.dart';
import 'package:provider/provider.dart';


void main() => runApp(
    ChangeNotifierProvider(
      create: (context) => Info(),
      child: MyApp(),
    )
);

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: TelaHome(),
      routes: <String, WidgetBuilder>{
        'TelaMat': (BuildContext context){
          return TelaMat();
        },
        'TelaMed': (BuildContext context){
          return TelaMed();
        }
      }
    );
  }
}








