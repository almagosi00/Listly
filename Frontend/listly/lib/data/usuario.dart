
class Usuario{
  int _id = 0;
  String _nombre = "";
  String _correo = "";

  Usuario();

  void setNombre(String nombre){
    this._nombre = nombre;
  }

  void setCorreo(String correo){
    this._correo = correo;
  }
}