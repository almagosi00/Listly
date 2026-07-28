import 'package:listly/data/elemento.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/usuario.dart';

List<Lista> mockData(){

  Usuario usu = Usuario();
  usu.setNombre('Javier Rodríguez');
  usu.setCorreo('javier.rodriguez@gmail.com');

  List<Usuario> usuariosExtras = [
    Usuario(),
    Usuario(),
    Usuario(),
    Usuario()
  ];

  usuariosExtras[0].setNombre("Marta Gomez");
  usuariosExtras[1].setNombre("Carlos Ruiz");
  usuariosExtras[2].setNombre("Lucia Fernandez");
  usuariosExtras[3].setNombre("Álvaro Rodríguez");

  usuariosExtras[0].setCorreo("marta.gomez@gmail.com");
  usuariosExtras[1].setCorreo("carlos.ruiz@gmail.com");
  usuariosExtras[2].setCorreo("lucia.fernandez@gmail.com");
  usuariosExtras[3].setCorreo("alvaro.rodriguez@gmail.com");

  List<Lista> listas = [];
  int idUltimo = 0;

  listas.add(Lista(nombre: "Compra Semanal", id: idUltimo, usuarioPropietario: usu, emoji: "🛒​"));
  
  listas[idUltimo].addElemento(nombre: 'Tomates', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Leche', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Café', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Pan', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Papel higiénico', creador: usu);

  listas[idUltimo].addMiembro(usuario: usuariosExtras[0], rol: Rol.administrador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[3], rol: Rol.lector);


  //listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu, emoji: "🎂​"));
  listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu));
    
  listas[idUltimo].addElemento(nombre: 'Tarta', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Taza regalo', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Bebida variada', creador: usu);

  listas[idUltimo].addMiembro(usuario: usuariosExtras[1], rol: Rol.modificador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);


  listas.add(Lista(nombre: "Tareas Piso", id: ++idUltimo, usuarioPropietario: usu, emoji: "🏠​"));

  listas[idUltimo].addElemento(nombre: 'Lavadora', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Barrer', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Fregar', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Poner lavavajillas', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Quitar el polvo dormitorios', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Pasea el perro por la mañana', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Comprar comida', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Prepara cumpleaños', creador: usu);

  listas.add(Lista(nombre: "Libros Pendientes", id: ++idUltimo, usuarioPropietario: usu, emoji: "📚"));
  
  listas[idUltimo].addElemento(nombre: 'Los pilares de la tierra', creador: usu);
  listas[idUltimo].addElemento(nombre: 'Saga la rueda del tiempo', creador: usu);
  listas[idUltimo].addElemento(nombre: 'El quijote', creador: usu);
  listas[idUltimo].addElemento(nombre: 'La saga the witcher', creador: usu);
  listas[idUltimo].addElemento(nombre: 'La saga de Dune', creador: usu);

  return listas;

}
