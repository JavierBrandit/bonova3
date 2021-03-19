import 'dart:math';

import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/pages/player/reproductor_video.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/theme.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Busqueda extends StatefulWidget {
  @override
  _BusquedaState createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  final SearchBarController<Curso> _searchBarController = SearchBarController();
  bool isReplay = false;
  List<Curso> cursos = [];
  List<Curso> cursosMate;
  final cursoService = CursoService();

  final chipList = [
    'matematica', 'fisica', 'quimica', 
    'fracciones', 'potencias',
    'psu', 'pdt'
  ];


  Future<List<Curso>> _resultados(String t) async {
    final cursos = await cursoService.searchCursos(t);
    return cursos;
  }

  Future<List<Curso>> _cargarPrimero() async {
    this.cursosMate = await cursoService.getAllCursos();
    return cursosMate;
  }

  @override
  void initState() { 
    _cargarPrimero();
    // getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // cursoService = Provider.of<CursoService>(context);
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80, right: 15, left: 15),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.tealAccent[700] ),
              borderRadius: BorderRadius.circular(30)
            ),
          ),
          SafeArea(
            child: SearchBar<Curso>(

              textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: -.3),
              hintText: '¿Qué vamos a aprender hoy?',
              iconActiveColor: isDarkTheme? Colors.tealAccent[100] : Colors.tealAccent[700],
              searchBarStyle: SearchBarStyle(backgroundColor: Colors.transparent),
              searchBarPadding: EdgeInsets.only(left: 30, right: 5),
              onSearch: _resultados,
              searchBarController: _searchBarController,
              cancellationWidget: Icon(FluentIcons.dismiss_16_regular, size: 18),
              placeHolder: cursosMate != null? cajaListaRamo() : Center(child: CircularProgressIndicator(strokeWidth: 1)),
              emptyWidget: Center(child: Text("Sin resultados")),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 1,
              // indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
              
              loader: Center(child: CircularProgressIndicator(strokeWidth: 1)),
              header: Column(
                children: <Widget>[
                  Container(
                  height: 40,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    itemCount: chipList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_,i) => chips(chipList[i])
                  ),
                ),
                SizedBox(height: 30)
                ],
              ),
              onCancelled: () {
                print("Cancelado");
              },
              onItemFound: (_, i) => listTileInfo(_),
              // suggestions: cursosMate,
              // buildSuggestion: (_,i){
              //   return ListTile(
              //     title: Text(_.titulo),
              //   );
              // },
            ),
          ),
          
        ],
      ),
    );
  }

  
  chips(String s){

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Chip(
          label: Text( s , style: TextStyle( fontSize: 11, letterSpacing: -.3, color: isDarkTheme? Colors.grey[400] : Colors.grey[800]),),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          backgroundColor: isDarkTheme? BonovaColors.azulNoche[800] : Colors.grey[50],
          side: BorderSide(width: .5, color: isDarkTheme? Colors.teal : Colors.tealAccent[400]),
          autofocus: true,
        ),
      ),
      onTap: () async{
        // this.query.text = s;
        // print(query.text);
        // cursosMate = await cursoService.searchCursos(s);
        setState(() {});
      },
    );
  }
  listTileInfo( Curso curso ){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.only(right: 25),
              child:  Container(height: 70, child: Image.network(curso.portada, fit: BoxFit.cover,)) //Icon(FluentIcons.play_20_regular , size: 17),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.redAccent,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(curso.titulo, style: TextStyle(fontWeight: FontWeight.w500))
                ),
                Text(curso.nivel+'º medio  ·  '+curso.videos.length.toString()+' videos', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
              ],
            )
        ]),
      ),
      onTap: (){
        final videoService = Provider.of<VideoService>(context, listen: false);
        videoService.setCurso(curso);
        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: curso ) ));
      }
    );
  }
  
  cajaBorde(List<Widget> children){
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
        margin: EdgeInsets.all(18),
        padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: isDarkTheme? Colors.white24 : Colors.grey[300] )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
          ),
    );
  }

  logoRamo(String ramo){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(right: 40, top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/logo$ramo.png', height: 13  ),
          ],
        ),
      ),
      onTap: (){
        CursoService cursoService = Provider.of<CursoService>(context, listen: false );
        cursoService.ramo = ramo.toLowerCase();
        Navigator.pushNamed(context, 'ramo');
      }
    );

  }
  
  itemPlaceholder(Curso curso){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [

            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(FluentIcons.circle_16_regular , size: 14),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.redAccent,
                  padding: EdgeInsets.only(bottom: 3),
                  width: MediaQuery.of(context).size.width * .68,
                  child: Text(curso.titulo, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))
                ),
                Text(curso.nivel+'º medio  ·  '+curso.videos.length.toString()+' videos', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300) ),
              ],
            )
        ]),
      ),
      onTap: (){
        final historial = Historial(
          curso: curso,
          guardado: false,
          // progreso: _position.inSeconds / _duration.inSeconds,
          largo: curso.videos.length,
          index: 0,
          prefs: []
        );
        final videoService = Provider.of<VideoService>(context, listen: false);
        videoService.setCurso(curso);
        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: curso, historial: historial ) ));
      }
    );
  }

  cajaListaRamo(){
    return Stack( 
      alignment: AlignmentDirectional.topEnd,
      children: [
      cajaBorde([
        Container(
          padding: EdgeInsets.symmetric(horizontal: 0),
          // height: 150,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: cursosMate.length,
            itemBuilder: (_, i) => itemPlaceholder(cursosMate[i])
        )),


      ]),
      // logoRamo(logo),
              ]);
  }

  
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
