import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listly/data/lista.dart';
import 'package:listly/notifier/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'listas_notifier.g.dart';

@riverpod
class ListasNotifier extends _$ListasNotifier{

  Map<int, Lista> get _state => state.value ?? {};
  void _actualizarState(Map<int, Lista> nuevo) async{
    state = AsyncValue.data(Map.unmodifiable(nuevo));
    await ref.read(repositoryProvider).requireValue.actualizarListas(listas: state.requireValue);
  } 

  @override
  Future<Map<int, Lista>> build() async {
    final repo = await ref.watch(repositoryProvider.future);
    return repo.listas;
  }

  // ## Listas

  void addLista({required String nombre, required String emoji}){
    int idLista = ref.read(repositoryProvider).requireValue.getIdLista();
    this._actualizarState({..._state, idLista: Lista(
      id: idLista,
      nombre: nombre, 
      emoji: emoji, 
      usuarioPropietario: ref.read(repositoryProvider).requireValue.usuario
      )});
  }

  void eliminarLista({required int idLista}){
    Map<int, Lista> copia = Map<int, Lista>.of(_state);
    copia.remove(idLista);
    _actualizarState(copia);
  }

  void modifyListaEmoji({required int idLista, required String emoji}){
    _state[idLista]!.modifyEmoji(emoji: emoji);
    _actualizarState(_state);
  }

  void modifyListaNombre({required int idLista, required String nombre}){
    _state[idLista]!.modifyNombre(nombre: nombre);
    _actualizarState(_state);
  }

  // ## Elementos

  void addElemento({required int idLista, required String nombre, required String emoji}){
    _state[idLista]!.addElemento(nombre: nombre, creador: ref.read(repositoryProvider).requireValue.usuario, emoji: emoji, idElemento: ref.read(repositoryProvider).requireValue.getIdElemento());
    _actualizarState(_state);
  }

  void toogleElementoTachado({required int idLista, required int idElemento}){
      _state[idLista]!.toggleElemento(id: idElemento);
    _actualizarState(_state);
  }

  void cambiarOrdenElementos({required int idLista, required int idElemento, required int nuevoOrden}){
    _state[idLista]!.cambiarOrdenElemento(idElemento: idElemento, nuevoOrden: nuevoOrden);
    _actualizarState(_state);
  }

  void eliminarElemento({required int idLista, required int idElemento}){
    _state[idLista]!.removeElemento(id: idElemento);
    _actualizarState(_state);
  }

  void modifyElementoNombre({required int idLista, required int idElemento, required String nombre}){
    _state[idLista]!.modifyElementoNombre(idElemento: idElemento, nombre: nombre);   
    _actualizarState(_state);
  }

  void modifyElementoEmoji({required int idLista, required int idElemento, required String emoji}){
    _state[idLista]!.modifyElementoEmoji(idElemento: idElemento, emoji: emoji);
    _actualizarState(_state);
  }
}
