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
    extends $NotifierProvider<UsuarioNotifier, Usuario> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Usuario value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Usuario>(value),
    );
  }
}

String _$usuarioNotifierHash() => r'72ac1f44219d52d778fe81db6b644db9076131b5';

abstract class _$UsuarioNotifier extends $Notifier<Usuario> {
  Usuario build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Usuario, Usuario>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Usuario, Usuario>,
              Usuario,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
