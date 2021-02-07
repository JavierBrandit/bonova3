import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:flutter/material.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:provider/provider.dart';

class RamoPage extends StatefulWidget {

  @override
  _RamoPageState createState() => _RamoPageState();
}

class _RamoPageState extends State<RamoPage> {

  ScrollController _scrollController;
  CursoService cursoService;
  String ramo;
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
              HeaderTitulo(titulo: 'Primero Medio', paginaDestino: '',),
              _listaNivel(cursos1),
              HeaderTitulo(titulo: 'Segundo Medio', paginaDestino: '',),
              _listaNivel(cursos2),
              HeaderTitulo(titulo: 'Tercero Medio', paginaDestino: '',),
              _listaNivel(cursos3),
              HeaderTitulo(titulo: 'Cuarto Medio', paginaDestino: '',),
              _listaNivel(cursos4),

            ],
          )),
        ],
      ),
    );
  }

  SliverAppBar _switchAppBar( String ramo ) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    switch( ramo ) {
      case 'matematica':
        return _appBarItem( isDarkTheme? 'assets/portadaMatematicaRamoNoche.png' : 'assets/portadaMatematicaRamo.png',
                            isDarkTheme? 'assets/logoMatematicaNoche.png' : 'assets/logoMatematica.png');
      case 'fisica':
        return _appBarItem( isDarkTheme? 'assets/portadaFisicaRamoNoche.png' : 'assets/portadaFisicaRamo.png',
                            isDarkTheme? 'assets/logoFisicaNoche.png' : 'assets/logoFisica.png');
      
      default: return _appBarItem('','');
        }
  }
  
  SliverAppBar _appBarItem( String banner, String titulo ) {
    return SliverAppBar(
        //title: Text( titulo, style: TextStyle( fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black ) ),
        title: Container( child: Image.asset(titulo), height: 24,),
        elevation: 0.0,
        collapsedHeight: 57,
        //backgroundColor: Colors.white,
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

  Widget _listaNivel( List<Curso> cursosx ) {
    return Container(
      height: 330,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(context, cursosx[i]),
        itemCount: cursosx.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }



}
