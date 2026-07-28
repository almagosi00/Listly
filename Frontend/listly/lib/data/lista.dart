import 'package:listly/data/usuario.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/rol_lista.dart';

class Lista{
  int _id;
  String _nombre;
  String _emoji;
  final DateTime _creacion = DateTime.now();
  DateTime _modificacion = DateTime.now();

  final Map<int,Elemento> _elementos = Map();
  final List<RolLista> _rolesLista=[];

  Lista({required this._nombre, required this._id, required Usuario usuarioPropietario, this._emoji = ""})
  {
    _rolesLista.add(RolLista(rol: Rol.propietario, usuario: usuarioPropietario));
  }

  void addMiembro({required Usuario usuario, required Rol rol}){
    this._rolesLista.add(RolLista(rol: rol, usuario: usuario));
    this._modificacion = DateTime.now();
  }

  // ## Métodos Elementos

  void addElemento({required Elemento elemento}){
    this._elementos[elemento.id] = elemento;
    this._modificacion = DateTime.now();
  }

  void removeElemento({required int id}){
    Elemento ele = this._elementos.remove(id)!;

    this.elementos.forEach((elemento) {
      if(elemento.orden > ele.orden){
        elemento.cambiarOrden(elemento.orden-1);
      }
    });
    
    this._modificacion = DateTime.now();
  }

  void toggleElemento({required int id}){
    this._elementos[id]!.toggleTachado();
    this._modificacion = DateTime.now();
  }

  void cambiarOrdenElemento({required int idElemento, required int nuevoOrden}){
    this._elementos[idElemento]!.cambiarOrden(nuevoOrden);    
    this._modificacion = DateTime.now();
  }

  void modifyElementoNombre({required int idElemento, required String nombre}){
    this._elementos[idElemento]!.cambiarNombre(nombre);    
    this._modificacion = DateTime.now();
  }

  void modifyElementoEmoji({required int idElemento, required String emoji}){
    this._elementos[idElemento]!.cambiarEmoji(emoji);   
    this._modificacion = DateTime.now();
  }
  
  List<Elemento> get elementos{
    List<Elemento> l = this._elementos.values.toList();
    l.sort((a, b) => a.orden.compareTo(b.orden));
    return List.unmodifiable(l);
  }

  int get id => this._id;
  String get nombre => this._nombre;
  String get emoji => this._emoji;
  int get numElementos => this._elementos.length;
  int get numPersonas => this._rolesLista.length;
  bool get compartida => this._rolesLista.length > 1;
  DateTime get modificacion => this._modificacion;
}

