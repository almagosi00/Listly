import 'package:listly/data/lista.dart';
import 'package:listly/data/usuario.dart';
import 'package:listly/notifier/repository.dart';
import 'package:listly/notifier/usuario_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'listas_notifier.g.dart';

@riverpod
class ListasNotifier extends _$ListasNotifier{

    @override
    Map<int,Lista> build() {
      return Map.unmodifiable(ref.read(repositoryProvider).listas);
    }

    // ## Listas

    void addLista({required String nombre, required String emoji}){
      int idLista = ref.read(repositoryProvider).getIdLista();
      state = Map.unmodifiable({...state, idLista: Lista(
        id: idLista,
        nombre: nombre, 
        emoji: emoji, 
        usuarioPropietario: ref.read(usuarioProvider)
        )});
    }

    void eliminarLista({required int idLista}){
      Map<int, Lista> copia = Map<int, Lista>.of(state);
      copia.remove(idLista);
      state = Map.unmodifiable(copia);
    }

    void modifyListaEmoji({required int idLista, required String emoji}){
      state[idLista]!.modifyEmoji(emoji: emoji);
      state = Map.unmodifiable({...state});
    }

    void modifyListaNombre({required int idLista, required String nombre}){
      state[idLista]!.modifyNombre(nombre: nombre);
      state = Map.unmodifiable({...state});
    }

    // ## Elementos

    void addElemento({required int idLista, required Usuario usuarioCreador, required String nombre, required String? emoji}){
      state[idLista]!.addElemento(nombre: nombre, creador: usuarioCreador, emoji: emoji, idElemento: ref.read(repositoryProvider).getIdElemento());
      state = Map.unmodifiable({...state});
    }

    void toogleElementoTachado({required int idLista, required idElemento}){
        state[idLista]!.toggleElemento(id: idElemento);
        state = Map.unmodifiable({...state});
    }

    void cambiarOrdenElementos({required int idLista, required int idElemento, required int nuevoOrden}){
      state[idLista]!.cambiarOrdenElemento(idElemento: idElemento, nuevoOrden: nuevoOrden);
      state = Map.unmodifiable({...state});
    }

    void eliminarElemento({required int idLista, required int idElemento}){
      state[idLista]!.removeElemento(id: idElemento);
      state = Map.unmodifiable({...state});
    }

    void modifyElementoNombre({required int idLista, required int idElemento, required String nombre}){
      state[idLista]!.modifyElementoNombre(idElemento: idElemento, nombre: nombre);      
      state = Map.unmodifiable({...state});
    }

    void modifyElementoEmoji({required int idLista, required int idElemento, required String emoji}){
      state[idLista]!.modifyElementoEmoji(idElemento: idElemento, emoji: emoji);      
      state = Map.unmodifiable({...state});
    }
}
