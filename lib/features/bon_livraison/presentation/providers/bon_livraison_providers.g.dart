// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bon_livraison_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bonLivraisonRemoteDataSourceHash() =>
    r'c2a8612ac616e47a060cd1ebf09737e8ade9b0eb';

/// See also [bonLivraisonRemoteDataSource].
@ProviderFor(bonLivraisonRemoteDataSource)
final bonLivraisonRemoteDataSourceProvider =
    AutoDisposeProvider<BonLivraisonRemoteDataSource>.internal(
      bonLivraisonRemoteDataSource,
      name: r'bonLivraisonRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bonLivraisonRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BonLivraisonRemoteDataSourceRef =
    AutoDisposeProviderRef<BonLivraisonRemoteDataSource>;
String _$bonLivraisonRepositoryHash() =>
    r'b2d41b3aafb4d31242f10a5725a619c5edeb7b8f';

/// See also [bonLivraisonRepository].
@ProviderFor(bonLivraisonRepository)
final bonLivraisonRepositoryProvider =
    AutoDisposeProvider<BonLivraisonRepository>.internal(
      bonLivraisonRepository,
      name: r'bonLivraisonRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bonLivraisonRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BonLivraisonRepositoryRef =
    AutoDisposeProviderRef<BonLivraisonRepository>;
String _$getBonLivraisonUseCaseHash() =>
    r'5fd2bacd40fae8f8884212c4b2230ca6749f2658';

/// See also [getBonLivraisonUseCase].
@ProviderFor(getBonLivraisonUseCase)
final getBonLivraisonUseCaseProvider =
    AutoDisposeProvider<GetBonLivraison>.internal(
      getBonLivraisonUseCase,
      name: r'getBonLivraisonUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getBonLivraisonUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetBonLivraisonUseCaseRef = AutoDisposeProviderRef<GetBonLivraison>;
String _$bonLivraisonHash() => r'333cf1da044ff2bcd461c3c4f404ee78c8997f34';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [bonLivraison].
@ProviderFor(bonLivraison)
const bonLivraisonProvider = BonLivraisonFamily();

/// See also [bonLivraison].
class BonLivraisonFamily
    extends Family<AsyncValue<Either<Failure, BonLivraisonEntity>>> {
  /// See also [bonLivraison].
  const BonLivraisonFamily();

  /// See also [bonLivraison].
  BonLivraisonProvider call(int orderId) {
    return BonLivraisonProvider(orderId);
  }

  @override
  BonLivraisonProvider getProviderOverride(
    covariant BonLivraisonProvider provider,
  ) {
    return call(provider.orderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bonLivraisonProvider';
}

/// See also [bonLivraison].
class BonLivraisonProvider
    extends AutoDisposeFutureProvider<Either<Failure, BonLivraisonEntity>> {
  /// See also [bonLivraison].
  BonLivraisonProvider(int orderId)
    : this._internal(
        (ref) => bonLivraison(ref as BonLivraisonRef, orderId),
        from: bonLivraisonProvider,
        name: r'bonLivraisonProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$bonLivraisonHash,
        dependencies: BonLivraisonFamily._dependencies,
        allTransitiveDependencies:
            BonLivraisonFamily._allTransitiveDependencies,
        orderId: orderId,
      );

  BonLivraisonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final int orderId;

  @override
  Override overrideWith(
    FutureOr<Either<Failure, BonLivraisonEntity>> Function(
      BonLivraisonRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BonLivraisonProvider._internal(
        (ref) => create(ref as BonLivraisonRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<Failure, BonLivraisonEntity>>
  createElement() {
    return _BonLivraisonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BonLivraisonProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BonLivraisonRef
    on AutoDisposeFutureProviderRef<Either<Failure, BonLivraisonEntity>> {
  /// The parameter `orderId` of this provider.
  int get orderId;
}

class _BonLivraisonProviderElement
    extends
        AutoDisposeFutureProviderElement<Either<Failure, BonLivraisonEntity>>
    with BonLivraisonRef {
  _BonLivraisonProviderElement(super.provider);

  @override
  int get orderId => (origin as BonLivraisonProvider).orderId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
