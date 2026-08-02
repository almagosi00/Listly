import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/usuario.dart';

class Repository{
  int _ultimoIdLista = 0;
  int _ultimoIdElemento = 0;

  Map<int,Lista> _listas = Map();
  late Usuario _usuario;


  Repository(){

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
    int idLista = 0;
    int idElemento = 0;

    listas.add(Lista(nombre: "Compra Semanal", id: idLista, usuarioPropietario: usu, emoji: "🛒​"));
    
    listas[idLista].addElemento(nombre: 'Tomates', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Leche', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Café', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Pan', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Papel higiénico', creador: usu, idElemento: idElemento++);

    listas[idLista].addMiembro(usuario: usuariosExtras[0], rol: Rol.administrador);
    listas[idLista].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);
    listas[idLista].addMiembro(usuario: usuariosExtras[3], rol: Rol.lector);


    //listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu, emoji: "🎂​"));
    listas.add(Lista(nombre: "Cumple Ana", id: ++idLista, usuarioPropietario: usu));
      
    listas[idLista].addElemento(nombre: 'Tarta', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Taza regalo', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Bebida variada', creador: usu, idElemento: idElemento++);

    listas[idLista].addMiembro(usuario: usuariosExtras[1], rol: Rol.modificador);
    listas[idLista].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);


    listas.add(Lista(nombre: "Tareas Piso", id: ++idLista, usuarioPropietario: usu, emoji: "🏠​"));

    listas[idLista].addElemento(nombre: 'Lavadora', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Barrer', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Fregar', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Poner lavavajillas', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Quitar el polvo dormitorios', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Pasea el perro por la mañana', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Comprar comida', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Prepara cumpleaños', creador: usu, idElemento: idElemento++);

    listas.add(Lista(nombre: "Libros Pendientes", id: ++idLista, usuarioPropietario: usu, emoji: "📚"));
    
    listas[idLista].addElemento(nombre: 'Los pilares de la tierra', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'Saga la rueda del tiempo', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'El quijote', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'La saga the witcher', creador: usu, idElemento: idElemento++);
    listas[idLista].addElemento(nombre: 'La saga de Dune', creador: usu, idElemento: idElemento++);

    listas.forEach((element) => this._listas[element.id] = element);
    this._usuario = usu;

    this._ultimoIdElemento = ++idElemento;
    this._ultimoIdLista = ++idLista;
  }

  int getIdLista() => this._ultimoIdLista++;
  int getIdElemento() => this._ultimoIdElemento++;

  void setIdLista(int idLista) => this._ultimoIdLista = idLista;
  void setIdElemento(int idElemento) => this._ultimoIdElemento = idElemento;

  Map<int,Lista> get listas => Map.unmodifiable(this._listas);
  Usuario get usuario => this._usuario;

}

final Provider repositoryProvider = Provider<Repository>((ref) => Repository());