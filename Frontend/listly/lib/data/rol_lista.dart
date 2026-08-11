import 'package:listly/data/usuario.dart';
import 'package:listly/data/rol.dart';

class RolLista {
  Rol _rol;
  final int _usuarioId;

  RolLista({required this._rol, required this._usuarioId});

  Rol get rol => this._rol;

  int get usuarioId => this._usuarioId;

  Map<String, dynamic> toJson() => {
    'rol': this._rol.toJson(),
    'usuarioId': this._usuarioId,
  };

  factory RolLista.fromJson(Map<String, dynamic> json){
    final RolLista rolLista = RolLista(
      rol: Rol.fromJson(json['rol']), 
      usuarioId: json['usuarioId'] as int
    );
    return rolLista;
  }
}