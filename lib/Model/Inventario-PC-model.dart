// To parse this JSON data, do
//
//     final inventarioPCs = inventarioPCsFromJson(jsonString);

import 'dart:convert';

String inventarioPCsToJson(InventarioPCs data) => json.encode(data.toJson());

class InventarioPCs {

  String marcaTemporal;
  String unidad;
  String ip;
  String nombreDeLaPc;
  String nombreDelFuncionario;
  String puestoQueOcupa;
  String redConectada;
  String nombreDeRed;
  String dns1;
  String dns2;
  String sistemaOperativo;
  String maquinaTodoEnUno;
  String caracteristicas;
  String laptop;
  String codigoActFijos;
  String estadoDeComputadora;
  String dominio;
  String programasLicencias;
  String ipRestringidas;
  String observaciones;

  InventarioPCs({         
    required this.marcaTemporal,
    required this.unidad,
    required this.ip,
    required this.nombreDeLaPc,
    required this.nombreDelFuncionario,
    required this.puestoQueOcupa,
    required this.redConectada,
    required this.nombreDeRed,
    required this.dns1,
    required this.dns2,
    required this.sistemaOperativo,
    required this.maquinaTodoEnUno,
    required this.caracteristicas,
    required this.laptop,
    required this.codigoActFijos,
    required this.estadoDeComputadora,
    required this.dominio,
    required this.programasLicencias,
    required this.ipRestringidas,
    required this.observaciones,
  });

  factory InventarioPCs.fromJson(Map<String, dynamic> json) => InventarioPCs(
        marcaTemporal: json["Marca temporal"] ?? '',
        unidad: json["Unidad"] ?? '',
        ip: json["IP"] ?? '',
        nombreDeLaPc: json["NOMBRE DE LA PC"] ?? '',
        nombreDelFuncionario: json["NOMBRE DEL FUNCIONARIO"] ?? '',
        puestoQueOcupa: json["PUESTO QUE OCUPA"] ?? '',
        redConectada: json["RED CONECTADA"] ?? '',
        nombreDeRed: json["NOMBRE DE RED"] ?? '',
        dns1: json["DNS-1"] ?? '',
        dns2: json["DNS-2"] ?? '',
        sistemaOperativo: json["SISTEMA OPERATIVO"] ?? '',
        maquinaTodoEnUno: json["MAQUINA TODO EN UNO"] ?? '',
        caracteristicas: json["CARACTERISTICAS"] ?? '',
        laptop: json["LAPTOP"] ?? '',
        codigoActFijos: json["CODIGO ACT FIJOS"] ?? '',
        estadoDeComputadora: json["ESTADO DE COMPUTADORA"] ?? '',
        dominio: json["Dominio"] ?? '',
        programasLicencias: json["Programas y Licencia"] ?? '',
        ipRestringidas: json["IP restringidas"] ?? '',
        observaciones: json["Observaciones"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Marca temporal": marcaTemporal,
        "Unidad": unidad,
        "IP": ip,
        "NOMBRE DE LA PC": nombreDeLaPc,
        "NOMBRE DEL FUNCIONARIO": nombreDelFuncionario,
        "PUESTO QUE OCUPA": puestoQueOcupa,
        "RED CONECTADA": redConectada,
        "NOMBRE DE RED": nombreDeRed,
        "DNS-1": dns1,
        "DNS-2": dns2,
        "SISTEMA OPERATIVO": sistemaOperativo,
        "MAQUINA TODO EN UNO": maquinaTodoEnUno,
        "CARACTERISTICAS": caracteristicas,
        "LAPTOP": laptop,
        "CODIGO ACT FIJOS": codigoActFijos,
        "ESTADO DE COMPUTADORA": estadoDeComputadora,
        "Dominio": dominio,
        "Programas y Licencia": programasLicencias,
        "IP restringidas": ipRestringidas,
        "Observaciones":observaciones,
      };
}
