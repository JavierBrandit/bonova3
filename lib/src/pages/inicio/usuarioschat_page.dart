import 'package:bonova0002/src/models/usuario.dart';
import 'package:bonova0002/src/services/auth_services.dart';
import 'package:bonova0002/src/services/chat_service.dart';
import 'package:bonova0002/src/services/socket_service.dart';
import 'package:bonova0002/src/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class UsuariosChatPage extends StatefulWidget {
  @override
  _UsuariosChatPageState createState() => _UsuariosChatPageState();
}

class _UsuariosChatPageState extends State<UsuariosChatPage> {
  
    final usuarioService = new UsuarioService();    
    final RefreshController _refreshController = RefreshController(initialRefresh: false);
    List<Usuario> usuarios = [];

    @override
    void initState() { 
      this._cargarUsuarios();
      super.initState();
    }
    
  @override
  Widget build(BuildContext context) {

    //final chatService = Provider.of<ChatService>(context);   
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversaciones', style: TextStyle( fontSize: 23, letterSpacing: -1, fontWeight: FontWeight.w400 )),
        elevation: 0,
        toolbarHeight: 70,
        // PASAR A SETTINGS/CERRAR SESION
        // leading: IconButton(
        //   icon: Icon(Icons.exit_to_app, color: Colors.black54,),
        //   onPressed: () {
        //     socketService.disconnect();
        //     Navigator.pushReplacementNamed(context, 'login');
        //     AuthService.deleteToken();
        //   },  
        // ),
        actions: <Widget>[
          _itemUsuario(usuario)
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400] ),
          waterDropColor: Colors.tealAccent[100],
        ),
        child: _listViewUsuarios(), 
      )
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuarioService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      separatorBuilder: (_, i) => Divider(indent: 80, color: Colors.grey.withOpacity(0.15),), 
      itemCount: usuarios.length
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
        
        title: Text( usuario.nombre, style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400 ),),
        subtitle: Text( usuario.email, style: TextStyle( fontSize: 12, fontWeight: FontWeight.w400 )),
        leading: _itemUsuario(usuario),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online? Colors.tealAccent[400] : Colors.red[200],
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);
          chatService.usuarioPara = usuario;
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _itemUsuario( Usuario u ) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.pushNamed( context, 'perfil', arguments: u ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // SizedBox(height: 8),
            CircleAvatar(
              radius: 25,
              backgroundColor: isDarkTheme ? Colors.teal[800] : Colors.tealAccent[100],
              child: Text( u.nombre.substring(0,2), style: TextStyle( color: isDarkTheme ? Colors.white : Colors.teal[900] ))
            ),
            // SizedBox(height: 8),

          ],
        ),
      ),
    );
  }




}
