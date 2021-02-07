// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.online,
        this.profesor,
        this.cursos,
        this.contactos,
        this.recordatorio,
        this.nombre,
        this.email,
        this.antiguedad,
        this.comuna,
        this.colegio,
        this.curso,
        this.foto,
        this.descripcion,
        this.uid,
        this.celular,
    });

    bool online;
    bool profesor;
    List<dynamic> cursos;
    List<dynamic> contactos;
    bool recordatorio;
    String nombre;
    String email;
    DateTime antiguedad;
    String comuna;
    String colegio;
    String curso;
    String foto;
    String descripcion;
    String uid;
    String celular;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        profesor: json["profesor"],
        cursos: List<dynamic>.from(json["cursos"].map((x) => x)),
        contactos: List<dynamic>.from(json["contactos"].map((x) => x)),
        recordatorio: json["recordatorio"],
        nombre: json["nombre"],
        email: json["email"],
        antiguedad: DateTime.parse(json["antiguedad"]),
        comuna: json["comuna"],
        colegio: json["colegio"],
        curso: json["curso"],
        foto: json["foto"],
        descripcion: json["descripcion"],
        uid: json["uid"],
        celular: json["celular"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "profesor": profesor,
        "cursos": List<dynamic>.from(cursos.map((x) => x)),
        "contactos": List<dynamic>.from(contactos.map((x) => x)),
        "recordatorio": recordatorio,
        "nombre": nombre,
        "email": email,
        "antiguedad": antiguedad.toIso8601String(),
        "comuna": comuna,
        "colegio": colegio,
        "curso": curso,
        "foto": foto,
        "descripcion": descripcion,
        "uid": uid,
        "celular": celular,
    };
}