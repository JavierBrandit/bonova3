// // To parse this JSON data, do
// //
// //     final historials = historialsFromJson(jsonString);
// import 'dart:convert';

// import 'curso_modelo.dart';


// Historiales historialesFromJson(String str) => Historiales.fromJson(json.decode(str));

// String historialesToJson(Historiales data) => json.encode(data.toJson());

// class Historiales {
//     Historiales({
//         this.historial,
//     });

//     List<Historial> historial;

//     factory Historiales.fromJson(Map<String, dynamic> json) => Historiales(
//         historial: List<Historial>.from(json["historial"].map((x) => Historial.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "historial": List<dynamic>.from(historial.map((x) => x.toJson())),
//     };
// }


// Historials historialsFromJson(String str) => Historials.fromJson(json.decode(str));

// String historialsToJson(Historials data) => json.encode(data.toJson());

// class Historials {
//     Historials({
//         this.historial,
//     });

//     Historial historial;

//     factory Historials.fromJson(Map<String, dynamic> json) => Historials(
//         historial: Historial.fromJson(json["historial"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "historial": historial.toJson(),
//     };
// }

// class Historial {
//     Historial({
//         this.prefs,
//         this.curso,
//         this.usuario,
//         this.progreso,
//         this.createdAt,
//         this.updatedAt,
//         this.guardado,
//         this.largo,
//         this.index,
//     });

//     List<dynamic> prefs;
//     Curso curso;
//     String usuario;
//     double progreso;
//     DateTime createdAt;
//     DateTime updatedAt;
//     bool guardado;
//     int largo;
//     int index;

//     factory Historial.fromJson(Map<String, dynamic> json) => Historial(
//         prefs: List<dynamic>.from(json["prefs"].map((x) => x)),
//         curso: Curso.afromJson(json["curso"]),
//         usuario: json["usuario"],
//         progreso: json["progreso"].toDouble(),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         guardado: json["guardado"],
//         largo: json["largo"],
//         index: json["index"],
//     );

//     Map<String, dynamic> toJson() => {
//         "prefs": List<dynamic>.from(prefs.map((x) => x)),
//         "curso": curso.toJson(),
//         "usuario": usuario,
//         "progreso": progreso,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "guardado": guardado,
//         "largo": largo,
//         "index": index,
//     };
// }

import 'dart:convert';

import 'curso_modelo.dart';

Historiales historialesFromJson(String str) => Historiales.fromJson(json.decode(str));

String historialesToJson(Historiales data) => json.encode(data.toJson());

class Historiales {
    Historiales({
        this.historial,
    });

    List<Historial> historial;

    factory Historiales.fromJson(Map<String, dynamic> json) => Historiales(
        historial: List<Historial>.from(json["historial"].map((x) => Historial.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "historial": List<dynamic>.from(historial.map((x) => x.toJson())),
    };
}

class Historial {
    Historial({
        this.prefs,
        this.curso,
        this.usuario,
        this.createdAt,
        this.updatedAt,
        this.progreso,
        this.guardado,
        this.largo,
        this.index,
    });

    List<dynamic> prefs;
    Curso curso;
    String usuario;
    DateTime createdAt;
    DateTime updatedAt;
    bool guardado;
    double progreso;
    int largo;
    int index;

    factory Historial.fromJson(Map<String, dynamic> json) => Historial(
        prefs: List<dynamic>.from(json["prefs"].map((x) => x)),
        curso: Curso.fromJson(json["curso"]),
        usuario: json["usuario"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        progreso: json["progreso"],
        guardado: json["guardado"],
        largo: json["largo"],
        index: json["index"],
    );

    Map<String, dynamic> toJson() => {
        "prefs": List<dynamic>.from(prefs.map((x) => x)),
        "curso": curso.toJson(),
        "usuario": usuario,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "progreso": progreso,
        "guardado": guardado,
        "largo": largo,
        "index": index,
    };
}