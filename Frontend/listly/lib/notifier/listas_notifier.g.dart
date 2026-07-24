// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listas_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ListasNotifier)
final listasProvider = ListasNotifierProvider._();

final class ListasNotifierProvider
    extends $NotifierProvider<ListasNotifier, Map<int, Lista>> {
  ListasNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listasNotifierHash();

  @$internal
  @override
  ListasNotifier create() => ListasNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, Lista> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, Lista>>(value),
    );
  }
}

String _$listasNotifierHash() => r'eb468dd8f2a83ebf263bab9f67bc9c2a5cb27fef';

abstract class _$ListasNotifier extends $Notifier<Map<int, Lista>> {
  Map<int, Lista> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Map<int, Lista>, Map<int, Lista>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, Lista>, Map<int, Lista>>,
              Map<int, Lista>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
