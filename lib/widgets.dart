import 'package:prototipo/clicks_e_pontos.dart';
import 'package:provider/provider.dart';

import 'global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:prototipo/botoes.dart';
import 'package:flutter/widgets.dart';

//Base de todas as telas que serão criadas
class Base extends StatefulWidget{
  final Widget widget;
  final Widget tituloAppBar;
  final Widget leading;
  FloatingActionButton floatingActionButton;
  Base({this.widget, this.tituloAppBar,this.leading, this.floatingActionButton});

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        leading: widget.leading,
        title: widget.tituloAppBar,
        //backgroundColor: Colors.deepPurple.shade600,
      ),
      body: Center(
        child: widget.widget,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}

//GridView pré-configurado pra ficar na tela principal e demais telas - recebe como filhos(children) BotaoDoGrid
class Grid extends StatelessWidget{
  final String nomeBotao;
  final List<Widget> filhos;
  Grid({this.nomeBotao, this.filhos});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: filhos,
    );
  }
}

class GridQuestionario extends StatefulWidget {
  Widget widgetOpcaoA;
  Widget widgetOpcaoB;
  Widget widgetOpcaoC;
  Widget widgetOpcaoD;
  AssetImage questao;
  bool opcaoA;
  bool opcaoB;
  bool opcaoC;
  bool opcaoD;
  BorderRadius borderRadius;



  GridQuestionario({this.borderRadius,this.questao, this.widgetOpcaoA,this.widgetOpcaoB, this.widgetOpcaoC, this.widgetOpcaoD, this.opcaoA,this.opcaoB, this.opcaoC, this.opcaoD}){
    if(widgetOpcaoA == null){widgetOpcaoA = Image.asset('assets/jjj.bmp');}
    if(widgetOpcaoB == null){widgetOpcaoB = Image.asset('assets/jjj.bmp');}
    if(widgetOpcaoC == null){widgetOpcaoC = Image.asset('assets/jjj.bmp');}
    if(widgetOpcaoD == null){widgetOpcaoD = Image.asset('assets/jjj.bmp');}
    if(questao == null){questao = AssetImage('assets/jjj.bmp');}
    if(borderRadius == null){borderRadius = BorderRadius.zero;}
  }

  @override
  _GridQuestionarioState createState() => _GridQuestionarioState();
}

class _GridQuestionarioState extends State<GridQuestionario> {
  

  @override
  Widget build(BuildContext context) {
    var info = Provider.of<Info>(context);
    return Base(
      tituloAppBar: Text('Questionario -- ${info.click}/${globals.pontoAle}', style: TextStyle(color: Colors.white),),
      widget: ListView(

        children: <Widget>[
          Image(
            image: widget.questao,
          ),

          ButtonBar(
            buttonPadding: EdgeInsets.all(8),
            children: <Widget>[

              BotaoQuestionario(borderRadius: widget.borderRadius, opcao: 'a)', widget: widget.widgetOpcaoA, certo: widget.opcaoA,),
              BotaoQuestionario(borderRadius: widget.borderRadius,opcao: 'b)', widget: widget.widgetOpcaoB, certo: widget.opcaoB,),
            ],
          ),

          ButtonBar(
            buttonPadding: EdgeInsets.all(8),
            children: <Widget>[
              BotaoQuestionario(borderRadius: widget.borderRadius,opcao: 'c)', widget: widget.widgetOpcaoC, certo: widget.opcaoC,),
              BotaoQuestionario(borderRadius: widget.borderRadius,opcao: 'd)', widget: widget.widgetOpcaoD, certo: widget.opcaoD,),
            ],
          ),
        ],
      ),
    );
  }
}