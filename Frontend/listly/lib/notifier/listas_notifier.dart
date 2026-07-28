import 'package:listly/data/lista.dart';
import 'package:listly/mock_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'listas_notifier.g.dart';

@riverpod
class ListasNotifier extends _$ListasNotifier{

    @override
    Map<int,Lista> build() {
    final List<Lista> listas = mockData();
        return Map.unmodifiable({for (Lista l in listas) l.id: l});
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
