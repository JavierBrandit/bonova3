import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/google_signin_service.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/widgets/header_titulo.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
class Configuracion extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    // final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric( horizontal: 27 ),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              titulo('cuenta'),
              Divider(height: 10),
                item('Tipo de cuenta', FluentIcons.person_24_regular, 'profesor',context),
                item('Estado de conexión', FluentIcons.communication_24_regular, '',context),
                item('Puntos bonova', FluentIcons.ticket_diagonal_24_regular,'puntos',context),

              titulo('seguridad'),
              Divider(height: 10),
                item('Contraseña', FluentIcons.lock_closed_24_regular,'password',context),
                item('Información', FluentIcons.info_24_regular, '',context),
                item('Notificaciones', FluentIcons.alert_24_regular, '',context),
                item('Recordatorios de aprendizaje', FluentIcons.clock_24_regular, '',context ),

              titulo('soporte'),
              Divider(height: 10),

                item('Sobre bonova', FluentIcons.more_horizontal_24_regular, 'about',context),
                item('Preguntas frecuentes', FluentIcons.question_circle_24_regular, 'preguntas',context),
                item('Calificar', FluentIcons.star_24_regular, '',context),
                item('Recomendar bonova a un amigo', FluentIcons.gift_24_regular, '',context),

              SizedBox(height: 20),
              Divider(height: 10),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Text('Cerrar sesión', style:TextStyle( color:Colors.teal[300], fontWeight: FontWeight.w500 )),
                    onTap: (){
                      GoogleSignInService.signOut();
                      socketService.disconnect();
                      Navigator.pushReplacementNamed(context, 'login');
                      AuthService.deleteToken();
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('bonova v1.0.0',
                    style: TextStyle( fontSize: 10 ),
                  ),
                ],
              )
        ]))),
      ])   
    );
  }

  titulo(String t){
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 7),
      child: Text(
        t,
        style: TextStyle( fontSize: 15.5, fontWeight: FontWeight.w500, letterSpacing: -.4 ),
      ),
    );
  }

  item(String nombre, IconData icon, String ruta, BuildContext context){
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ruta),
      child: Container(
        child: Row(
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 14),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text( nombre,
                style: TextStyle( fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: -.3),
                ),
            ),
          ],
        ),
      ),
    );
  }


}