import 'package:bonova0002/src/services/auth_services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Formulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Editar Información', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  nombre('Foto perfil'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(backgroundImage: AssetImage('assets/placeBonova.jpg'), radius: 65),
                    ],
                  ),
                  nombre('Nombre'),
                  input(usuario.nombre, FluentIcons.text_font_16_regular, TextInputType.name),
                  nombre('Cumpleaños'),
                  input('', FluentIcons.food_cake_20_regular, TextInputType.datetime),
                  nombre('Curso'),
                  input('', FluentIcons.backpack_20_regular, TextInputType.number),
                  nombre('Colegio'),
                  input('', FluentIcons.hat_graduation_20_regular, TextInputType.name),

        ])))
    ]));
  }

  nombre(String nombre){
    return Padding(
      padding: EdgeInsets.only( top: 30, bottom: 12),
      child: Text(
        nombre,
        style: TextStyle( fontSize: 12, letterSpacing: -.3),
      ),
    );
  }

  input( String nombre, IconData icon, TextInputType keyboardType ){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
     padding: EdgeInsets.symmetric(horizontal: 10),
     decoration: BoxDecoration(
      //  color: Colors.white, 
       borderRadius: BorderRadius.circular(30),
       border: Border.all(width: .6, color: Colors.grey[600] )
     ),
     child: TextField(
       keyboardType: keyboardType,
       textAlignVertical: TextAlignVertical.center,
       decoration: InputDecoration(
         prefixIcon: Icon( icon, size: 18 ),
         contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
         focusedBorder: InputBorder.none,
         border: InputBorder.none,
         hintText: nombre,
         hintStyle: TextStyle( fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: -.2)
    )));
  }


}