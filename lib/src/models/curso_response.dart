import 'dart:convert';
import 'curso_modelo.dart';

CursosResponse cursosFromJson(String str) => CursosResponse.fromJson(json.decode(str));

String cursosToJson(CursosResponse data) => json.encode(data.toJson());

class CursosResponse {
    CursosResponse({
        this.ok,
        this.cursos,
    });

    bool ok;
    List<Curso> cursos;

    factory CursosResponse.fromJson(Map<String, dynamic> json) => CursosResponse(
        ok: json["ok"],
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
    };
}