import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/widgets/avatar_perfil.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:flutter/material.dart';

class CarruselProfesores extends StatelessWidget {
  final List<Usuario> usuarios;

  const CarruselProfesores({
    Key key,
    @required this.usuarios,
  }) : super (key: key);


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        HeaderTitulo(titulo: 'profesores', paginaDestino: '',),
        AvatarPerfil(imgUrl: 'https://marketing4ecommerce.net/wp-content/uploads/2018/01/Depositphotos_3667865_m-2015-compressor.jpg',),
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1 + usuarios.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 10.0,
                  width: 10.0,
                  color: Colors.red,
                );
            }
        ),





      ],
    );


  }




}
