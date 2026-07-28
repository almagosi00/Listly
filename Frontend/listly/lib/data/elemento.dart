import 'package:listly/data/usuario.dart';

class Elemento{
  int _id;
  int _orden;
  String _nombre;
  String _emoji;
  bool _tachado = false;
  final Usuario _creador;

  Elemento({required this._id, required this._orden, required this._nombre, required this._creador, this._emoji = ""});

  void toggleTachado(){
    this._tachado = !this._tachado;
  }

  void cambiarOrden(int orden){
    this._orden = orden;
  }

  void cambiarNombre(String nombre){
    this._nombre = nombre;
  }

  void cambiarEmoji(String emoji){
    this._emoji = emoji;
  }

  String get nombre => this._nombre;
  String get emoji => this._emoji;
  bool get tachado => this._tachado;
  int get id => this._id;
  int get orden => this._orden;  
}