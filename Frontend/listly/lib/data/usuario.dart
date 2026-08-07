
class Usuario{
  final int _id;
  String _nombre = "";
  String _correo = "";

  Usuario({required this._id});

  void setNombre(String nombre){
    this._nombre = nombre;
  }

  void setCorreo(String correo){
    this._correo = correo;
  }

  int get id => this._id;

  Map<String, dynamic> toJson() => {
    'id': this._id,
    'nombre': this._nombre,
    'correo': this._correo,
  };

  factory Usuario.fromJson(Map<String, dynamic> json){
    final Usuario usuario = Usuario(id: json['id'] as int);
    usuario._nombre = json['nombre'] as String;
    usuario._correo = json['correo'] as String;
    return usuario;
  }
}