import 'dart:convert';

import 'package:bonova0002/src/models/video_modelo.dart';

import 'usuario.dart';


List<Curso> cursoFromJson(String str) => List<Curso>.from(json.decode(str).map((x) => Curso.fromJson(x)));

String cursoToJson(List<Curso> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


Curso curso1FromJson(String str) => Curso.fromJson(json.decode(str));

// String cursosToJson(Curso data) => json.encode(data.toJson());
class Curso {
    Curso({
        this.videos,
        this.comentario,
        this.cid,
        this.guardado,
        this.titulo,
        this.ramo,
        this.nivel,
        this.portada,
        this.profesor,
        this.rate,
        this.descripcion,
        this.thumbnail,
        this.views,
        this.likes,
        this.compartido,
        this.precio,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<Video> videos;
    List<dynamic> comentario;
    String cid;
    bool guardado;
    String titulo;
    String ramo;
    String nivel;
    String portada;
    Usuario profesor;
    double rate;
    String descripcion;
    String thumbnail;
    int views;
    int likes;
    int compartido;
    String precio;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        comentario: List<dynamic>.from(json["comentario"].map((x) => x)),
        cid: json["_id"],
        guardado: json["guardado"],
        titulo: json["titulo"],
        ramo: json["ramo"],
        nivel: json["nivel"],
        portada: json["portada"],
        profesor: Usuario.fromJson(json["profesor"]),
        rate: json["rate"].toDouble(),
        descripcion: json["descripcion"],
        thumbnail: json["thumbnail"],
        views: json["views"],
        likes: json["likes"],
        compartido: json["compartido"],
        precio: json["precio"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "comentario": List<dynamic>.from(comentario.map((x) => x)),
        "_id": cid,
        "guardado": guardado,
        "titulo": titulo,
        "ramo": ramo,
        "nivel": nivel,
        "portada": portada,
        "profesor": profesor.toJson(),
        "rate": rate,
        "descripcion": descripcion,
        "thumbnail": thumbnail,
        "views": views,
        "likes": likes,
        "compartido": compartido,
        "precio": precio,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}

// class Curso {
//     Curso({
//         this.guardado,
//         this.videos,
//         this.comentario,
//         this.titulo,
//         this.ramo,
//         this.nivel,
//         this.portada,
//         this.profesor,
//         this.rate,
//         this.descripcion,
//         this.thumbnail,
//         this.views,
//         this.likes,
//         this.compartido,
//         this.precio,
//         this.createdAt,
//         this.updatedAt,
//         this.cid,
//     });

//     bool guardado;
//     List<Video> videos;
//     List<dynamic> comentario;
//     String titulo;
//     String ramo;
//     String nivel;
//     String portada;
//     Usuario profesor;
//     int rate;
//     String descripcion;
//     String thumbnail;
//     int views;
//     int likes;
//     int compartido;
//     String precio;
//     DateTime createdAt;
//     DateTime updatedAt;
//     String cid;

//     factory Curso.fromJson(Map<String, dynamic> json) => Curso(
//         guardado: json["guardado"],
//         videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
//         comentario: List<dynamic>.from(json["comentario"].map((x) => x)),
//         titulo: json["titulo"],
//         ramo: json["ramo"],
//         nivel: json["nivel"],
//         portada: json["portada"],
//         profesor: Usuario.fromJson(json["profesor"]),
//         rate: json["rate"],
//         descripcion: json["descripcion"],
//         thumbnail: json["thumbnail"],
//         views: json["views"],
//         likes: json["likes"],
//         compartido: json["compartido"],
//         precio: json["precio"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         cid: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "guardado": guardado,
//         "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
//         "comentario": List<dynamic>.from(comentario.map((x) => x)),
//         "titulo": titulo,
//         "ramo": ramo,
//         "nivel": nivel,
//         "portada": portada,
//         "profesor": profesor.toJson(),
//         "rate": rate,
//         "descripcion": descripcion,
//         "thumbnail": thumbnail,
//         "views": views,
//         "likes": likes,
//         "compartido": compartido,
//         "precio": precio,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "_id": cid,
//     };
// }


