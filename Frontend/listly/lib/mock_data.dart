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
  int idElemento = 0;
  int ordenElemento = 0;

  listas.add(Lista(nombre: "Compra Semanal", id: idUltimo, usuarioPropietario: usu, emoji: "🛒​"));

  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Tomates", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Pan", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Leche", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Café", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Papel higiénico", creador: usu));

  listas[idUltimo].addMiembro(usuario: usuariosExtras[0], rol: Rol.administrador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[3], rol: Rol.lector);


  //listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu, emoji: "🎂​"));
  listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu));
  idElemento = 0;
  ordenElemento = 0;

  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Tarta", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Taza regalo", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Bebida variada", creador: usu));

  listas[idUltimo].addMiembro(usuario: usuariosExtras[1], rol: Rol.modificador);
  listas[idUltimo].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);


  listas.add(Lista(nombre: "Tareas Piso", id: ++idUltimo, usuarioPropietario: usu, emoji: "🏠​"));
  idElemento = 0;
  ordenElemento = 0;

  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Lavadora", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Barrer", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Fregar", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Poner lavavajillas", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Quitar el polvo dormitorios", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Pasear el perro por la mañana", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Comprar comida", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Preparar cumpleaños", creador: usu));


  listas.add(Lista(nombre: "Libros Pendientes", id: ++idUltimo, usuarioPropietario: usu, emoji: "📚"));
  idElemento = 0;
  ordenElemento = 0;

  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Los pilares de la tierra", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "Saga la rueda del tiempo", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "El quijote", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "La saga the witcher", creador: usu));
  listas[idUltimo].addElemento(elemento: Elemento(id: idElemento++, orden: ordenElemento++, nombre: "La saga de Duna", creador: usu));

  return listas;

}
