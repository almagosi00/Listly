import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/data/rol.dart';
import 'package:listly/data/usuario.dart';
import 'package:path_provider/path_provider.dart';

class Repository{

  final bool usarDatosMock = true;

  int _ultimoIdLista = 0;
  int _ultimoIdElemento = 0;
  int _ultimoIdUsuario = 0;

  late Map<int,Lista> _listas;
  late Map<int, Usuario> _usuarios;
  late Usuario _usuarioPrincipal;

  Repository._();

  static Future<Repository> init() async{
    final Repository repo = Repository._();
    await repo._cargarDatos();
    return repo;

  }


  Future<void> _cargarDatos() async{
    final File archivo = await _obtenerArchivo();

    if ( await archivo.exists()){
      final contenidoString = await archivo.readAsString();
      final crudo=jsonDecode(contenidoString) as Map<String, dynamic>;

      final mapaUsuarios = <int, Usuario>{};
      for ( final usu in (crudo['usuarios'] as List)){
        final usuario = Usuario.fromJson(usu as Map<String, dynamic>);
        mapaUsuarios[usuario.id] = usuario;
        if(usuario.id >= this._ultimoIdUsuario) this._ultimoIdUsuario = usuario.id + 1;
      }

      final mapaListas = <int, Lista>{};
      for ( final l in (crudo['listas'] as List)){
        final lista = Lista.fromJson(l as Map<String, dynamic>, mapaUsuarios);
        mapaListas[lista.id] = lista;
        if(lista.id >= this._ultimoIdLista) this._ultimoIdLista = lista.id + 1;
        
        for(final elemento in lista.elementos){
          if( elemento.id > this._ultimoIdElemento) this._ultimoIdElemento = elemento.id + 1;
        }
      }

      this._listas = mapaListas;
      this._usuarios = mapaUsuarios;
      this._usuarioPrincipal = this._usuarios.values.first;
    }
    else{
      _listas = {};
      _usuarios= {};
      if(usarDatosMock){
        _generarMock();
      }
      else{
        _usuarioPrincipal = Usuario(id: getIdUsuario());
        _usuarios[_usuarioPrincipal.id] = _usuarioPrincipal;
      }
    }

  }

