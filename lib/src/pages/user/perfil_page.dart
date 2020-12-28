import 'package:bonova0002/src/services/auth_services.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
 
class PerfilPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    
    return Scaffold(
      //backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(''),
      //  backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(

        children: [
          
          SizedBox( height: 40 ),
          Center(child: CircleAvatar(backgroundImage: AssetImage('assets/placeBonova.jpg'), radius: 55 )),
          SizedBox( height: 20 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 50),
              Text( usuario.nombre, style: TextStyle( fontSize: 28, fontWeight: FontWeight.w400, color: Colors.grey[700], letterSpacing: 0.8 ) ),
              IconButton(
                icon: Icon( FluentSystemIcons.ic_fluent_edit_filled, size: 16, color: Colors.grey[700],),
                onPressed: (){},
              ),
            ],
          ),
          Text('Alumno', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w700, color: Colors.teal[300])),
          SizedBox( height: 18 ),

          FlatButton(
            onPressed: (){},
            child: Text('Cambiate a Profesor', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w700),),
            color: Colors.tealAccent[400],
            colorBrightness: Brightness.dark,
            shape: StadiumBorder(),
          ),
          SizedBox( height: 30 ),
          
          Container(
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.all(23),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text('Colegio', style: TextStyle( fontSize: 15, fontWeight: FontWeight.w500)),
                  SizedBox( height: 6 ),
                  Text('Colegio Patricio Mekis'
                  , style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300)),

                  SizedBox( height: 18 ),
                  Text('Curso', style: TextStyle( fontSize: 15, fontWeight: FontWeight.w500)),
                  SizedBox( height: 6 ),
                  Text('3ro'
                  , style: TextStyle( fontSize: 12, fontWeight: FontWeight.w300)),
              ]),
            ),
          ),

         
          
        ],
      ),  
      
    );
  }
}