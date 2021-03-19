import 'package:bonova0002/src/global/environment.dart';
import 'package:bonova0002/src/models/usuario.dart';

import 'package:http/http.dart' as http;

import 'auth_services.dart';


class UsuarioService {

  Future<List<Usuario>> getUsuarios() async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/usuarios',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final usuariosResponse = usuariosFromJson( resp.body );
      return usuariosResponse.usuarios;
    
    } catch (e) {
      return [];
    }
   
  }

}
