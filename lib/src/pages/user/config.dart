import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/socket_service.dart';
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
              titulo('Cuenta'),
                item('Tipo de cuenta', FluentIcons.person_16_regular,(){}),
                item('Estado de conexión', FluentIcons.connector_20_regular, (){}),
                item('Puntos bonova', FluentIcons.ticket_diagonal_20_regular,(){}),

              titulo('Seguridad'),
                item('Contraseña', FluentIcons.lock_closed_16_regular,(){}),
                item('Información', FluentIcons.info_16_regular,(){}),
                item('Notificaciones', FluentIcons.alert_16_regular,(){}),
                item('Recordatorios de aprendizaje', FluentIcons.clock_16_regular, (){} ),

              titulo('Soporte'),
                item('Sobre bonova', FluentIcons.more_horizontal_16_regular,(){}),
                item('Preguntas frecuentes', FluentIcons.question_circle_16_regular,(){}),
                item('Calificar', FluentIcons.star_16_regular,(){}),
                item('Recomendar bonova a un amigo', FluentIcons.gift_20_regular,(){}),

                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text('Cerrar Sesión', style:TextStyle( color:Colors.teal[300], fontWeight: FontWeight.w500 )),
                      onTap: (){
                        socketService.disconnect();
                        Navigator.pushReplacementNamed(context, 'login');
                        AuthService.deleteToken();
                      },
                    ),
                  ],
                ),
        ]))),
      ])   
    );
  }

  titulo(String t){
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 7),
      child: Text(
        t,
        style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500 ),
      ),
    );
  }

  item(String nombre, IconData icon, Function onTap){
    return Row(
      children: [
        Icon(icon, size: 21),
        SizedBox(width: 7),
        Padding(
          padding: EdgeInsets.all(11),
          child: Text( nombre,
            style: TextStyle( fontWeight: FontWeight.w500, fontSize: 16),
            ),
        ),
      ],
    );
  }


}