// To parse this JSON data, do
//
//     final historialResponse = historialResponseFromJson(jsonString);

import 'dart:convert';

import 'package:bonova0002/src/models/curso_modelo.dart';

HistorialResponse historialResponseFromJson(String str) => HistorialResponse.fromJson(json.decode(str));

String historialResponseToJson(HistorialResponse data) => json.encode(data.toJson());

class HistorialResponse {
    HistorialResponse({
        this.ok,
        this.historial,
    });

    bool ok;
    List<Historial> historial;

    factory HistorialResponse.fromJson(Map<String, dynamic> json) => HistorialResponse(
        ok: json["ok"],
        historial: List<Historial>.from(json["historial"].map((x) => Historial.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "historial": List<dynamic>.from(historial.map((x) => x.toJson())),
    };
}

class Historial {
    Historial({
        this.curso,
        this.usuario,
        this.progreso,
        this.createdAt,
        this.updatedAt,
    });

    String curso;
    String usuario;
    double progreso;
    DateTime createdAt;
    DateTime updatedAt;

    factory Historial.fromJson(Map<String, dynamic> json) => Historial(
        curso: json["curso"],
        usuario: json["usuario"],
        progreso: json["progreso"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "curso": curso,
        "usuario": usuario,
        "progreso": progreso,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
