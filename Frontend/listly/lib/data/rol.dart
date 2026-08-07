enum Rol{
  propietario('Propietario',4),
  administrador('Administrador',3),
  modificador('Modificador',2),
  lector('Lector',1);

  final String nombre;
  final int permiso;

  const Rol(this.nombre,this.permiso);

  String toJson() => this.name;

  static Rol fromJson(String json) => Rol.values.byName(json);
}