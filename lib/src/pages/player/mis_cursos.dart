import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:flutter/material.dart';
  
class MisCursos extends StatefulWidget {

  @override
  _MisCursosState createState() => _MisCursosState();
}

class _MisCursosState extends State<MisCursos> {
  List<Curso> misCursos;
  ScrollController _scrollController;
  final cursoService = CursoService();

  @override
  void initState() {
    this._cargarMisCursos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Continuar Viendo', style: TextStyle( letterSpacing: -.5 )),
      ),
      body: misCursos != null
              ? _listaCursos()
              : Center(child: CircularProgressIndicator( strokeWidth: 1))
    );
  }

  _cargarMisCursos() async {
    this.misCursos = await cursoService.getAllCursos();
    setState((){});
  }

  Widget _listaCursos() {
    return Container(
      // height: 270,
      width: double.infinity,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 0),
        physics: BouncingScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // pageSnapping: false,
        itemBuilder: (_, i) => carruselVertical(context, misCursos[i]),
        itemCount: misCursos.length,
        controller: _scrollController, 
        separatorBuilder: (_, i) => Divider(color: Colors.grey, indent: 15, endIndent: 15),
      //   controller: PageController(
      //     viewportFraction: 0.57 ), 
      ),
    );
  }
}