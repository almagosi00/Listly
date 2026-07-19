enum Rol{
  propietario('Propietario',4),
  administrador('Administrador',3),
  modificador('Modificador',2),
  lector('Lector',1);

  final String nombre;
  final int permiso;

  const Rol(this.nombre,this.permiso);
}