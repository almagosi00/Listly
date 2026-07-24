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

    void toogleElementoTachado(int idLista, int idElemento){
        state[idLista]!.toggleElemento(id: idElemento);
        state = Map.unmodifiable({...state});
    }
}
