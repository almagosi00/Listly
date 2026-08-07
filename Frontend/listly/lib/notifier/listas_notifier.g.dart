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
    extends $AsyncNotifierProvider<ListasNotifier, Map<int, Lista>> {
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
}

String _$listasNotifierHash() => r'e0e744750f606ace81396166bb677f61a74e4571';

abstract class _$ListasNotifier extends $AsyncNotifier<Map<int, Lista>> {
  FutureOr<Map<int, Lista>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Map<int, Lista>>, Map<int, Lista>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Map<int, Lista>>, Map<int, Lista>>,
              AsyncValue<Map<int, Lista>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
