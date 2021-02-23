import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class Profesor extends StatefulWidget {
  @override
  _ProfesorState createState() => _ProfesorState();
}

class _ProfesorState extends State<Profesor> {

  final auth = AuthService();

  @override
    void initState() { 

      final usuario = Provider.of<AuthService>(context).usuario;
      this._cargarProfesor(usuario.profesor);
      super.initState();
    }

  @override
  Widget build(BuildContext context) {

    final usuario = Provider.of<AuthService>(context).usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profesor', style: TextStyle( fontSize: 22, letterSpacing: -0.7, fontWeight: FontWeight.w400 )),
        elevation: 0,
      ),
      body: Column( children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(usuario.profesor? 'Profesor' : 'Alumno'),
              FlutterSwitch(
                value: usuario.profesor,
                onToggle: (val) {
                  print('onTap');
                  _cargarProfesor(val);
                  // // val = usuario.profesor;
                  // await auth.profesor(context, val);
                  // setState(() {});
              }),
            ],
          ),
        )
      ])
    );
    
  }
  _cargarProfesor(bool b) async {
    final yo = Provider.of<AuthService>(context, listen: false).usuario;
    // this.usuarios = await usuarioService.getUsuarios();
    await auth.profesor(context, !b);
    setState(() {});
    // _refreshController.refreshCompleted();
  }
}