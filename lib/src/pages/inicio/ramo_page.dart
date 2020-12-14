import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:bonova0002/src/widgets/ramopage_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RamoPage extends StatefulWidget {

  @override
  _RamoPageState createState() => _RamoPageState();
}

class _RamoPageState extends State<RamoPage> {

  //final videoService = new VideoService();
  //final cursoService = new CursoService();
  //List<Video> videos = [];
  ScrollController _scrollController;
  CursoService cursoService;
  String ramo;
  //final branding = new Branding();
  List<Curso> cursos1 = [];
  List<Curso> cursos2 = [];
  List<Curso> cursos3 = [];
  List<Curso> cursos4 = [];

  @override
    void initState() { 
      super.initState();
      this.cursoService = Provider.of<CursoService>(context, listen: false);
      this._cargarPrimero(cursoService.ramo, '1');
      this._cargarSegundo(cursoService.ramo, '2');
      this._cargarTercero(cursoService.ramo, '3');
      this._cargarCuarto( cursoService.ramo, '4');
    }
    
  @override
  Widget build(BuildContext context) {
      this.cursoService = Provider.of<CursoService>(context, listen: false);
      this.ramo = cursoService.ramo;
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          _switchAppBar(ramo),
          SliverToBoxAdapter( child: Column(
            children: <Widget>[
              //SizedBox(height: 20),
              HeaderTitulo(titulo: 'Primero Medio', paginaDestino: '',),
              _listaPrimero(),
              HeaderTitulo(titulo: 'Segundo Medio', paginaDestino: '',),
              _listaSegundo(),
              HeaderTitulo(titulo: 'Tercero Medio', paginaDestino: '',),
              _listaTercero(),
              HeaderTitulo(titulo: 'Cuarto Medio', paginaDestino: '',),
              _listaCuarto(),

            ],
          )),
        ],
      ),
    );
  }

  SliverAppBar _switchAppBar( String ramo ) {
    switch( ramo ) {
          case 'matematica': return _appBarItem('assets/portadaMatematicaRamo.png', 'assets/logoMatematica.png');
          case 'fisica': return _appBarItem('assets/portadaFisicaRamo.png', 'assets/logoFisica.png');
          default: return _appBarItem('','');
        }
  }
  
  SliverAppBar _appBarItem( String banner, String titulo ) {
    return SliverAppBar(
        //title: Text( titulo, style: TextStyle( fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black ) ),
        title: Container( child: Image.asset(titulo), height: 24,),
        elevation: 0.0,
        collapsedHeight: 57,
        backgroundColor: Colors.white,
        expandedHeight: 65,
        //snap: true,
        floating: true,
        pinned: true,
        
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: 
              Image.asset(banner, fit: BoxFit.cover ),
          ),
        );
}
  
  _cargarPrimero( String ramox, String nivelx ) async {
    this.cursos1 = await cursoService.getCursos(ramox, nivelx);
    setState((){});
  }
  _cargarSegundo( String ramox, String nivelx ) async {
    this.cursos2 = await cursoService.getCursos(ramox, nivelx);
    setState((){});
  }
  _cargarTercero( String ramox, String nivelx ) async {
    this.cursos3 = await cursoService.getCursos(ramox, nivelx);
    setState((){});
  }
  _cargarCuarto(  String ramox, String nivelx ) async {
    this.cursos4 = await cursoService.getCursos(ramox, nivelx);
    setState((){});
  }

  Widget _listaPrimero() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursos1[i]),
        itemCount: cursos1.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }
  Widget _listaSegundo() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursos2[i]),
        itemCount: cursos2.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }
  Widget _listaTercero() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursos3[i]),
        itemCount: cursos3.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }
  Widget _listaCuarto() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursos4[i]),
        itemCount: cursos4.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }


}
