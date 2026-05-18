// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bon_livraison_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BonLivraisonModel _$BonLivraisonModelFromJson(Map<String, dynamic> json) {
  return _BonLivraisonModel.fromJson(json);
}

/// @nodoc
mixin _$BonLivraisonModel {
  int get orderId => throw _privateConstructorUsedError;
  String get numeroSuivi => throw _privateConstructorUsedError;
  @JsonKey(name: 'exp\u00e9diteur')
  ExpediteurModel get expediteur => throw _privateConstructorUsedError;
  DestinataireModel get destinataire => throw _privateConstructorUsedError;
  List<ProduitModel> get produits => throw _privateConstructorUsedError;
  double get poidsTotal => throw _privateConstructorUsedError;
  double get montantCOD => throw _privateConstructorUsedError;
  String get montantEnLettres => throw _privateConstructorUsedError;
  String get dateCreation => throw _privateConstructorUsedError;
  String get statut => throw _privateConstructorUsedError;
  String get modeReglement => throw _privateConstructorUsedError;

  /// Serializes this BonLivraisonModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BonLivraisonModelCopyWith<BonLivraisonModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BonLivraisonModelCopyWith<$Res> {
  factory $BonLivraisonModelCopyWith(
    BonLivraisonModel value,
    $Res Function(BonLivraisonModel) then,
  ) = _$BonLivraisonModelCopyWithImpl<$Res, BonLivraisonModel>;
  @useResult
  $Res call({
    int orderId,
    String numeroSuivi,
    @JsonKey(name: 'exp\u00e9diteur') ExpediteurModel expediteur,
    DestinataireModel destinataire,
    List<ProduitModel> produits,
    double poidsTotal,
    double montantCOD,
    String montantEnLettres,
    String dateCreation,
    String statut,
    String modeReglement,
  });

  $ExpediteurModelCopyWith<$Res> get expediteur;
  $DestinataireModelCopyWith<$Res> get destinataire;
}

