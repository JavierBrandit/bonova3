import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/chat_service.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
 
class PerfilPage extends StatelessWidget {

  Usuario usuario;
 
  @override
  Widget build(BuildContext context) {

    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final authService = Provider.of<AuthService>(context);
    usuario = ModalRoute.of(context).settings.arguments;
    // final usuario = authService.usuario;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom:5, right: 10),
            child: IconButton(
              icon: SvgPicture.asset('assets/send.svg', height: 20.0, width: 20.0, color: isDarkTheme? Colors.tealAccent : Colors.teal[600],),
              //color:  Colors.teal,
              onPressed: () {
                final chatService = Provider.of<ChatService>(context, listen: false);
                chatService.usuarioPara = usuario;
                Navigator.pushNamed(context, 'chat');
        },
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          
          SliverToBoxAdapter(
            child: Column(

          children: [
            
            SizedBox( height: 20 ),
            Center(child: CircleAvatar(backgroundImage: AssetImage('assets/placeBonova.jpg'), radius: 55 )),
            SizedBox( height: 13 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 50),
                Text( usuario.nombre, style: TextStyle( fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.8 ) ),
                IconButton(
                  icon: Icon( FluentIcons.edit_24_filled, size: 16,),
                  onPressed: () => Navigator.pushNamed(context, 'formulario'),
                ),
              ],
            ),
            Text('Profesor', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w700, color: Colors.teal[300])),
            SizedBox( height: 10 ),

            FlatButton(
              onPressed: (){},
              child: Text('Cambiate a Profesor', style: TextStyle( fontSize: 13, fontWeight: FontWeight.w700),),
              color: Colors.tealAccent[400],
              colorBrightness: Brightness.dark,
              shape: StadiumBorder(),
            ),
            SizedBox( height: 10 ),

            cajaBorde(isDarkTheme, [
              listTileInfo('Universidad de Santiago', FluentIcons.hat_graduation_16_regular, 'Estudios'),
              listTileInfo('5', FluentIcons.video_16_regular, 'Cursos en que enseña'),
              listTileInfo('Matemática · Física', FluentIcons.book_20_regular, 'Especialidad'),
              listTileInfo('5.0', FluentIcons.star_16_regular, 'Valoración promedio'),
              listTileInfo('Padre Hurtado', FluentIcons.location_16_regular, 'Comuna')
            ]),
            cajaBorde(isDarkTheme, [
              listTileInfo('Universidad de Santiago', FluentIcons.hat_graduation_16_regular, 'Estudios'),
              listTileInfo('5', FluentIcons.video_16_regular, 'Cursos en que enseña'),
              listTileInfo('Matemática · Física', FluentIcons.book_20_regular, 'Especialidad'),
              listTileInfo('5.0', FluentIcons.star_16_regular, 'Valoración promedio'),
              listTileInfo('Padre Hurtado', FluentIcons.location_16_regular, 'Comuna')
            ]),
            cajaBorde(isDarkTheme, [
              listTileInfo('Universidad de Santiago', FluentIcons.hat_graduation_16_regular, 'Estudios'),
              listTileInfo('5', FluentIcons.video_16_regular, 'Cursos en que enseña'),
              listTileInfo('Matemática · Física', FluentIcons.book_20_regular, 'Especialidad'),
              listTileInfo('5.0', FluentIcons.star_16_regular, 'Valoración promedio'),
              listTileInfo('Padre Hurtado', FluentIcons.location_16_regular, 'Comuna')
            ]),

             
          ]),
        )
        ])
    );
  }

  cajaBorde(bool dark, List<Widget> children){
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: dark? Colors.white24 : Colors.grey[300] )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children
          ),
      ),
    );
  }

  listTileInfo(String titulo, IconData icon, String descripcion){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          Padding(
            padding: EdgeInsets.only(right: 23),
            child: Icon(icon, size: 17),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: TextStyle(fontWeight: FontWeight.w500),),
              Text(descripcion, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
            ],
          )

      ]),
    );
  }



}