// import 'package:flutter/material.dart';

// class Biblioteca extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Biblioteca', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
//         elevation: 0,
//       ),
//       body: Center(
//         child: Container(
//           child: Text('Hello World'),
//         ),
//       ),
//     );
//   }
// }

import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/videos_service.dart';
import 'package:bonova0002/src/widgets/carrusel_horizontal.dart';
import 'package:flutter/material.dart';
  
class Biblioteca extends StatefulWidget {

  @override
  _BibliotecaState createState() => _BibliotecaState();
}

class _BibliotecaState extends State<Biblioteca> {
  List<Curso> misCursos;
  ScrollController _scrollController;
  final authService = AuthService();

  @override
  void initState() {
    this._cargarGuardados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biblioteca', style: TextStyle( letterSpacing: -.5 )),
      ),
      body: misCursos != null
              ? Container()//_listaCursos()
              : Center(child: CircularProgressIndicator( strokeWidth: 1))
    );
  }

  _cargarGuardados() async {
    // this.misCursos = await authService.verGuardados();
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
        //itemBuilder: (_, i) => carruselVertical(context, misCursos[i]),
        itemCount: misCursos.length,
        controller: _scrollController, 
        separatorBuilder: (_, i) => Divider(color: Colors.grey, indent: 15, endIndent: 15),
      //   controller: PageController(
      //     viewportFraction: 0.57 ), 
      ),
    );
  }
}