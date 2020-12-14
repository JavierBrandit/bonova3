import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:flutter/material.dart';

import 'carrusel_horizontal.dart';

class RamoPageWidgets {

  List<Curso> cursos1 = [];
  List<Curso> cursos2 = [];
  List<Curso> cursos3 = [];
  List<Curso> cursos4 = [];

  Widget listaPrimero() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(_, cursos1[i]),
        itemCount: cursos1.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }
  Widget listaSegundo() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(_, cursos2[i]),
        itemCount: cursos2.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }
  Widget listaTercero() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(_, cursos3[i]),
        itemCount: cursos3.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }
  Widget listaCuarto() {
    return Container(
      height: 312,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        pageSnapping: false,
        itemBuilder: (_, i) => carruselHorizontal(_, cursos4[i]),
        itemCount: cursos4.length,
        controller: PageController(
          viewportFraction: 0.65 ), 
      ),
    );
  }

}