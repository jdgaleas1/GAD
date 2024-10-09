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
  String encargado;
  String codigoActFijosDispositivos;
  String observaciones;
  String custodio;

  Dispositivos({
    required this.marcaTemporal,
    required this.ip,
    required this.modelo,
    required this.area,
    required this.servicio,
    required this.tipo,
    required this.encargado,
    required this.codigoActFijosDispositivos,
    required this.observaciones,
    required this.custodio,
  });

  factory Dispositivos.fromJson(Map<String, dynamic> json) => Dispositivos(
        modelo: json["Modelo"] ?? '',
        marcaTemporal: json["Marca temporal"] ?? '',
        ip: json["IP"] ?? '',
        area: json["Área"] ?? '',
        servicio: json["Servicio"] ?? '',
        tipo: json["Tipo"] ?? '',
        encargado: json["encargado"] ?? '',
        codigoActFijosDispositivos: json["codigo Act Fijos"] ?? '',
        observaciones: json["Observaciones"] ?? '',
        custodio: json["Custodio"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Marca temporal": marcaTemporal,
        "IP": ip,
        "Modelo": modelo,
        "Área": area,
        "Servicio": servicio,
        "Tipo": tipo,
        "encargado": encargado,
        "codigo Act Fijos": codigoActFijosDispositivos,
        "Observaciones": observaciones,
        "Custodio": custodio,
      };
}
