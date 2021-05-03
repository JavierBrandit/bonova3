import 'dart:math';

import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/pages/player/reproductor_video.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:bonova0002/theme.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


class Busqueda extends StatefulWidget {
  @override
  _BusquedaState createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  final SearchBarController<Historial> _searchBarController = SearchBarController();
  bool isReplay = false;
  List<Historial> cursos = [];
  List<Historial> cursosMate;
  final cursoService = CursoService();

  final chipList = [
    'matematica', 'fisica', 'quimica', 
    'fracciones', 'potencias',
    'psu', 'pdt'
  ];


  Future<List<Historial>> _resultados(String t) async {
    final cursos = await cursoService.searchCursos(t);
    setState(() {});
    return cursos;
  }

  Future<List<Historial>> _cargarPrimero() async {
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
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, right: 15, left: 15),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: isDarkTheme? Colors.blueGrey[900].withOpacity(.9) : Colors.blueGrey[100].withOpacity(.5),
                // border: Border.all(width: 2, color: Colors.tealAccent[700] ),
                borderRadius: BorderRadius.circular(30)
              ),
            ),
            SearchBar<Historial>(
                
                textStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: -.3),
                hintText: '¿Qué vamos a aprender hoy?',
                iconActiveColor: isDarkTheme? Colors.tealAccent[100] : Colors.tealAccent[700],
                searchBarStyle: SearchBarStyle(backgroundColor: isDarkTheme? Colors.blueGrey[900].withOpacity(.9) : Colors.blueGrey[100].withOpacity(.5),
                                               borderRadius: BorderRadius.circular(30),
                                               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0)
                                               ),
                searchBarPadding: EdgeInsets.only(left: 20, right: 20),
                onSearch: (s) => _resultados(s),
                searchBarController: _searchBarController,
                cancellationWidget: Icon(FluentIcons.dismiss_16_regular, size: 18),
                placeHolder: cursosMate != null? cajaListaRamo() : Center(child: CircularProgressIndicator(strokeWidth: 1)),
                emptyWidget: Center(child: Text("Sin resultados")),
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
          ],
        ),
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
      onTap: () async {
        await _resultados(s);
        // this.query.text = s;
        // print(query.text);
        // cursosMate = await cursoService.searchCursos(s);
        setState(() {});
      },
    );
  }
  listTileInfo( Historial h ){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            

            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child:  Container(height: 70, child: Image.network(h.curso.portada, fit: BoxFit.cover,)) //Icon(FluentIcons.play_20_regular , size: 17),
                  ),
                h.progreso != null 
                  ? Container(
                    color: Colors.black12,
                    width: 70*16/9,
                    height: 5,
                  ) : Container(),
                h.progreso != null
                  ? Container(
                    color: Colors.tealAccent[400],
                    width: 70*16/9 * (h.index + h.progreso)/h.curso.videos.length,
                    height: 5,
                  ) : Container(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.redAccent,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(h.curso.titulo, style: TextStyle(fontWeight: FontWeight.w500))
                ),
                Text(h.curso.nivel+'º medio  ·  '+h.curso.videos.length.toString()+' videos', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                SizedBox(height: 20),

                // h.progreso != null
                // ? Container(
                //   width: MediaQuery.of(context).size.width * .5,
                //   child: Text('Continuar', textAlign: TextAlign.end, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.tealAccent[700] ),)) : Container(),
              ],
            )
        ]),
      ),
      onTap: (){
        CursoService cursoService = Provider.of<CursoService>(context, listen: false );
        AuthService authService = Provider.of<AuthService>(context, listen: false );
        // videoService.setCurso( historial.curso );
        
        final socketService = Provider.of<SocketService>(context, listen: false );
        
        // final historialx = Historial(
        //   curso: historial.curso,
        //   usuario: authService.usuario.uid,
        //   // guardado: false,
        //   // progreso: _position.inSeconds / _duration.inSeconds,
        //   largo: historial.curso.videos.length,
        //   // index: 0,
        //   // prefs: []
        // );

        cursoService.setReproduciendo(true);
        cursoService.setHistorial(h);
        cursoService.setDisposed(false);

        socketService.emit('historial', {
          'curso': h.curso.cid,
          'usuario': authService.usuario.uid
        });

        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: h.curso, historial: h ) ));
      }
    );
  }
  
  cajaBorde(List<Widget> children){
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
        margin: EdgeInsets.all(15),
        padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        // width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: .2, color: isDarkTheme? Colors.white24 : Colors.grey[300] )
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
  
  itemPlaceholder(Historial historial){
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 3),
        child: Row(
          children: [
            

            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Container(
                height: 30,
                padding: EdgeInsets.only(right: 20),
                child: FadeInImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(historial.curso.portada),
                  placeholder: AssetImage('assets/placeholder.png'),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.redAccent,
                  padding: EdgeInsets.only(bottom: 5),
                  width: MediaQuery.of(context).size.width * .6,
                  child: Text(historial.curso.titulo, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, letterSpacing: -.4))
                ),
                Text(historial.curso.nivel+'º medio  ·  '+historial.curso.videos.length.toString()+' videos', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600) ),
              ],
            )
        ]),
      ),
      onTap: (){
        CursoService cursoService = Provider.of<CursoService>(context, listen: false );
        AuthService authService = Provider.of<AuthService>(context, listen: false );
        // videoService.setCurso( historial.curso );
        
        final socketService = Provider.of<SocketService>(context, listen: false );
        
        // final historialx = Historial(
        //   curso: historial.curso,
        //   usuario: authService.usuario.uid,
        //   // guardado: false,
        //   // progreso: _position.inSeconds / _duration.inSeconds,
        //   largo: historial.curso.videos.length,
        //   // index: 0,
        //   // prefs: []
        // );

        cursoService.setReproduciendo(true);
        cursoService.setHistorial(historial);
        cursoService.setDisposed(false);

        socketService.emit('historial', {
          'curso': historial.curso.cid,
          'usuario': authService.usuario.uid
        });

        Navigator.push(context, MaterialPageRoute(builder: (_) => PlayPage( curso: historial.curso, historial: historial ) ));
      }
    );
  }

  cajaListaRamo(){
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start,
      // alignment: AlignmentDirectional.topEnd,
      children: [
      // cajaBorde([

        HeaderTitulo(titulo: 'últimos cursos', paginaDestino: ''),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          // height: 150,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: cursosMate.length,
            itemBuilder: (_, i) => itemPlaceholder(cursosMate[i])
        )),
        SizedBox( height: 20),

        HeaderTitulo(titulo: 'categorias', paginaDestino: ''),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 7, top: 20 ),
                  // height: 80,
                  width: MediaQuery.of(context).size.width * .42,
                  child: 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                        // width: 300,
                        child: Image.asset(isDarkTheme? 'assets/portadaMatematicaRamoNoche.png':'assets/portadaMatematicaRamo.png')
                      ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 7, top: 10 ),
                  height: 21,
                  // width: MediaQuery.of(context).size.width * .44,
                  child: 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                        // width: 300,
                        child: Image.asset(isDarkTheme? 'assets/logoMatematicaNoche.png':'assets/logoMatematica.png', 
                                      color:isDarkTheme?null: Colors.grey[700],
                                      height: 7,
                                      )
                      ),
                ),
            ]),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 7, top: 20 ),
                  // height: 80,
                  width: MediaQuery.of(context).size.width * .42,
                  child: 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                        // width: 300,
                        child: Image.asset(isDarkTheme? 'assets/portadaFisicaRamoNoche.png':'assets/portadaFisicaRamo.png')
                      ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 7, top: 10 ),
                  height: 21,
                  // width: MediaQuery.of(context).size.width * .44,
                  child: 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                        // width: 300,
                        child: Image.asset(isDarkTheme? 'assets/logoFisicaNoche.png':'assets/logoFisica.png', 
                                    color:isDarkTheme?null: Colors.grey[700],
                                    height: 7,
                                    )
                      ),
                ),
            ]),
            SizedBox(width: 20),
          ],
        ),

      // ]),


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
