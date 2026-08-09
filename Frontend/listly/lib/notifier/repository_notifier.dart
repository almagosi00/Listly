import 'dart:convert';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/data/usuario.dart';
import 'package:path_provider/path_provider.dart';

part 'repository_notifier.g.dart';

class _AppState{
  final Map<int, Lista> _listas;
  final Map<int, Usuario> _usuarios;
  final int _principalUsuarioID;

  _AppState({required this._listas, required this._usuarios}) : this._principalUsuarioID = _usuarios.keys.first;

  Map<int, Lista> get listas => Map.unmodifiable(_listas);
  Map<int, Usuario> get usuarios => Map.unmodifiable(_usuarios);
  int get principalUsuarioId => _principalUsuarioID;
}

@riverpod
class RepositoryNotifier extends _$RepositoryNotifier{

  int _ultimoIdLista = 0;
  int _ultimoIdElemento = 0;
  int _ultimoIdUsuario = 0;

  @override
  Future<_AppState> build() async{
    return await _cargarDatos();
  }


  Future<_AppState> _cargarDatos() async{
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

      return(_AppState(listas: mapaListas, usuarios: mapaUsuarios));
    }
    else{

      int idUsuario = _getIdUsuario();
      return(_AppState(
        listas: {}, 
        usuarios: { idUsuario : Usuario(id: idUsuario)}
      ));
    }

  }
  
  int _getIdLista() => this._ultimoIdLista++;
  int _getIdElemento() => this._ultimoIdElemento++;
  int _getIdUsuario() => this._ultimoIdUsuario++;

  void setIdLista(int idLista) => this._ultimoIdLista = idLista;
  void setIdElemento(int idElemento) => this._ultimoIdElemento = idElemento;

  void _actualizarState(Map<int, Lista> listasMapa, Map<int, Usuario> usuariosMapa){
    state = AsyncValue.data(_AppState(
      listas: listasMapa, 
      usuarios: usuariosMapa
    ));
    _guardarDatos();
  }

  //## Archivo data.json

  Future<File> _obtenerArchivo() async {
    final Directory directorio = await getApplicationDocumentsDirectory();
    return File('${directorio.path}/data.json');
  }

  Future<void> _guardarDatos() async{
    final File archivo = await this._obtenerArchivo();

    final Map<String, List<Map<String, dynamic>>> contenido = {
      'usuarios' : state.requireValue._usuarios.values.map((e) => e.toJson()).toList(),
      'listas' : state.requireValue._listas.values.map((e) => e.toJson()).toList()
    };

    await archivo.writeAsString(jsonEncode(contenido));
  }

  // ## Listas

  void crearLista({required String nombreLista, required String emojiLista}){
    final int idLista = _getIdLista();
    final stateActual = state.requireValue;
    _actualizarState(
      {...stateActual._listas, 
        idLista : Lista(
          nombre: nombreLista, 
          id: idLista, 
          propietarioUsuarioId: stateActual._principalUsuarioID,
          emoji: emojiLista
        )
      }, 
      stateActual._usuarios
    );
  }

  void modificarListaNombre({required int idLista, required String nombreLista}){
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.modifyNombre(nombre: nombreLista);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void modificarListaEmoji({required int idLista, required String emojiLista}){
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.modifyEmoji(emoji: emojiLista);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void eliminarLista({required int idLista}){
    final stateActual = state.requireValue;
    stateActual._listas.remove(idLista);    
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  // ## Elementos

  void crearElemento({required int idLista, required String nombreElemento, required String emojiElemento}){
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.addElemento(
      nombre: nombreElemento, 
      emoji: emojiElemento, 
      creadorUsuarioId: stateActual._principalUsuarioID, 
      idElemento: _getIdElemento()
    );
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void modificarElementoNombre({required int idLista, required int idElemento ,required String nombreElmento}){
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.modifyElementoNombre(idElemento: idElemento, nombre: nombreElmento);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void modificarElementoEmoji({required int idLista, required int idElemento ,required String emojiElemento}){
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.modifyElementoEmoji(idElemento: idElemento, emoji: emojiElemento);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void eliminarElemento({required int idLista, required int idElemento}){
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.removeElemento(id: idElemento);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void elementoToogleTachado({required int idLista, required int idElemento}){    
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.toggleElemento(id: idElemento);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

  void elementoCambiarOrden({required int idLista, required int idElemento, required int antiguoOrden, required int nuevoOrden}){    
    final stateActual = state.requireValue;
    stateActual._listas[idLista]!.cambiarOrdenElemento(idElemento: idElemento, antiguoOrden: antiguoOrden, nuevoOrden: nuevoOrden);
    _actualizarState({...stateActual._listas}, stateActual._usuarios);
  }

}