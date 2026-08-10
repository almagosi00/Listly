import 'package:listly/data/usuario.dart';
import 'package:listly/data/elemento.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/rol_lista.dart';

class Lista{
  int _id;
  String _nombre;
  String _emoji;
  final DateTime _creacion;
  DateTime _modificacion;

  final Map<int,Elemento> _elementos;
  final List<RolLista> _rolesLista;

  Lista({required this._nombre, required this._id, required int propietarioUsuarioId, this._emoji = "", 
  Map<int,Elemento>? elementos, List<RolLista>? rolesLista, DateTime? creacion, DateTime? modificacion})
  :_elementos = elementos ?? {},
  _rolesLista = rolesLista ?? [],
  _creacion = creacion ?? DateTime.now(),
  _modificacion = modificacion ?? DateTime.now()
  {
    if(rolesLista == null){
      _rolesLista.add(RolLista(rol: Rol.propietario, usuarioId: propietarioUsuarioId));
    }
  }

  void modifyEmoji({required String emoji}){
    this._emoji = emoji;
    this._modificacion = DateTime.now();
  }

  void modifyNombre({required String nombre}){
    this._nombre = nombre;
    this._modificacion = DateTime.now();
  }

  // ## Métodos Elementos

  void addElemento({required String nombre, required String emoji, required int creadorUsuarioId, required int idElemento}){
    this._elementos[idElemento] = Elemento(id: idElemento, orden: this._elementos.length, nombre: nombre, creadorUsuarioId: creadorUsuarioId, emoji: emoji);
    
    this._modificacion = DateTime.now();
  }

  void removeElemento({required int id}){
    Elemento ele = this._elementos.remove(id)!;

    for( Elemento elemento in _elementos.values){
      if(elemento.orden > ele.orden){
        elemento.cambiarOrden(elemento.orden - 1);
      }
    }
    
    this._modificacion = DateTime.now();
  }

  void toggleElemento({required int id}){
    this._elementos[id]!.toggleTachado();
    this._modificacion = DateTime.now();
  }

  void cambiarOrdenElemento({required int idElemento, required int antiguoOrden, required int nuevoOrden}){

    if (antiguoOrden < nuevoOrden){
      _elementos.forEach((idElemento, elemento) {
        if(antiguoOrden < elemento.orden && elemento.orden <= nuevoOrden){
          elemento.cambiarOrden(elemento.orden-1);
        }
      });
    }
    else{
      _elementos.forEach((idElemento, elemento) {
        if(nuevoOrden <= elemento.orden && elemento.orden < antiguoOrden){
          elemento.cambiarOrden(elemento.orden+1);
        }
      });
    }
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

  Map<String, dynamic> toJson() => {
    'id': this._id,
    'nombre': this._nombre,
    'emoji': this.emoji,
    'fechaCreacion': this._creacion.toIso8601String(),
    'fechaModificacion': this._modificacion.toIso8601String(),
    'elementos': this._elementos.values.map((e) => e.toJson()).toList(),
    'roles': this._rolesLista.map((e) => e.toJson()).toList(),
  };

  factory Lista.fromJson(Map<String, dynamic> json){

    List<Elemento> elementos = (json['elementos'] as List).map((e) => Elemento.fromJson(e as Map<String, dynamic>)).toList();
    List<RolLista> roles = (json['roles'] as List).map((e) => RolLista.fromJson(e as Map<String, dynamic>)).toList();

    final Lista lista = Lista(
      nombre: json['nombre'] as String, 
      id: json['id'] as int, 
      propietarioUsuarioId: roles.firstWhere((element) => element.rol == Rol.propietario).usuarioId,
      emoji: json['emoji'],
      rolesLista: roles,
      elementos: { for (var element in elementos) element.id : element },
      creacion: DateTime.parse(json['fechaCreacion'] as String),
      modificacion: DateTime.parse(json['fechaModificacion'] as String)
    );

    return lista;
  }
}

