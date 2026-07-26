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
}
