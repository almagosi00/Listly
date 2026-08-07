import 'package:listly/data/usuario.dart';
import 'package:listly/data/rol.dart';

class RolLista {
  Rol _rol;
  final Usuario _usuario;

  RolLista({required this._rol, required this._usuario});

  Rol get rol => this._rol;

  Usuario get usuario => this._usuario;

  Map<String, dynamic> toJson() => {
    'rol': this._rol.toJson(),
    'usuarioId': this._usuario.id,
  };

  factory RolLista.fromJson(Map<String, dynamic> json, Map<int, Usuario> usuariosConocidos){
    final RolLista rolLista = RolLista(
      rol: Rol.fromJson(json['rol']), 
      usuario: usuariosConocidos[json['usuarioId'] as int]!
    );
    return rolLista;
  }
}