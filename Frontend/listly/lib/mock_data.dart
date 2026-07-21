import 'package:listly/data/elemento.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/usuario.dart';

List<Lista> mockData(){

  Usuario usu = Usuario(nombre: "Javier Rodríguez", correo: "javier.rodriguez@gmail.com");

  List<Usuario> usuariosExtras = [
    Usuario(nombre: "Marta Gómez", correo: "marta.gomez@gmail.com"),
    Usuario(nombre: "Carlos Ruiz", correo: "carlos.ruiz@gmail.com"),
    Usuario(nombre: "Lucía Fernandez", correo: "lucia.fernandez@gmail.com"),
    Usuario(nombre: "Álvaro Rodríguez", correo: "alvaro.rodriguez@gmail.com")
  ];

  List<Lista> listas = [];
  int idUltimo = 0;

  listas.add(Lista(nombre: "Compra Semanal", id: idUltimo, usuarioPropietario: usu, emoji: "🛒​"));

  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Tomates", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Pan", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Leche", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Café", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Papel higiénico", creador: usu));

  listas[idUltimo].addMiembro(usuario: usuariosExtras[0], rol: Rol.administrador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[3], rol: Rol.lector);


  //listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu, emoji: "🎂​"));
  listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu));

  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Tarta", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Taza regalo", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Bebida variada", creador: usu));

  listas[idUltimo].addMiembro(usuario: usuariosExtras[1], rol: Rol.modificador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);


  listas.add(Lista(nombre: "Tareas Piso", id: ++idUltimo, usuarioPropietario: usu, emoji: "🏠​"));

  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Lavadora", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Barrer", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Fregar", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Poner lavavajillas", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Quitar el polvo dormitorios", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Pasear el perro por la mañana", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Comprar comida", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Preparar cumpleaños", creador: usu));


  listas.add(Lista(nombre: "Libros Pendientes", id: ++idUltimo, usuarioPropietario: usu, emoji: "📚"));

  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Los pilares de la tierra", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "Saga la rueda del tiempo", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "El quijote", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "La saga the witcher", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(nombre: "La saga de Duna", creador: usu));

  return listas;

}
