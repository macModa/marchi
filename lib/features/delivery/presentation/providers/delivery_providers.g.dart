// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deliveryRemoteDataSourceHash() =>
    r'36ef3b95e97cd82d56bc6ac24835c68036f322a5';

/// See also [deliveryRemoteDataSource].
@ProviderFor(deliveryRemoteDataSource)
final deliveryRemoteDataSourceProvider =
    AutoDisposeProvider<DeliveryRemoteDataSource>.internal(
      deliveryRemoteDataSource,
      name: r'deliveryRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deliveryRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeliveryRemoteDataSourceRef =
    AutoDisposeProviderRef<DeliveryRemoteDataSource>;
String _$deliveryRepositoryHash() =>
    r'f263ac2d30056b0e0eaa59118e96085b437b5550';

/// See also [deliveryRepository].
@ProviderFor(deliveryRepository)
final deliveryRepositoryProvider =
    AutoDisposeProvider<DeliveryRepository>.internal(
      deliveryRepository,
      name: r'deliveryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deliveryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeliveryRepositoryRef = AutoDisposeProviderRef<DeliveryRepository>;
String _$getParcelByTrackingUseCaseHash() =>
    r'fd7533bf5c8d17347e4ca1ffa9e8ae37c32b2079';

/// See also [getParcelByTrackingUseCase].
@ProviderFor(getParcelByTrackingUseCase)
final getParcelByTrackingUseCaseProvider =
    AutoDisposeProvider<GetParcelByTracking>.internal(
      getParcelByTrackingUseCase,
      name: r'getParcelByTrackingUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getParcelByTrackingUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetParcelByTrackingUseCaseRef =
    AutoDisposeProviderRef<GetParcelByTracking>;
String _$getRelaysByPostalCodeUseCaseHash() =>
    r'4d65a5f04deda613d798faf723104e8fc0ad9c16';

/// See also [getRelaysByPostalCodeUseCase].
@ProviderFor(getRelaysByPostalCodeUseCase)
final getRelaysByPostalCodeUseCaseProvider =
    AutoDisposeProvider<GetRelaysByPostalCode>.internal(
      getRelaysByPostalCodeUseCase,
      name: r'getRelaysByPostalCodeUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getRelaysByPostalCodeUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRelaysByPostalCodeUseCaseRef =
    AutoDisposeProviderRef<GetRelaysByPostalCode>;
String _$getTrackingTimelineUseCaseHash() =>
    r'ee1bd633e934aed3d68b8418252957d4246d4b92';

/// See also [getTrackingTimelineUseCase].
@ProviderFor(getTrackingTimelineUseCase)
final getTrackingTimelineUseCaseProvider =
    AutoDisposeProvider<GetTrackingTimeline>.internal(
      getTrackingTimelineUseCase,
      name: r'getTrackingTimelineUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getTrackingTimelineUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTrackingTimelineUseCaseRef =
    AutoDisposeProviderRef<GetTrackingTimeline>;
String _$parcelByTrackingHash() => r'89c32c6f1d17bddfedb39117e33d29399f20bc32';

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

/// See also [parcelByTracking].
@ProviderFor(parcelByTracking)
const parcelByTrackingProvider = ParcelByTrackingFamily();

/// See also [parcelByTracking].
class ParcelByTrackingFamily
    extends Family<AsyncValue<Either<Failure, Parcel>>> {
  /// See also [parcelByTracking].
  const ParcelByTrackingFamily();

  /// See also [parcelByTracking].
  ParcelByTrackingProvider call(String trackingNumber) {
    return ParcelByTrackingProvider(trackingNumber);
  }

  @override
  ParcelByTrackingProvider getProviderOverride(
    covariant ParcelByTrackingProvider provider,
  ) {
    return call(provider.trackingNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'parcelByTrackingProvider';
}

/// See also [parcelByTracking].
class ParcelByTrackingProvider
    extends AutoDisposeFutureProvider<Either<Failure, Parcel>> {
  /// See also [parcelByTracking].
  ParcelByTrackingProvider(String trackingNumber)
    : this._internal(
        (ref) => parcelByTracking(ref as ParcelByTrackingRef, trackingNumber),
        from: parcelByTrackingProvider,
        name: r'parcelByTrackingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$parcelByTrackingHash,
        dependencies: ParcelByTrackingFamily._dependencies,
        allTransitiveDependencies:
            ParcelByTrackingFamily._allTransitiveDependencies,
        trackingNumber: trackingNumber,
      );

  ParcelByTrackingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.trackingNumber,
  }) : super.internal();

  final String trackingNumber;

  @override
  Override overrideWith(
    FutureOr<Either<Failure, Parcel>> Function(ParcelByTrackingRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ParcelByTrackingProvider._internal(
        (ref) => create(ref as ParcelByTrackingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        trackingNumber: trackingNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<Failure, Parcel>> createElement() {
    return _ParcelByTrackingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ParcelByTrackingProvider &&
        other.trackingNumber == trackingNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trackingNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ParcelByTrackingRef
    on AutoDisposeFutureProviderRef<Either<Failure, Parcel>> {
  /// The parameter `trackingNumber` of this provider.
  String get trackingNumber;
}

class _ParcelByTrackingProviderElement
    extends AutoDisposeFutureProviderElement<Either<Failure, Parcel>>
    with ParcelByTrackingRef {
  _ParcelByTrackingProviderElement(super.provider);

  @override
  String get trackingNumber =>
      (origin as ParcelByTrackingProvider).trackingNumber;
}

String _$relaysByPostalCodeHash() =>
    r'd9f1647bb1a53b2cb87f284829b04aaf7e11dfb6';

/// See also [relaysByPostalCode].
@ProviderFor(relaysByPostalCode)
const relaysByPostalCodeProvider = RelaysByPostalCodeFamily();

/// See also [relaysByPostalCode].
class RelaysByPostalCodeFamily
    extends Family<AsyncValue<Either<Failure, List<RelayPoint>>>> {
  /// See also [relaysByPostalCode].
  const RelaysByPostalCodeFamily();

  /// See also [relaysByPostalCode].
  RelaysByPostalCodeProvider call(String postalCode) {
    return RelaysByPostalCodeProvider(postalCode);
  }

  @override
  RelaysByPostalCodeProvider getProviderOverride(
    covariant RelaysByPostalCodeProvider provider,
  ) {
    return call(provider.postalCode);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'relaysByPostalCodeProvider';
}

/// See also [relaysByPostalCode].
class RelaysByPostalCodeProvider
    extends AutoDisposeFutureProvider<Either<Failure, List<RelayPoint>>> {
  /// See also [relaysByPostalCode].
  RelaysByPostalCodeProvider(String postalCode)
    : this._internal(
        (ref) => relaysByPostalCode(ref as RelaysByPostalCodeRef, postalCode),
        from: relaysByPostalCodeProvider,
        name: r'relaysByPostalCodeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$relaysByPostalCodeHash,
        dependencies: RelaysByPostalCodeFamily._dependencies,
        allTransitiveDependencies:
            RelaysByPostalCodeFamily._allTransitiveDependencies,
        postalCode: postalCode,
      );

  RelaysByPostalCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postalCode,
  }) : super.internal();

  final String postalCode;

  @override
  Override overrideWith(
    FutureOr<Either<Failure, List<RelayPoint>>> Function(
      RelaysByPostalCodeRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RelaysByPostalCodeProvider._internal(
        (ref) => create(ref as RelaysByPostalCodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postalCode: postalCode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<Failure, List<RelayPoint>>>
  createElement() {
    return _RelaysByPostalCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RelaysByPostalCodeProvider &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postalCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RelaysByPostalCodeRef
    on AutoDisposeFutureProviderRef<Either<Failure, List<RelayPoint>>> {
  /// The parameter `postalCode` of this provider.
  String get postalCode;
}

class _RelaysByPostalCodeProviderElement
    extends AutoDisposeFutureProviderElement<Either<Failure, List<RelayPoint>>>
    with RelaysByPostalCodeRef {
  _RelaysByPostalCodeProviderElement(super.provider);

  @override
  String get postalCode => (origin as RelaysByPostalCodeProvider).postalCode;
}

String _$trackingTimelineHash() => r'20cd180045617356a55c009d4a911a487e8a265b';

/// See also [trackingTimeline].
@ProviderFor(trackingTimeline)
const trackingTimelineProvider = TrackingTimelineFamily();

/// See also [trackingTimeline].
class TrackingTimelineFamily
    extends Family<AsyncValue<Either<Failure, List<TrackingEvent>>>> {
  /// See also [trackingTimeline].
  const TrackingTimelineFamily();

  /// See also [trackingTimeline].
  TrackingTimelineProvider call(String trackingNumber) {
    return TrackingTimelineProvider(trackingNumber);
  }

  @override
  TrackingTimelineProvider getProviderOverride(
    covariant TrackingTimelineProvider provider,
  ) {
    return call(provider.trackingNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'trackingTimelineProvider';
}

/// See also [trackingTimeline].
class TrackingTimelineProvider
    extends AutoDisposeFutureProvider<Either<Failure, List<TrackingEvent>>> {
  /// See also [trackingTimeline].
  TrackingTimelineProvider(String trackingNumber)
    : this._internal(
        (ref) => trackingTimeline(ref as TrackingTimelineRef, trackingNumber),
        from: trackingTimelineProvider,
        name: r'trackingTimelineProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$trackingTimelineHash,
        dependencies: TrackingTimelineFamily._dependencies,
        allTransitiveDependencies:
            TrackingTimelineFamily._allTransitiveDependencies,
        trackingNumber: trackingNumber,
      );

  TrackingTimelineProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.trackingNumber,
  }) : super.internal();

  final String trackingNumber;

  @override
  Override overrideWith(
    FutureOr<Either<Failure, List<TrackingEvent>>> Function(
      TrackingTimelineRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TrackingTimelineProvider._internal(
        (ref) => create(ref as TrackingTimelineRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        trackingNumber: trackingNumber,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<Failure, List<TrackingEvent>>>
  createElement() {
    return _TrackingTimelineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackingTimelineProvider &&
        other.trackingNumber == trackingNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trackingNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TrackingTimelineRef
    on AutoDisposeFutureProviderRef<Either<Failure, List<TrackingEvent>>> {
  /// The parameter `trackingNumber` of this provider.
  String get trackingNumber;
}

class _TrackingTimelineProviderElement
    extends
        AutoDisposeFutureProviderElement<Either<Failure, List<TrackingEvent>>>
    with TrackingTimelineRef {
  _TrackingTimelineProviderElement(super.provider);

  @override
  String get trackingNumber =>
      (origin as TrackingTimelineProvider).trackingNumber;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
