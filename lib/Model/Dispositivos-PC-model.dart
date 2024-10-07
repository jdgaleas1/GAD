// To parse this JSON data, do
//
//     final inventarioPCs = inventarioPCsFromJson(jsonString);

import 'dart:convert';

String inventarioPCsToJson(InventarioDispositivos data) =>
    json.encode(data.toJson());

class InventarioDispositivos {
  String modelo;
  String area;
  String servicio;
  String tipo;
  String observaciones;
  String marcaTemporal;
  String ip;

  InventarioDispositivos({
    required this.modelo,
    required this.area,
    required this.servicio,
    required this.tipo,
    required this.observaciones,
    required this.marcaTemporal,
    required this.ip,
  });

  factory InventarioDispositivos.fromJson(Map<String, dynamic> json) =>
      InventarioDispositivos(
        modelo: json["Modelo"] ?? '',
        area: json["Área"] ?? '',
        servicio: json["Servicio"] ?? '',
        tipo: json["Tipo"] ?? '',
        observaciones: json["Observaciones"] ?? '',
        marcaTemporal: json["Marca temporal"] ?? '',
        ip: json["IP"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Modelo": modelo,
        "Área": area,
        "Servicio": servicio,
        "Tipo": tipo,
        "Observaciones": observaciones,
        "Marca temporal": marcaTemporal,
        "IP": ip,
      };
}
