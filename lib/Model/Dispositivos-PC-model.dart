// To parse this JSON data, do
//
//     final Dispositivos = DispositivosFromJson(jsonString);

import 'dart:convert';

String dispositivosToJson(Dispositivos data) => json.encode(data.toJson());

class Dispositivos {
  String marcaTemporal;
  String ip;
  String modelo;
  String area;
  String servicio;
  String tipo;
  String observaciones;


  Dispositivos({
    required this.marcaTemporal,
    required this.ip,
    required this.modelo,
    required this.area,
    required this.servicio,
    required this.tipo,
    required this.observaciones,
  });

  factory Dispositivos.fromJson(Map<String, dynamic> json) => Dispositivos(
        modelo: json["Modelo"] ?? '',
        marcaTemporal: json["Marca temporal"] ?? '',
        ip: json["IP"] ?? '',
        area: json["Área"] ?? '',
        servicio: json["Servicio"] ?? '',
        tipo: json["Tipo"] ?? '',
        observaciones: json["Observaciones"] ?? '',

      );

  Map<String, dynamic> toJson() => {
        "Marca temporal": marcaTemporal,
        "IP": ip,
        "Modelo": modelo,
        "Área": area,
        "Servicio": servicio,
        "Tipo": tipo,
        "Observaciones": observaciones,
      };
}