/// @nodoc
class _$BonLivraisonModelCopyWithImpl<$Res, $Val extends BonLivraisonModel>
    implements $BonLivraisonModelCopyWith<$Res> {
  _$BonLivraisonModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? numeroSuivi = null,
    Object? expediteur = null,
    Object? destinataire = null,
    Object? produits = null,
    Object? poidsTotal = null,
    Object? montantCOD = null,
    Object? montantEnLettres = null,
    Object? dateCreation = null,
    Object? statut = null,
    Object? modeReglement = null,
  }) {
    return _then(
      _value.copyWith(
            orderId: null == orderId
                ? _value.orderId
                : orderId // ignore: cast_nullable_to_non_nullable
                      as int,
            numeroSuivi: null == numeroSuivi
                ? _value.numeroSuivi
                : numeroSuivi // ignore: cast_nullable_to_non_nullable
                      as String,
            expediteur: null == expediteur
                ? _value.expediteur
                : expediteur // ignore: cast_nullable_to_non_nullable
                      as ExpediteurModel,
            destinataire: null == destinataire
                ? _value.destinataire
                : destinataire // ignore: cast_nullable_to_non_nullable
                      as DestinataireModel,
            produits: null == produits
                ? _value.produits
                : produits // ignore: cast_nullable_to_non_nullable
                      as List<ProduitModel>,
            poidsTotal: null == poidsTotal
                ? _value.poidsTotal
                : poidsTotal // ignore: cast_nullable_to_non_nullable
                      as double,
            montantCOD: null == montantCOD
                ? _value.montantCOD
                : montantCOD // ignore: cast_nullable_to_non_nullable
                      as double,
            montantEnLettres: null == montantEnLettres
                ? _value.montantEnLettres
                : montantEnLettres // ignore: cast_nullable_to_non_nullable
                      as String,
            dateCreation: null == dateCreation
                ? _value.dateCreation
                : dateCreation // ignore: cast_nullable_to_non_nullable
                      as String,
            statut: null == statut
                ? _value.statut
                : statut // ignore: cast_nullable_to_non_nullable
                      as String,
            modeReglement: null == modeReglement
                ? _value.modeReglement
                : modeReglement // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpediteurModelCopyWith<$Res> get expediteur {
    return $ExpediteurModelCopyWith<$Res>(_value.expediteur, (value) {
      return _then(_value.copyWith(expediteur: value) as $Val);
    });
  }

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DestinataireModelCopyWith<$Res> get destinataire {
    return $DestinataireModelCopyWith<$Res>(_value.destinataire, (value) {
      return _then(_value.copyWith(destinataire: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BonLivraisonModelImplCopyWith<$Res>
    implements $BonLivraisonModelCopyWith<$Res> {
  factory _$$BonLivraisonModelImplCopyWith(
    _$BonLivraisonModelImpl value,
    $Res Function(_$BonLivraisonModelImpl) then,
  ) = __$$BonLivraisonModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int orderId,
    String numeroSuivi,
    @JsonKey(name: 'exp\u00e9diteur') ExpediteurModel expediteur,
    DestinataireModel destinataire,
    List<ProduitModel> produits,
    double poidsTotal,
    double montantCOD,
    String montantEnLettres,
    String dateCreation,
    String statut,
    String modeReglement,
  });

  @override
  $ExpediteurModelCopyWith<$Res> get expediteur;
  @override
  $DestinataireModelCopyWith<$Res> get destinataire;
}

/// @nodoc
class __$$BonLivraisonModelImplCopyWithImpl<$Res>
    extends _$BonLivraisonModelCopyWithImpl<$Res, _$BonLivraisonModelImpl>
    implements _$$BonLivraisonModelImplCopyWith<$Res> {
  __$$BonLivraisonModelImplCopyWithImpl(
    _$BonLivraisonModelImpl _value,
    $Res Function(_$BonLivraisonModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? numeroSuivi = null,
    Object? expediteur = null,
    Object? destinataire = null,
    Object? produits = null,
    Object? poidsTotal = null,
    Object? montantCOD = null,
    Object? montantEnLettres = null,
    Object? dateCreation = null,
    Object? statut = null,
    Object? modeReglement = null,
  }) {
    return _then(
      _$BonLivraisonModelImpl(
        orderId: null == orderId
            ? _value.orderId
            : orderId // ignore: cast_nullable_to_non_nullable
                  as int,
        numeroSuivi: null == numeroSuivi
            ? _value.numeroSuivi
            : numeroSuivi // ignore: cast_nullable_to_non_nullable
                  as String,
        expediteur: null == expediteur
            ? _value.expediteur
            : expediteur // ignore: cast_nullable_to_non_nullable
                  as ExpediteurModel,
        destinataire: null == destinataire
            ? _value.destinataire
            : destinataire // ignore: cast_nullable_to_non_nullable
                  as DestinataireModel,
        produits: null == produits
            ? _value._produits
            : produits // ignore: cast_nullable_to_non_nullable
                  as List<ProduitModel>,
        poidsTotal: null == poidsTotal
            ? _value.poidsTotal
            : poidsTotal // ignore: cast_nullable_to_non_nullable
                  as double,
        montantCOD: null == montantCOD
            ? _value.montantCOD
            : montantCOD // ignore: cast_nullable_to_non_nullable
                  as double,
        montantEnLettres: null == montantEnLettres
            ? _value.montantEnLettres
            : montantEnLettres // ignore: cast_nullable_to_non_nullable
                  as String,
        dateCreation: null == dateCreation
            ? _value.dateCreation
            : dateCreation // ignore: cast_nullable_to_non_nullable
                  as String,
        statut: null == statut
            ? _value.statut
            : statut // ignore: cast_nullable_to_non_nullable
                  as String,
        modeReglement: null == modeReglement
            ? _value.modeReglement
            : modeReglement // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BonLivraisonModelImpl extends _BonLivraisonModel {
  const _$BonLivraisonModelImpl({
    required this.orderId,
    required this.numeroSuivi,
    @JsonKey(name: 'exp\u00e9diteur') required this.expediteur,
    required this.destinataire,
    required final List<ProduitModel> produits,
    required this.poidsTotal,
    required this.montantCOD,
    required this.montantEnLettres,
    required this.dateCreation,
    required this.statut,
    required this.modeReglement,
  }) : _produits = produits,
       super._();

  factory _$BonLivraisonModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BonLivraisonModelImplFromJson(json);

  @override
  final int orderId;
  @override
  final String numeroSuivi;
  @override
  @JsonKey(name: 'exp\u00e9diteur')
  final ExpediteurModel expediteur;
  @override
  final DestinataireModel destinataire;
  final List<ProduitModel> _produits;
  @override
  List<ProduitModel> get produits {
    if (_produits is EqualUnmodifiableListView) return _produits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produits);
  }

  @override
  final double poidsTotal;
  @override
  final double montantCOD;
  @override
  final String montantEnLettres;
  @override
  final String dateCreation;
  @override
  final String statut;
  @override
  final String modeReglement;

  @override
  String toString() {
    return 'BonLivraisonModel(orderId: $orderId, numeroSuivi: $numeroSuivi, expediteur: $expediteur, destinataire: $destinataire, produits: $produits, poidsTotal: $poidsTotal, montantCOD: $montantCOD, montantEnLettres: $montantEnLettres, dateCreation: $dateCreation, statut: $statut, modeReglement: $modeReglement)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BonLivraisonModelImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.numeroSuivi, numeroSuivi) ||
                other.numeroSuivi == numeroSuivi) &&
            (identical(other.expediteur, expediteur) ||
                other.expediteur == expediteur) &&
            (identical(other.destinataire, destinataire) ||
                other.destinataire == destinataire) &&
            const DeepCollectionEquality().equals(other._produits, _produits) &&
            (identical(other.poidsTotal, poidsTotal) ||
                other.poidsTotal == poidsTotal) &&
            (identical(other.montantCOD, montantCOD) ||
                other.montantCOD == montantCOD) &&
            (identical(other.montantEnLettres, montantEnLettres) ||
                other.montantEnLettres == montantEnLettres) &&
            (identical(other.dateCreation, dateCreation) ||
                other.dateCreation == dateCreation) &&
            (identical(other.statut, statut) || other.statut == statut) &&
            (identical(other.modeReglement, modeReglement) ||
                other.modeReglement == modeReglement));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    orderId,
    numeroSuivi,
    expediteur,
    destinataire,
    const DeepCollectionEquality().hash(_produits),
    poidsTotal,
    montantCOD,
    montantEnLettres,
    dateCreation,
    statut,
    modeReglement,
  );

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BonLivraisonModelImplCopyWith<_$BonLivraisonModelImpl> get copyWith =>
      __$$BonLivraisonModelImplCopyWithImpl<_$BonLivraisonModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BonLivraisonModelImplToJson(this);
  }
}

abstract class _BonLivraisonModel extends BonLivraisonModel {
  const factory _BonLivraisonModel({
    required final int orderId,
    required final String numeroSuivi,
    @JsonKey(name: 'exp\u00e9diteur') required final ExpediteurModel expediteur,
    required final DestinataireModel destinataire,
    required final List<ProduitModel> produits,
    required final double poidsTotal,
    required final double montantCOD,
    required final String montantEnLettres,
    required final String dateCreation,
    required final String statut,
    required final String modeReglement,
  }) = _$BonLivraisonModelImpl;
  const _BonLivraisonModel._() : super._();

  factory _BonLivraisonModel.fromJson(Map<String, dynamic> json) =
      _$BonLivraisonModelImpl.fromJson;

  @override
  int get orderId;
  @override
  String get numeroSuivi;
  @override
  @JsonKey(name: 'exp\u00e9diteur')
  ExpediteurModel get expediteur;
  @override
  DestinataireModel get destinataire;
  @override
  List<ProduitModel> get produits;
  @override
  double get poidsTotal;
  @override
  double get montantCOD;
  @override
  String get montantEnLettres;
  @override
  String get dateCreation;
  @override
  String get statut;
  @override
  String get modeReglement;

  /// Create a copy of BonLivraisonModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BonLivraisonModelImplCopyWith<_$BonLivraisonModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExpediteurModel _$ExpediteurModelFromJson(Map<String, dynamic> json) {
  return _ExpediteurModel.fromJson(json);
}

/// @nodoc
mixin _$ExpediteurModel {
  String get nom => throw _privateConstructorUsedError;
  String get nomBoutique => throw _privateConstructorUsedError;
  String get ville => throw _privateConstructorUsedError;
  String get telephone => throw _privateConstructorUsedError;

  /// Serializes this ExpediteurModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpediteurModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpediteurModelCopyWith<ExpediteurModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpediteurModelCopyWith<$Res> {
  factory $ExpediteurModelCopyWith(
    ExpediteurModel value,
    $Res Function(ExpediteurModel) then,
  ) = _$ExpediteurModelCopyWithImpl<$Res, ExpediteurModel>;
  @useResult
  $Res call({String nom, String nomBoutique, String ville, String telephone});
}

/// @nodoc
class _$ExpediteurModelCopyWithImpl<$Res, $Val extends ExpediteurModel>
    implements $ExpediteurModelCopyWith<$Res> {
  _$ExpediteurModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpediteurModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? nomBoutique = null,
    Object? ville = null,
    Object? telephone = null,
  }) {
    return _then(
      _value.copyWith(
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            nomBoutique: null == nomBoutique
                ? _value.nomBoutique
                : nomBoutique // ignore: cast_nullable_to_non_nullable
                      as String,
            ville: null == ville
                ? _value.ville
                : ville // ignore: cast_nullable_to_non_nullable
                      as String,
            telephone: null == telephone
                ? _value.telephone
                : telephone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExpediteurModelImplCopyWith<$Res>
    implements $ExpediteurModelCopyWith<$Res> {
  factory _$$ExpediteurModelImplCopyWith(
    _$ExpediteurModelImpl value,
    $Res Function(_$ExpediteurModelImpl) then,
  ) = __$$ExpediteurModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nom, String nomBoutique, String ville, String telephone});
}

/// @nodoc
class __$$ExpediteurModelImplCopyWithImpl<$Res>
    extends _$ExpediteurModelCopyWithImpl<$Res, _$ExpediteurModelImpl>
    implements _$$ExpediteurModelImplCopyWith<$Res> {
  __$$ExpediteurModelImplCopyWithImpl(
    _$ExpediteurModelImpl _value,
    $Res Function(_$ExpediteurModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpediteurModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? nomBoutique = null,
    Object? ville = null,
    Object? telephone = null,
  }) {
    return _then(
      _$ExpediteurModelImpl(
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        nomBoutique: null == nomBoutique
            ? _value.nomBoutique
            : nomBoutique // ignore: cast_nullable_to_non_nullable
                  as String,
        ville: null == ville
            ? _value.ville
            : ville // ignore: cast_nullable_to_non_nullable
                  as String,
        telephone: null == telephone
            ? _value.telephone
            : telephone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpediteurModelImpl extends _ExpediteurModel {
  const _$ExpediteurModelImpl({
    required this.nom,
    required this.nomBoutique,
    required this.ville,
    required this.telephone,
  }) : super._();

  factory _$ExpediteurModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpediteurModelImplFromJson(json);

  @override
  final String nom;
  @override
  final String nomBoutique;
  @override
  final String ville;
  @override
  final String telephone;

  @override
  String toString() {
    return 'ExpediteurModel(nom: $nom, nomBoutique: $nomBoutique, ville: $ville, telephone: $telephone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpediteurModelImpl &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.nomBoutique, nomBoutique) ||
                other.nomBoutique == nomBoutique) &&
            (identical(other.ville, ville) || other.ville == ville) &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nom, nomBoutique, ville, telephone);

  /// Create a copy of ExpediteurModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpediteurModelImplCopyWith<_$ExpediteurModelImpl> get copyWith =>
      __$$ExpediteurModelImplCopyWithImpl<_$ExpediteurModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpediteurModelImplToJson(this);
  }
}

abstract class _ExpediteurModel extends ExpediteurModel {
  const factory _ExpediteurModel({
    required final String nom,
    required final String nomBoutique,
    required final String ville,
    required final String telephone,
  }) = _$ExpediteurModelImpl;
  const _ExpediteurModel._() : super._();

  factory _ExpediteurModel.fromJson(Map<String, dynamic> json) =
      _$ExpediteurModelImpl.fromJson;

  @override
  String get nom;
  @override
  String get nomBoutique;
  @override
  String get ville;
  @override
  String get telephone;

  /// Create a copy of ExpediteurModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpediteurModelImplCopyWith<_$ExpediteurModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DestinataireModel _$DestinataireModelFromJson(Map<String, dynamic> json) {
  return _DestinataireModel.fromJson(json);
}

/// @nodoc
mixin _$DestinataireModel {
  String get nom => throw _privateConstructorUsedError;
  String get adresseLivraison => throw _privateConstructorUsedError;
  String get codePostal => throw _privateConstructorUsedError;
  String get telephone => throw _privateConstructorUsedError;

  /// Serializes this DestinataireModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DestinataireModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DestinataireModelCopyWith<DestinataireModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DestinataireModelCopyWith<$Res> {
  factory $DestinataireModelCopyWith(
    DestinataireModel value,
    $Res Function(DestinataireModel) then,
  ) = _$DestinataireModelCopyWithImpl<$Res, DestinataireModel>;
  @useResult
  $Res call({
    String nom,
    String adresseLivraison,
    String codePostal,
    String telephone,
  });
}

/// @nodoc
class _$DestinataireModelCopyWithImpl<$Res, $Val extends DestinataireModel>
    implements $DestinataireModelCopyWith<$Res> {
  _$DestinataireModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DestinataireModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? adresseLivraison = null,
    Object? codePostal = null,
    Object? telephone = null,
  }) {
    return _then(
      _value.copyWith(
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            adresseLivraison: null == adresseLivraison
                ? _value.adresseLivraison
                : adresseLivraison // ignore: cast_nullable_to_non_nullable
                      as String,
            codePostal: null == codePostal
                ? _value.codePostal
                : codePostal // ignore: cast_nullable_to_non_nullable
                      as String,
            telephone: null == telephone
                ? _value.telephone
                : telephone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DestinataireModelImplCopyWith<$Res>
    implements $DestinataireModelCopyWith<$Res> {
  factory _$$DestinataireModelImplCopyWith(
    _$DestinataireModelImpl value,
    $Res Function(_$DestinataireModelImpl) then,
  ) = __$$DestinataireModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String nom,
    String adresseLivraison,
    String codePostal,
    String telephone,
  });
}

/// @nodoc
class __$$DestinataireModelImplCopyWithImpl<$Res>
    extends _$DestinataireModelCopyWithImpl<$Res, _$DestinataireModelImpl>
    implements _$$DestinataireModelImplCopyWith<$Res> {
  __$$DestinataireModelImplCopyWithImpl(
    _$DestinataireModelImpl _value,
    $Res Function(_$DestinataireModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DestinataireModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? adresseLivraison = null,
    Object? codePostal = null,
    Object? telephone = null,
  }) {
    return _then(
      _$DestinataireModelImpl(
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        adresseLivraison: null == adresseLivraison
            ? _value.adresseLivraison
            : adresseLivraison // ignore: cast_nullable_to_non_nullable
                  as String,
        codePostal: null == codePostal
            ? _value.codePostal
            : codePostal // ignore: cast_nullable_to_non_nullable
                  as String,
        telephone: null == telephone
            ? _value.telephone
            : telephone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DestinataireModelImpl extends _DestinataireModel {
  const _$DestinataireModelImpl({
    required this.nom,
    required this.adresseLivraison,
    required this.codePostal,
    required this.telephone,
  }) : super._();

  factory _$DestinataireModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DestinataireModelImplFromJson(json);

  @override
  final String nom;
  @override
  final String adresseLivraison;
  @override
  final String codePostal;
  @override
  final String telephone;

  @override
  String toString() {
    return 'DestinataireModel(nom: $nom, adresseLivraison: $adresseLivraison, codePostal: $codePostal, telephone: $telephone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DestinataireModelImpl &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.adresseLivraison, adresseLivraison) ||
                other.adresseLivraison == adresseLivraison) &&
            (identical(other.codePostal, codePostal) ||
                other.codePostal == codePostal) &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nom, adresseLivraison, codePostal, telephone);

  /// Create a copy of DestinataireModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DestinataireModelImplCopyWith<_$DestinataireModelImpl> get copyWith =>
      __$$DestinataireModelImplCopyWithImpl<_$DestinataireModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DestinataireModelImplToJson(this);
  }
}

abstract class _DestinataireModel extends DestinataireModel {
  const factory _DestinataireModel({
    required final String nom,
    required final String adresseLivraison,
    required final String codePostal,
    required final String telephone,
  }) = _$DestinataireModelImpl;
  const _DestinataireModel._() : super._();

  factory _DestinataireModel.fromJson(Map<String, dynamic> json) =
      _$DestinataireModelImpl.fromJson;

  @override
  String get nom;
  @override
  String get adresseLivraison;
  @override
  String get codePostal;
  @override
  String get telephone;

  /// Create a copy of DestinataireModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DestinataireModelImplCopyWith<_$DestinataireModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProduitModel _$ProduitModelFromJson(Map<String, dynamic> json) {
  return _ProduitModel.fromJson(json);
}

/// @nodoc
mixin _$ProduitModel {
  String get nom => throw _privateConstructorUsedError;
  int get quantite => throw _privateConstructorUsedError;
  double get prixUnitaire => throw _privateConstructorUsedError;
  double get poidsUnitaire => throw _privateConstructorUsedError;
  double get sousTotal => throw _privateConstructorUsedError;

  /// Serializes this ProduitModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProduitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProduitModelCopyWith<ProduitModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProduitModelCopyWith<$Res> {
  factory $ProduitModelCopyWith(
    ProduitModel value,
    $Res Function(ProduitModel) then,
  ) = _$ProduitModelCopyWithImpl<$Res, ProduitModel>;
  @useResult
  $Res call({
    String nom,
    int quantite,
    double prixUnitaire,
    double poidsUnitaire,
    double sousTotal,
  });
}

/// @nodoc
class _$ProduitModelCopyWithImpl<$Res, $Val extends ProduitModel>
    implements $ProduitModelCopyWith<$Res> {
  _$ProduitModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProduitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? quantite = null,
    Object? prixUnitaire = null,
    Object? poidsUnitaire = null,
    Object? sousTotal = null,
  }) {
    return _then(
      _value.copyWith(
            nom: null == nom
                ? _value.nom
                : nom // ignore: cast_nullable_to_non_nullable
                      as String,
            quantite: null == quantite
                ? _value.quantite
                : quantite // ignore: cast_nullable_to_non_nullable
                      as int,
            prixUnitaire: null == prixUnitaire
                ? _value.prixUnitaire
                : prixUnitaire // ignore: cast_nullable_to_non_nullable
                      as double,
            poidsUnitaire: null == poidsUnitaire
                ? _value.poidsUnitaire
                : poidsUnitaire // ignore: cast_nullable_to_non_nullable
                      as double,
            sousTotal: null == sousTotal
                ? _value.sousTotal
                : sousTotal // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProduitModelImplCopyWith<$Res>
    implements $ProduitModelCopyWith<$Res> {
  factory _$$ProduitModelImplCopyWith(
    _$ProduitModelImpl value,
    $Res Function(_$ProduitModelImpl) then,
  ) = __$$ProduitModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String nom,
    int quantite,
    double prixUnitaire,
    double poidsUnitaire,
    double sousTotal,
  });
}

/// @nodoc
class __$$ProduitModelImplCopyWithImpl<$Res>
    extends _$ProduitModelCopyWithImpl<$Res, _$ProduitModelImpl>
    implements _$$ProduitModelImplCopyWith<$Res> {
  __$$ProduitModelImplCopyWithImpl(
    _$ProduitModelImpl _value,
    $Res Function(_$ProduitModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProduitModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nom = null,
    Object? quantite = null,
    Object? prixUnitaire = null,
    Object? poidsUnitaire = null,
    Object? sousTotal = null,
  }) {
    return _then(
      _$ProduitModelImpl(
        nom: null == nom
            ? _value.nom
            : nom // ignore: cast_nullable_to_non_nullable
                  as String,
        quantite: null == quantite
            ? _value.quantite
            : quantite // ignore: cast_nullable_to_non_nullable
                  as int,
        prixUnitaire: null == prixUnitaire
            ? _value.prixUnitaire
            : prixUnitaire // ignore: cast_nullable_to_non_nullable
                  as double,
        poidsUnitaire: null == poidsUnitaire
            ? _value.poidsUnitaire
            : poidsUnitaire // ignore: cast_nullable_to_non_nullable
                  as double,
        sousTotal: null == sousTotal
            ? _value.sousTotal
            : sousTotal // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProduitModelImpl extends _ProduitModel {
  const _$ProduitModelImpl({
    required this.nom,
    required this.quantite,
    required this.prixUnitaire,
    required this.poidsUnitaire,
    required this.sousTotal,
  }) : super._();

  factory _$ProduitModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProduitModelImplFromJson(json);

  @override
  final String nom;
  @override
  final int quantite;
  @override
  final double prixUnitaire;
  @override
  final double poidsUnitaire;
  @override
  final double sousTotal;

  @override
  String toString() {
    return 'ProduitModel(nom: $nom, quantite: $quantite, prixUnitaire: $prixUnitaire, poidsUnitaire: $poidsUnitaire, sousTotal: $sousTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProduitModelImpl &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.quantite, quantite) ||
                other.quantite == quantite) &&
            (identical(other.prixUnitaire, prixUnitaire) ||
                other.prixUnitaire == prixUnitaire) &&
            (identical(other.poidsUnitaire, poidsUnitaire) ||
                other.poidsUnitaire == poidsUnitaire) &&
            (identical(other.sousTotal, sousTotal) ||
                other.sousTotal == sousTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nom,
    quantite,
    prixUnitaire,
    poidsUnitaire,
    sousTotal,
  );

  /// Create a copy of ProduitModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProduitModelImplCopyWith<_$ProduitModelImpl> get copyWith =>
      __$$ProduitModelImplCopyWithImpl<_$ProduitModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProduitModelImplToJson(this);
  }
}

abstract class _ProduitModel extends ProduitModel {
  const factory _ProduitModel({
    required final String nom,
    required final int quantite,
    required final double prixUnitaire,
    required final double poidsUnitaire,
    required final double sousTotal,
  }) = _$ProduitModelImpl;
  const _ProduitModel._() : super._();

  factory _ProduitModel.fromJson(Map<String, dynamic> json) =
      _$ProduitModelImpl.fromJson;

  @override
  String get nom;
  @override
  int get quantite;
  @override
  double get prixUnitaire;
  @override
  double get poidsUnitaire;
  @override
  double get sousTotal;

  /// Create a copy of ProduitModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProduitModelImplCopyWith<_$ProduitModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
