import 'dart:async';

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:prototipo/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'clicks_e_pontos.dart';
import 'global.dart' as globals;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prototipo/telas.dart';
import 'package:permission_handler/permission_handler.dart';

//Botão generico que fica na Tela inicial e nas demais telas
class BotaoDoGrid extends StatelessWidget{

  final String nome;
  String caminhoImagem;
  final Widget proximaTela;

  BotaoDoGrid({this.nome, this.proximaTela, this.caminhoImagem});

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<Info>(context);
    if(caminhoImagem==null){caminhoImagem='assets/jjj.bmp';};
    return Center(
      child: FlatButton(
        onPressed: (){
          info.zeraClick();
          globals.pontoAle = 0;
          if(proximaTela!=null){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return proximaTela;
                    }
                )
            );
          }
        },
        child: SizedBox(
          width: 150,
          height: 200,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(image: AssetImage('$caminhoImagem'),
                  width: 150.0,height: 100.0,
                  fit: BoxFit.fill,
                ),
              ),
              Text('$nome', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
            ],
          ),
        ),
      ),

    );
  }
}

class BotaoDaLista extends StatelessWidget{
  final Widget titulo;
  final Widget subtitulo;
  final Widget proximaTela;

  BotaoDaLista({this.titulo, this.subtitulo, this.proximaTela});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        if(proximaTela!=null){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context){
                    return proximaTela;
                  }
              )
          );
        }
      },
      child: ListTile(
        title: titulo,
        subtitle: subtitulo,
      ),
    );
  }

}

//fica no leading da appBar pra voltar à tela anterior
class BotaoVolta extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed:() {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white,)
    );
  }
}

class BotaoQuestionario extends StatefulWidget {
  bool certo;
  Widget widget;
  final String opcao;
  BorderRadius borderRadius = BorderRadius.zero;

  BotaoQuestionario({@required this.opcao,@required this.widget, this.certo, this.borderRadius}){
    if(borderRadius == null){borderRadius = BorderRadius.zero;}
  }

  @override
  _BotaoQuestionarioState createState() => _BotaoQuestionarioState();
}

class _BotaoQuestionarioState extends State<BotaoQuestionario> {
  Color cor = Colors.white;



  bool trocaTela(){

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
          return TelaQuestionarioAle();
        }
      )
    );


    return true;

  }

  criaPopUp(bool certo){

    if(widget.certo){
      showDialog(
        barrierDismissible: false,
          context: context,
          builder: (context){
            return RaisedButton(
              color: Colors.transparent,
              onPressed: (){

                Navigator.of(context).pop();
                trocaTela();

              },
              child: AlertDialog(
                content: Icon(Icons.check, color: Colors.green, size: 64,),
                shape: CircleBorder(),


              ),
            );
          }
      );
    }


    else{
      showDialog(
        barrierDismissible: false,
          context: context,
          builder: (context){
            return RaisedButton(
              color: Colors.transparent,
              onPressed: (){
                Navigator.of(context).pop();
              },

              child: AlertDialog(
                content: Icon(Icons.clear, color: Colors.red, size: 64,),
                shape: CircleBorder(),
              ),
            );
          }
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    var info = Provider.of<Info>(context);
    return FlatButton(
      onPressed: (){
        if(widget.certo == null){widget.certo = false;}

        if(widget.certo){

          info.incrementClick();

          setState(() {
            cor = Colors.green;
          });

          criaPopUp(widget.certo);

        }
        else{

          if(info.click > 0)
            {
              info.decrementClick();
            }

          setState(() {
            cor = Colors.red;
          });
          criaPopUp(widget.certo);
        }

        setState(() {});

      },
      child: SizedBox(
        width: 150,
        height: 116,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: widget.borderRadius,
              child: widget.widget,
            ),
            Text(
              '${widget.opcao}',
              style: TextStyle(color: cor),
            )
          ],
        ),
      ),
    );
  }
}

//Card que pode ser precionado. É utilizado na tela das materias para indicar assuntos
class CardBotao extends StatelessWidget{
  final String titulo;
  final String subtitulo;
  final Widget proximaTela;

  CardBotao({@required this.titulo, @required this.subtitulo, this.proximaTela});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[600],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.blueGrey[600],
        onPressed: (){
          if(proximaTela!=null){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context){
                      return proximaTela;
                    }
                )
            );
          }
        },
        child: ListTile(
          title: Text('$titulo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('$subtitulo',
            style: TextStyle(color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

class BotaoFlutuanteTeoria extends FloatingActionButton{

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: (){},
    );
  }
}