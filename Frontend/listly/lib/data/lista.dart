import 'package:listly/data/usuario.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/rol_lista.dart';

class Lista{
  int _id;
  String _nombre;
  String? _emoji;

  final List<Elemento> _elementos = [];
  final List<RolLista> _rolesLista=[];

  Lista({required this._nombre, required this._id, required Usuario usuarioPropietario})
  {
    _rolesLista.add(RolLista(rol: Rol.propietario, usuario: usuarioPropietario));
  }
}

