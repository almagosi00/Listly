import 'package:listly/data/usuario.dart';
import 'package:listly/notifier/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usuario_notifier.g.dart';

@riverpod
class UsuarioNotifier extends _$UsuarioNotifier{

  @override
  Future<Usuario> build() async {
    final repo = await ref.watch(repositoryProvider.future);
    return repo.usuario;
  }

}