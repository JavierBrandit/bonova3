import 'package:flutter/material.dart';
import 'package:bonova0002/src/global/environment.dart';
import 'package:bonova0002/src/models/curso_modelo.dart';
import 'package:bonova0002/src/models/curso_response.dart';
import 'package:bonova0002/src/models/video_modelo.dart';
import 'package:bonova0002/src/models/video_response.dart';

import 'package:http/http.dart' as http;

import 'auth_services.dart';


class VideoService with ChangeNotifier {

  Curso _curso;
  Video _video;
  int _indexVideo = 0; 
  // bool _guardado = false; 

  int getIndex() => _indexVideo;
  
  int setIndex( int i ) {
    this._indexVideo = i;
    notifyListeners();
  }
  
  Video getVideo() => _video;
  
  Video setVideo( Video v ) {
    this._video = v;
    notifyListeners();
  }



  Curso getCurso() => _curso;
  
  Video setCurso( Curso c ) {
    this._curso = c;
    notifyListeners();
  }


  Future<List<Video>> getVideos() async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/video',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final videosResponse = videoResponseFromJson( resp.body );
      return videosResponse.videos;
    
    } catch (e) {
      return [];
    }
   
  }

}

class CursoService with ChangeNotifier {

  String ramo = '';
  String nivel = '';

  

  
  Future<List<Curso>> searchCursos( String query ) async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/usuarios/search?t=$query',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final cursosResponse = cursosFromJson( resp.body );
      return cursosResponse.cursos;
    
    } catch (e) {
      print(e);
      return [];
    }
   
  }

  Future<List<Curso>> getCursos( String ramox, String nivelx ) async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/curso/$ramox/$nivelx',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final cursosResponse = cursosFromJson( resp.body );
      return cursosResponse.cursos;
    
    } catch (e) {
      print(e);
      return [];
    }
   
  }

  Future<List<Curso>> getAllCursos() async {
    
    try {

      final resp = await http.get('${ Environment.apiUrl }/curso',
        headers: {
          'Content-Type': 'application/json',
          'x-token' : await AuthService.getToken()
        }
      );

      final cursosResponse = cursosFromJson( resp.body );
      return cursosResponse.cursos;
    
    } catch (e) {
      print(e);
      return [];
    }
   
  }

}