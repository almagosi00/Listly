import 'package:listly/data/usuario.dart';

class Elemento{
  int _id;
  String _nombre;
  String _emoji;
  bool _tachado = false;
  final Usuario _creador;

  Elemento({required this._id, required this._nombre, required this._creador, this._emoji = ""});

  String get nombre => this._nombre;
  String get emoji => this._emoji;
  bool get tachado => this._tachado;
  int get id => this._id;
}