  void _generarMock(){
    this._usuarioPrincipal = Usuario(id: getIdUsuario());
    this._usuarioPrincipal.setNombre('Javier Rodríguez');
    this._usuarioPrincipal.setCorreo('javier.rodriguez@gmail.com');

    List<Usuario> usuariosExtras = [
      Usuario(id: getIdUsuario()),
      Usuario(id: getIdUsuario()),
      Usuario(id: getIdUsuario()),
      Usuario(id: getIdUsuario())
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
    int idLista = getIdLista();

    listas.add(Lista(nombre: "Compra Semanal", id: idLista, usuarioPropietario: this._usuarioPrincipal, emoji: "🛒​"));
    
    listas[idLista].addElemento(nombre: 'Tomates', creador: this._usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Leche', creador: this._usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Café', creador: this._usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Pan', creador: this._usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Papel higiénico', creador: this._usuarioPrincipal, idElemento: getIdElemento(), emoji: "");

    listas[idLista].addMiembro(usuario: usuariosExtras[0], rol: Rol.administrador);
    listas[idLista].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);
    listas[idLista].addMiembro(usuario: usuariosExtras[3], rol: Rol.lector);


    idLista = getIdLista();
    //listas.add(Lista(nombre: "Cumple Ana", id: ++idUltimo, usuarioPropietario: usu, emoji: "🎂​"));
    listas.add(Lista(nombre: "Cumple Ana", id: idLista, usuarioPropietario: _usuarioPrincipal));
      
    listas[idLista].addElemento(nombre: 'Tarta', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Taza regalo', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Bebida variada', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");

    listas[idLista].addMiembro(usuario: usuariosExtras[1], rol: Rol.modificador);
    listas[idLista].addMiembro(usuario: usuariosExtras[2], rol: Rol.modificador);


    idLista = getIdLista();
    listas.add(Lista(nombre: "Tareas Piso", id: idLista, usuarioPropietario: _usuarioPrincipal, emoji: "🏠​"));

    listas[idLista].addElemento(nombre: 'Lavadora', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Barrer', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Fregar', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Poner lavavajillas', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Quitar el polvo dormitorios', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Pasea el perro por la mañana', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Comprar comida', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Prepara cumpleaños', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");

    idLista = getIdLista();
    listas.add(Lista(nombre: "Libros Pendientes", id: idLista, usuarioPropietario: _usuarioPrincipal, emoji: "📚"));
    
    listas[idLista].addElemento(nombre: 'Los pilares de la tierra', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'Saga la rueda del tiempo', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'El quijote', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'La saga the witcher', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");
    listas[idLista].addElemento(nombre: 'La saga de Dune', creador: _usuarioPrincipal, idElemento: getIdElemento(), emoji: "");

    listas.forEach((element) => this._listas[element.id] = element);
    this._usuarios[this._usuarioPrincipal.id] = this._usuarioPrincipal;
    usuariosExtras.forEach((element) => this._usuarios[element.id] = element);
  }

  
  int getIdLista() => this._ultimoIdLista++;
  int getIdElemento() => this._ultimoIdElemento++;
  int getIdUsuario() => this._ultimoIdUsuario++;

  void setIdLista(int idLista) => this._ultimoIdLista = idLista;
  void setIdElemento(int idElemento) => this._ultimoIdElemento = idElemento;

  Map<int,Lista> get listas => Map.unmodifiable(this._listas);
  Usuario get usuario => this._usuarioPrincipal;

  Future<File> _obtenerArchivo() async {
    final Directory directorio = await getApplicationDocumentsDirectory();
    return File('${directorio.path}/data.json');
  }

  Future<void> _guardarDatos() async{
    final File archivo = await this._obtenerArchivo();

    final Map<String, List<Map<String, dynamic>>> contenido = {
      'usuarios' : _usuarios.values.map((e) => e.toJson()).toList(),
      'listas' : _listas.values.map((e) => e.toJson()).toList()
    };

    await archivo.writeAsString(jsonEncode(contenido));
  }

  Future<void> actualizarListas({required Map<int, Lista> listas}) async{
    _listas = listas;
    await _guardarDatos();
  }

  Future<void> actualizarUsuarios({required Map<int, Usuario> usuarios}) async{
    _usuarios = usuarios;
    await _guardarDatos();
  }

  Future<Map<String, dynamic>?> cargarDatos() async {
  final archivo = await _obtenerArchivo();

  if (!await archivo.exists()) {
    return null;
  }

  final contenidoTexto = await archivo.readAsString();
    return jsonDecode(contenidoTexto) as Map<String, dynamic>;
  }

  Future<(Map<int, Usuario>, Map<int, Lista>)> cargarDatosReconstruidos() async {
    final crudo = await cargarDatos();

    if (crudo == null) {
      return (<int, Usuario>{}, <int, Lista>{}); // no hay archivo todavía, primera vez que se abre la app
    }

    final usuariosJson = crudo['usuarios'] as List;
    final usuarios = <int, Usuario>{};
    for (final u in usuariosJson) {
      final usuario = Usuario.fromJson(u as Map<String, dynamic>);
      usuarios[usuario.id] = usuario;
    }

    final listasJson = crudo['listas'] as List;
    final listas = <int, Lista>{};
    for (final l in listasJson) {
      final lista = Lista.fromJson(l as Map<String, dynamic>, usuarios);
      listas[lista.id] = lista;
    }

    return (usuarios, listas);
  }

}

final FutureProvider<Repository> repositoryProvider = FutureProvider<Repository>((ref) async{
  return Repository.init();
},);