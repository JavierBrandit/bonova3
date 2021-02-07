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
    final yo = authService.usuario;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0.0,
        actions: [
          
          usuario != yo ?
          Padding(
            padding: const EdgeInsets.only(bottom:5, right: 10),
            child: IconButton(
              icon: SvgPicture.asset('assets/sendd.svg', height: 21, width: 21, color: isDarkTheme? Colors.tealAccent : Colors.teal[700],),
              onPressed: () {
                final chatService = Provider.of<ChatService>(context, listen: false);
                chatService.usuarioPara = usuario;
                Navigator.pushNamed(context, 'chat');
        },
            ),
          ) : Container()
        ],
      ),
      body: CustomScrollView(
        slivers: [
          
          SliverToBoxAdapter(
            child: Column(

          children: [
            
            SizedBox( height: 20 ),
            Hero(
              tag: 'foto',
              child: Center(child: GestureDetector( child: 
                CircleAvatar(backgroundImage: NetworkImage(usuario.foto), radius: 55 ),
                onTap: () => Navigator.pushNamed(context, 'foto', arguments: usuario),
              )),
            ),
            SizedBox( height: 13 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 40),
                Text( usuario.nombre, style: TextStyle( fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.8 ) ),
                this.usuario == yo
                ? IconButton(
                    icon: Icon( FluentIcons.edit_32_regular, size: 21),
                    onPressed: () => Navigator.pushNamed(context, 'formulario'),
                  )
                : IconButton(
                    icon: Icon( FluentIcons.person_add_24_regular, size: 25, color: Colors.tealAccent[700],),
                    onPressed: (){},
                  )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child:
                   usuario.profesor
                    ? Container(height: 19, width: 19, child: SvgPicture.asset('assets/manzana.svg', color: Colors.redAccent.withOpacity(.8)))
                    : 
                    Icon(FluentIcons.hat_graduation_24_regular, size: 19, color: Colors.teal)),

                Padding(
                  padding: const EdgeInsets.only(top:2),
                  child: Text(usuario.profesor? 'Profesor' :'Alumno' , style: TextStyle( fontSize: 16, letterSpacing: -.5, fontWeight: FontWeight.w500, color: usuario.profesor? Colors.redAccent.withOpacity(.8): Colors.teal[500])),
                ),
                SizedBox(width: 15)
              ],
            ),
            SizedBox( height: 20 ),

            yo.profesor || usuario != yo
            ? Container()
            : FlatButton(
              height: 34,
              padding: EdgeInsets.symmetric(horizontal: 13),
              onPressed: (){},
              child: Text('Cambiate a Profesor', style: TextStyle( fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: -.2)),
              color: Colors.teal,
              colorBrightness: Brightness.dark,
              shape: StadiumBorder(),
            ),
            

            SizedBox( height: 40 ),

            cajaBorde(isDarkTheme, [
              listTileInfo(usuario.colegio, FluentIcons.hat_graduation_16_regular, 'Estudios'),
              listTileInfo('5', FluentIcons.video_16_regular, 'Cursos en que enseña'),
              listTileInfo('Matemática · Física', FluentIcons.book_20_regular, 'Especialidad'),
              listTileInfo('5.0', FluentIcons.star_16_regular, 'Valoración promedio'),
              listTileInfo(usuario.comuna, FluentIcons.location_16_regular, 'Comuna')
            ]),
          ]),
        )
        ])
    );
  }

  cajaBorde(bool dark, List<Widget> children){
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal:20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
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
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [

          Padding(
            padding: EdgeInsets.only(right: 23),
            child: Icon(icon, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
              Text(descripcion, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),),
            ],
          )

      ]),
    );
  }



}