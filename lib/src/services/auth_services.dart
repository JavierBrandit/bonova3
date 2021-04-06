import 'dart:io';

import 'package:bonova0002/src/global/environment.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/historial.dart';
import 'package:bonova0002/src/models/login_response.dart';
import 'package:bonova0002/src/models/usuario.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';


class AuthService with ChangeNotifier{

  Usuario usuario;
  bool _autenticando = false;
  bool guardado;

  Usuario getUsuario() => usuario;
  
  Usuario setUsuario( Usuario u ) {
    this.usuario = u;
    notifyListeners();
  }
  
  bool getGg() => guardado;
  
  // bool setGuardado( bool b, Curso curso) {
  //   curso.guardado = b;
  // }
  
  // bool getGuardado( Usuario u, Curso c ) {
  //   this.usuario = u;
  //   if (usuario.guardados.contains(c.cid)){
  //     guardado = true;
  //     notifyListeners();
  //     return guardado;
  //   }
  //     guardado = false;
  //     notifyListeners();
  //     return guardado;
  // }

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando; //GETTER
  set autenticando( bool valor ) {
    this._autenticando = valor;
    notifyListeners(); //Todo esto para notificar
  } //SETTER

  // Getter token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.read(key: 'token');
  }

  Future<bool> login( String email, String password) async {
    this._autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${ Environment.apiUrl }/login',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    this.autenticando = false;
     
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      return false;
    }
  }

  Future<List<Historial>> verHistorial() async {
    this._autenticando = true;
    final token = await this._storage.read(key: 'token');

    final resp = await http.get('${ Environment.apiUrl }/usuarios/historial',
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    this.autenticando = false;
     
    if ( resp.statusCode == 200 ) {
      final loginResponse = historialesFromJson(resp.body).historial;

      return loginResponse;
    } else {
      return [];
    }
  }

  Future register( String nombre, String email, String password ) async {
    this._autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
      'antiguedad': DateTime.now().toIso8601String(),
      'comuna': '',
      'colegio': '',
      'curso': '',
      'foto': '',
      'descripcion': '',
      'celular':''
    };

    final resp = await http.post('${ Environment.apiUrl }/login/new',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }

    );

    this.autenticando = false;
     
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  } 

  Future<bool> isLoggedIn() async {
    // No volver a mostrar login si hay autenticacion (token)
    final token = await this._storage.read(key: 'token');
    
    final resp = await http.get('${ Environment.apiUrl }/login/renew',
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
     
    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future editarProfesor( BuildContext context, bool profesor ) async {

    final auth = Provider.of<AuthService>(context, listen: false); 
    final id = auth.usuario.uid;
    final token = await this._storage.read(key: 'token');

    final data = {
      'profesor' : profesor
    };

    final resp = await http.put('${ Environment.apiUrl }/usuarios/$id',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200 ) {
        final editResponse = editResponseFromJson(resp.body);
        this.setUsuario(editResponse.usuario);
        this.usuario = editResponse.usuario;      
      return true;
    } else {
        final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  

  Future editarNombre( BuildContext context, String nombre ) async {
    this._autenticando = true;

    final auth = Provider.of<AuthService>(context, listen: false); 
    final id = auth.usuario.uid;
    final token = await this._storage.read(key: 'token');

    final data = {
      'nombre' : nombre
    };

    final resp = await http.put('${ Environment.apiUrl }/usuarios/$id',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    this._autenticando = false;

    if ( resp.statusCode == 200 ) {
      final editResponse = editResponseFromJson(resp.body);
      this.setUsuario(editResponse.usuario);
      this.usuario = editResponse.usuario;      
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  // Stream agregarGuardado2(BuildContext context, Curso curso ) async* {

  //   final token = await this._storage.read(key: 'token');

  //   final body = {
  //     'curso': curso.,
  //     'progreso'

  //   }

  //   final resp = await http.put('${ Environment.apiUrl }/usuarios/miscursos/${ curso.cid }',
  //     // body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'x-token': token
  //     }
  //   );

  //   // if ( resp.statusCode == 200 ) {
  //   //   final editResponse = historialResponseFromJson(resp.body); //jsonDecode(resp.body);
  //   //   // print(editResponse);
  //   //   return true;
  //   // } else {
  //   //   final respBody = jsonDecode(resp.body);
  //   //   return respBody['msg'];
  //   }
  // }
  Future<bool> agregarGuardado(BuildContext context, Curso curso ) async {

    final token = await this._storage.read(key: 'token');
    usuario = Provider.of<AuthService>(context, listen: false).usuario;

    final resp = await http.put('${ Environment.apiUrl }/usuarios/miscursos/${ curso.cid }',
      // body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200 ) {
      final editResponse = cursoFromJson(resp.body); //jsonDecode(resp.body);
      // print(editResponse);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> borrarGuardado(BuildContext context, Curso curso ) async {

    final token = await this._storage.read(key: 'token');
    usuario = Provider.of<AuthService>(context, listen: false).usuario;

    final resp = await http.delete('${ Environment.apiUrl }/usuarios/miscursos/${ curso.cid }',
      // body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200 ) {
      final editResponse = cursoFromJson(resp.body); //jsonDecode(resp.body);
      // print(editResponse);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  

  // Future<List<Historial>> verGuardados() async {

  //   final token = await this._storage.read(key: 'token');

  
  //   final resp = await http.get('${ Environment.apiUrl }/usuarios/historial',
  //     // body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'x-token': token
  //     }
  //   );

  //   if ( resp.statusCode == 200 ) {
  //     final editResponse = historialsFromJson(resp.body).historial; //jsonDecode(resp.body);
  //     // print(editResponse);  
  //     return editResponse;
  //   } else {
  //     final respBody = jsonDecode(resp.body);
  //     return respBody['msg'];
  //   }
  // }

  Future agregarHistorial(Historial historial) async {

    final token = await this._storage.read(key: 'token');

    final data = {
      'curso': historial.curso,
      'guardado': historial.guardado,
      'largo': historial.curso.videos.length,
      'progeso': historial.progreso,
      'prefs': historial.prefs
    };
  
    final resp = await http.put('${ Environment.apiUrl }/usuarios/historial/${ historial.curso }',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200 ) {
      final editResponse = historialesFromJson(resp.body).historial; //jsonDecode(resp.body);
      // print(editResponse);  
      return print(editResponse);
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future editarColegio( BuildContext context, String colegio ) async {

    final auth = Provider.of<AuthService>(context, listen: false); 
    final id = auth.usuario.uid;
    final token = await this._storage.read(key: 'token');

    final data = {
      'colegio' : colegio
    };

    final resp = await http.put('${ Environment.apiUrl }/usuarios/$id',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    this._autenticando = false;

    if ( resp.statusCode == 200 ) {
      final editResponse = loginResponseFromJson(resp.body);
      this.usuario = editResponse.usuario;      
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future editarCurso( BuildContext context, String curso ) async {

    final auth = Provider.of<AuthService>(context, listen: false); 
    final id = auth.usuario.uid;
    final token = await this._storage.read(key: 'token');

    final data = {
      'curso' : curso
    };

    final resp = await http.put('${ Environment.apiUrl }/usuarios/$id',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    this._autenticando = false;

    if ( resp.statusCode == 200 ) {
      final editResponse = loginResponseFromJson(resp.body);
      this.usuario = editResponse.usuario;      
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }
  
  Future editarFoto( BuildContext context, File imagen ) async {

    //                           SUBIR IMAGEN

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dmgwmydtk/image/upload?upload_preset=ddrwai3n');
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

      if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
        print('Algo salio mal');
        print( resp.body );
        return null;
      }

    final respData = json.decode(resp.body);
    final String urlImagen = respData['secure_url'];
      print( respData);
      print( urlImagen);
    // ___________________________________________________
    //                           ACTUALIZAR BASE DE DATOS
    this._autenticando = true;

    final auth = Provider.of<AuthService>(context, listen: false); 
    final id = auth.usuario.uid;
    final token = await this._storage.read(key: 'token');

    final data = {
      'foto' : urlImagen
    };

    final respBD = await http.put('${ Environment.apiUrl }/usuarios/$id',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    this._autenticando = false;

    if ( respBD.statusCode == 200 ) {
      final editResponse = editResponseFromJson(respBD.body);
      this.setUsuario(editResponse.usuario);
      this.usuario = editResponse.usuario;      
      return true;
    } else {
      final respBody = jsonDecode(respBD.body);
      return respBody['msg'];
    }

  }


  Future editarInfo( BuildContext context, String nombre, String email, String password,
                     String comuna, String colegio, String curso,
                     String foto, String descripcion, String celular,
   ) async {

    final auth = Provider.of<AuthService>(context);
    final id = auth.usuario.uid;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
      'antiguedad': DateTime.now().toIso8601String(),
      'comuna': comuna,
      'colegio': colegio,
      'curso': curso,
      'foto': foto,
      'descripcion': descripcion,
      'celular': celular
    };

    final resp = await http.put('${ Environment.apiUrl }/usuarios/$id',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
  }

  Future _guardarToken( String token ) async {
    return await _storage.write( key: 'token', value: token );
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }



}
