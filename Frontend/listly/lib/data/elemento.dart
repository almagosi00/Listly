import 'package:listly/data/usuario.dart';

class Elemento{
  String _nombre;
  String? _emoji;
  bool _tachado = false;
  final Usuario _creador;

  Elemento({required this._nombre, required this._creador});
}