import 'package:flutter/material.dart';

class Programa {
  final IconData icon;
  final String nombre;
  final int maxItems;
  final int seleccionados;

  Programa(this.icon, this.nombre, this.maxItems, this.seleccionados);
}

List<Programa> programas = [
  Programa(Icons.book, 'Advance Ip Scaner', 24, 6),
  Programa(Icons.book, 'Adobe Acrobat', 24, 6),
  Programa(Icons.book, 'Adobe Genuine Service', 24, 6),
  Programa(Icons.book, 'Adobe Flash Player', 24, 6),
  Programa(Icons.book, 'Apple Software', 24, 6),
  Programa(Icons.book, 'AnyDesk', 24, 6), 
  Programa(Icons.book, 'Brave', 24, 6),
  Programa(Icons.book, 'Cisco WebEx Meetings', 24, 6),
  Programa(Icons.book, 'Kit Epson', 24, 6),
  Programa(Icons.book, 'Chrome', 24, 6),
  Programa(Icons.book, 'Office Standard', 24, 6),
  Programa(Icons.book, 'OneDrive', 24, 6),
  Programa(Icons.book, '7-Zip', 24, 6),
  Programa(Icons.book, 'Zoom', 24, 6),
  Programa(Icons.book, 'WinRAR', 24, 6),
  Programa(Icons.book, 'Mozilla Firefox', 24, 6),
  Programa(Icons.book, 'Mozilla Thundebird', 24, 6),
  Programa(Icons.book, 'PDF24', 24, 6),
  Programa(Icons.book, 'webex', 24, 6),
  Programa(Icons.book, 'VLC', 24, 6),
  Programa(Icons.book, 'Edge', 24, 6),
  Programa(Icons.book, 'Conexion a Escritorio Remoto', 24, 6),
  Programa(Icons.book, 'Camtasia Studio 7', 24, 6),
  Programa(Icons.book, 'postgreSQL', 24, 6),
  Programa(Icons.book, 'pgAdmin', 24, 6),
  Programa(Icons.book, 'Skype', 24, 6),
  Programa(Icons.book, 'Spotify', 24, 6),
  Programa(Icons.book, 'WhatsApp', 24, 6),
];
