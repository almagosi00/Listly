// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RepositoryNotifier)
final repositoryProvider = RepositoryNotifierProvider._();

final class RepositoryNotifierProvider
    extends $AsyncNotifierProvider<RepositoryNotifier, _AppState> {
  RepositoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'repositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$repositoryNotifierHash();

  @$internal
  @override
  RepositoryNotifier create() => RepositoryNotifier();
}

String _$repositoryNotifierHash() =>
    r'fec44367a5a038b9881f6d25b4e47eca2e832017';

abstract class _$RepositoryNotifier extends $AsyncNotifier<_AppState> {
  FutureOr<_AppState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<_AppState>, _AppState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<_AppState>, _AppState>,
              AsyncValue<_AppState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
