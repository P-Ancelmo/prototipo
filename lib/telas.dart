import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototipo/botoes.dart';
import 'package:prototipo/widgets.dart';
import 'package:prototipo/questoes.dart';
import 'package:provider/provider.dart';
import 'clicks_e_pontos.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'global.dart' as globals;

//tela inicial
class TelaHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Base(
      tituloAppBar: Text('Minerva Short'),
      widget: Grid(
        filhos: <Widget>[
          BotaoDoGrid(nome: 'Matemática',caminhoImagem: 'assets/matematica.png' ,proximaTela: TelaMat(),),
          BotaoDoGrid(nome: 'Saúde',caminhoImagem: 'assets/saude.png', proximaTela: TelaMed(),)
        ],
      ),
    );
  }
}

//tela da materia matemática
class TelaMat extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Base(
      leading: BotaoVolta(),
      tituloAppBar: Text('Matemática'),
      widget: Grid(
        filhos: <Widget>[
          BotaoDoGrid(nome: 'Cálculo',caminhoImagem:'assets/calculo.png' ,proximaTela: TelaCalculo(),)
        ],
      ),
    );
  }
}

//tela da materia de saúde
class TelaMed extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Base(
      leading: BotaoVolta(),
      tituloAppBar: Text('Saúde'),
      widget: Grid(
        filhos: <Widget>[
          BotaoDoGrid(nome: 'Anatomia',caminhoImagem:'assets/anatomia.png' ,proximaTela: TelaAnatomia(),)
        ],
      ),
    );
  }
}

//tela da materia cálculo
class TelaCalculo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Base(
      tituloAppBar: Text('Cálculo'),
      widget: Column(
        children: <Widget>[
          CardBotao(
            titulo: 'Derivada',
            subtitulo: 'Definição',
          ),

          CardBotao(
            titulo: 'Integral',
            subtitulo: 'Definição, integral por partes, por substituição e funçoes parciais',
            proximaTela: TelaQuestionario(
              tituloAppBar: Text('Integral'),
              telaTeoria: TelaTeoria(
                <TextoTeoria>[
                  TextoTeoria(
                    titulo: 'Integral',
                    descricao: 'É o inverso da derivada, dessa forma, ao ver integral de *alguma coisa*, deve-se pensar qual a função cuja derivada seja essa *alguma coisa*',
                  ),
                  /*TextoTeoria(
                    titulo: 'Integral por substituição',
                    descricao: '',
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//tela da materia anatomia
class TelaAnatomia extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Base(
      tituloAppBar: Text('Anatomia'),
      widget: Column(
        children: <Widget>[
          CardBotao(
            titulo: 'Sistema articular',
            subtitulo: '',
            proximaTela: TelaQuestionario(
              tituloAppBar: Text('Sistema articular'),
              //telaTeoria: TelaTeoria(),
            ),
          ),

          CardBotao(
            titulo: 'Sistema circulatório',
            subtitulo: '',
            proximaTela: TelaQuestionario(
              tituloAppBar: Text('Sistema circulatório'),
            ),
          ),

          CardBotao(
            titulo: 'Sistema digestório',
            subtitulo: '',
            proximaTela: TelaQuestionario(
              tituloAppBar: Text('Sistema digestório'),
            ),
          ),

          CardBotao(
            titulo: 'Sistema excretor',
            subtitulo: '',
            proximaTela: TelaQuestionario(
              tituloAppBar: Text('Sistema excretor'),
            ),
          ),

          CardBotao(
            titulo: 'Sistema muscular',
            subtitulo: '',
            proximaTela: TelaQuestionario(
              tituloAppBar: Text('Sistema muscular'),
            ),
          ),

          CardBotao(
            titulo: 'Sistema respiratório',
            subtitulo: '',
            proximaTela: TelaQuestionario(
              telaQuestionarioAle: TelaQuestionarioAle(),
              tituloAppBar: Text('Sistema respiratório'),
            ),
          ),
        ],
      ),
    );
  }
}

//tela da parte onde ficam os questionários e a parte teórica - é a mesma tela para todos
class TelaQuestionario extends StatelessWidget{
  final Widget tituloAppBar;
  final Widget telaTeoria;
  final Widget telaQuestionarioAle;
  final Widget telaQuestionarioTop;
  final Widget telaQuestionarioTemp;

  TelaQuestionario({this.tituloAppBar,this.telaTeoria, this.telaQuestionarioAle, this.telaQuestionarioTop, this.telaQuestionarioTemp}){
    globals.pontoAle = 0;
  }

  @override
  Widget build(BuildContext context) {

    return Base(
      tituloAppBar: tituloAppBar,
      widget: Grid(
        filhos: <Widget>[
          BotaoDoGrid(nome: 'Teoria',caminhoImagem:'assets/teoria.png',proximaTela: telaTeoria,),
          BotaoDoGrid(nome: 'Questionario aleatório',caminhoImagem:'assets/questionario.png' ,proximaTela: telaQuestionarioAle,),
          BotaoDoGrid(nome: 'Questionario por tópico',caminhoImagem:'assets/questionario.png' ,proximaTela: telaQuestionarioTop),
          BotaoDoGrid(nome: 'Questionario c/ Tempo',caminhoImagem:'assets/questionario.png' ,proximaTela: telaQuestionarioTemp),
        ],
      ),
    );
  }
}

// tela na qual fica a teoria
class TelaTeoria extends StatelessWidget{

  final List<TextoTeoria> textos;

  bool carregando = true;
  String url;
  FloatingActionButton botaoFlutuante;

  TelaTeoria(this.textos, {this.url, this.botaoFlutuante});



  @override
  Widget build(BuildContext context) {

    return Base(
      tituloAppBar: Text('Teoria'),
      widget: Column(
        children: textos,
      ),
      floatingActionButton: botaoFlutuante,
    );
  }
}

//estrutura utilizada para montar a TelaTeoria - predefinições de cor, tamanho e estilo do texto
class TextoTeoria extends StatelessWidget{

  final String titulo;
  final String descricao;

  TextoTeoria({@required this.titulo, @required this.descricao});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox( height: 16.0,),
        Text('$titulo',
          style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox( height: 8.0,),
        Divider(color: Colors.blueGrey[600]),
        const SizedBox( height: 8.0,),
        Text('$descricao',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox( height: 16.0,),
        //Divider(color: Colors.blueGrey[600]),
      ],
    );
  }
}

class TelaQuestionarioAle extends StatefulWidget {
  
  TelaQuestionarioAle(){}
  
  @override
  _TelaQuestionarioAleState createState() => _TelaQuestionarioAleState();
}

class _TelaQuestionarioAleState extends State<TelaQuestionarioAle> {

  final array = new Array();

  chama_array(){
    return array.aleatorio();
  }


  @override
  Widget build(BuildContext context) {


    return chama_array();
  }
}
