// To parse this JSON data, do
//
//     final usuarios = usuariosFromJson(jsonString);

import 'dart:convert';

Usuarios usuariosFromJson(String str) => Usuarios.fromJson(json.decode(str));

String usuariosToJson(Usuarios data) => json.encode(data.toJson());

class Usuarios {
    Usuarios({
        this.ok,
        this.usuarios,
    });

    bool ok;
    List<Usuario> usuarios;

    factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
    };
}

class Usuario {
    Usuario({
        this.online,
        this.profesor,
        this.cursos,
        this.contactos,
        this.historial,
        this.guardados,
        this.recordatorio,
        this.nombre,
        this.email,
        this.antiguedad,
        this.comuna,
        this.colegio,
        this.curso,
        this.foto,
        this.descripcion,
        this.celular,
        this.uid,
    });

    bool online;
    bool profesor;
    List<dynamic> cursos;
    List<dynamic> contactos;
    List<dynamic> historial;
    List<dynamic> guardados;
    bool recordatorio;
    String nombre;
    String email;
    DateTime antiguedad;
    String comuna;
    String colegio;
    String curso;
    String foto;
    String descripcion;
    String celular;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        profesor: json["profesor"],
        cursos: List<dynamic>.from(json["cursos"].map((x) => x)),
        contactos: List<dynamic>.from(json["contactos"].map((x) => x)),
        historial: List<dynamic>.from(json["historial"].map((x) => x)),
        guardados: List<dynamic>.from(json["guardados"].map((x) => x)),
        recordatorio: json["recordatorio"],
        nombre: json["nombre"],
        email: json["email"],
        antiguedad: json["antiguedad"] == null ? null : DateTime.parse(json["antiguedad"]),
        comuna: json["comuna"] == null ? null : json["comuna"],
        colegio: json["colegio"] == null ? null : json["colegio"],
        curso: json["curso"] == null ? null : json["curso"],
        foto: json["foto"] == null ? null : json["foto"],
        descripcion: json["descripcion"] == null ? null : json["descripcion"],
        celular: json["celular"] == null ? null : json["celular"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "profesor": profesor,
        "cursos": List<dynamic>.from(cursos.map((x) => x)),
        "contactos": List<dynamic>.from(contactos.map((x) => x)),
        "historial": List<dynamic>.from(historial.map((x) => x)),
        "guardados": List<dynamic>.from(guardados.map((x) => x)),
        "recordatorio": recordatorio,
        "nombre": nombre,
        "email": email,
        "antiguedad": antiguedad == null ? null : antiguedad.toIso8601String(),
        "comuna": comuna == null ? null : comuna,
        "colegio": colegio == null ? null : colegio,
        "curso": curso == null ? null : curso,
        "foto": foto == null ? null : foto,
        "descripcion": descripcion == null ? null : descripcion,
        "celular": celular == null ? null : celular,
        "uid": uid,
    };
}
