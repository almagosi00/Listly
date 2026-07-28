import 'package:listly/data/usuario.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usuario_notifier.g.dart';

@riverpod
class UsuarioNotifier extends _$UsuarioNotifier{

  @override
  Usuario build() {
    return Usuario();
  }

}