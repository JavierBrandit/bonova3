import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.online,
        this.profesor,
        this.cursos,
        this.contactos,
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
        this.historial,
        this.uid,
    });

    bool online;
    bool profesor;
    List<dynamic> cursos;
    List<dynamic> contactos;
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
    List<dynamic> historial;
    String uid;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        profesor: json["profesor"],
        cursos: List<dynamic>.from(json["cursos"].map((x) => x)),
        contactos: List<dynamic>.from(json["contactos"].map((x) => x)),
        guardados: List<dynamic>.from(json["guardados"].map((x) => x)),
        recordatorio: json["recordatorio"],
        nombre: json["nombre"],
        email: json["email"],
        antiguedad: DateTime.parse(json["antiguedad"]),
        comuna: json["comuna"],
        colegio: json["colegio"],
        curso: json["curso"],
        foto: json["foto"],
        descripcion: json["descripcion"],
        celular: json["celular"],
        historial: List<dynamic>.from(json["historial"].map((x) => x)),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "profesor": profesor,
        "cursos": List<dynamic>.from(cursos.map((x) => x)),
        "contactos": List<dynamic>.from(contactos.map((x) => x)),
        "guardados": List<dynamic>.from(guardados.map((x) => x)),
        "recordatorio": recordatorio,
        "nombre": nombre,
        "email": email,
        "antiguedad": antiguedad.toIso8601String(),
        "comuna": comuna,
        "colegio": colegio,
        "curso": curso,
        "foto": foto,
        "descripcion": descripcion,
        "celular": celular,
        "historial": List<dynamic>.from(historial.map((x) => x)),
        "uid": uid,
    };
}
