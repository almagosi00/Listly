import 'package:listly/data/usuario.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/rol_lista.dart';

class Lista{
  int _id;
  String _nombre;
  String _emoji;

  final List<Elemento> _elementos = [];
  final List<RolLista> _rolesLista=[];

  Lista({required this._nombre, required this._id, required Usuario usuarioPropietario, this._emoji = ""})
  {
    _rolesLista.add(RolLista(rol: Rol.propietario, usuario: usuarioPropietario));
  }

  void addElemento({required Elemento elemento}){
    this._elementos.add(elemento);
  }

  void addMiembro({required Usuario usuario, required Rol rol}){
    this._rolesLista.add(RolLista(rol: rol, usuario: usuario));
  }

  String get nombre => this._nombre;
  String get emoji => this._emoji;
  int get numElementos => this._elementos.length;
  int get numPersonas => this._rolesLista.length;
  bool get compartida => this._rolesLista.length > 1;
}

