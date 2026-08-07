// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UsuarioNotifier)
final usuarioProvider = UsuarioNotifierProvider._();

final class UsuarioNotifierProvider
    extends $AsyncNotifierProvider<UsuarioNotifier, Usuario> {
  UsuarioNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usuarioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usuarioNotifierHash();

  @$internal
  @override
  UsuarioNotifier create() => UsuarioNotifier();
}

String _$usuarioNotifierHash() => r'fdb9d8d419d8db3bde6263a006c05ea10b48d23d';

abstract class _$UsuarioNotifier extends $AsyncNotifier<Usuario> {
  FutureOr<Usuario> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Usuario>, Usuario>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Usuario>, Usuario>,
              AsyncValue<Usuario>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
