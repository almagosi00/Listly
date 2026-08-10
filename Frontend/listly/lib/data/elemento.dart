import 'package:listly/data/usuario.dart';

class Elemento{
  int _id;
  int _orden;
  String _nombre;
  String _emoji;
  bool _tachado = false;
  final int _creadorUsuarioId;

  Elemento({required this._id, required this._orden, required this._nombre, required this._creadorUsuarioId, this._emoji = ""});

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

  Map<String, dynamic> toJson() => {
    'id': this._id,
    'nombre': this.nombre,
    'emoji': this._emoji,
    'tachado': this.tachado,
    'creadorId': this._creadorUsuarioId,
    'orden': this._orden,
  };

  factory Elemento.fromJson(Map<String, dynamic> json){
    final Elemento elemento = Elemento(
      id: json['id'] as int, 
      orden: json['orden'] as int, 
      nombre: json['nombre'] as String, 
      creadorUsuarioId: json['creadorId'] as int,
      emoji: json['emoji'] as String,
    );
    elemento._tachado = json['tachado'] as bool;
    return elemento;
  }
}