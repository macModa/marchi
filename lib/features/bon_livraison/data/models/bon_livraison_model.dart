import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/bon_livraison_entity.dart';

part 'bon_livraison_model.freezed.dart';
part 'bon_livraison_model.g.dart';

// ─── Root DTO ─────────────────────────────────────────────────────────────────

@freezed
class BonLivraisonModel with _$BonLivraisonModel {
  const BonLivraisonModel._();

  const factory BonLivraisonModel({
    required int orderId,
    required String numeroSuivi,
    @JsonKey(name: 'exp\u00e9diteur') required ExpediteurModel expediteur,
    required DestinataireModel destinataire,
    required List<ProduitModel> produits,
    required double poidsTotal,
    required double montantCOD,
    required String montantEnLettres,
    required String dateCreation,
    required String statut,
    required String modeReglement,
  }) = _BonLivraisonModel;

  factory BonLivraisonModel.fromJson(Map<String, dynamic> json) =>
      _$BonLivraisonModelFromJson(json);

  BonLivraisonEntity toEntity() => BonLivraisonEntity(
        orderId: orderId,
        numeroSuivi: numeroSuivi,
        expediteur: expediteur.toEntity(),
        destinataire: destinataire.toEntity(),
        produits: produits.map((p) => p.toEntity()).toList(),
        poidsTotal: poidsTotal,
        montantCOD: montantCOD,
        montantEnLettres: montantEnLettres,
        dateCreation: dateCreation,
        statut: statut,
        modeReglement: modeReglement,
      );
}

// ─── Expediteur ───────────────────────────────────────────────────────────────

@freezed
class ExpediteurModel with _$ExpediteurModel {
  const ExpediteurModel._();

  const factory ExpediteurModel({
    required String nom,
    required String nomBoutique,
    required String ville,
    required String telephone,
  }) = _ExpediteurModel;

  factory ExpediteurModel.fromJson(Map<String, dynamic> json) =>
      _$ExpediteurModelFromJson(json);

  ExpediteurEntity toEntity() => ExpediteurEntity(
        nom: nom,
        nomBoutique: nomBoutique,
        ville: ville,
        telephone: telephone,
      );
}

// ─── Destinataire ─────────────────────────────────────────────────────────────

@freezed
class DestinataireModel with _$DestinataireModel {
  const DestinataireModel._();

  const factory DestinataireModel({
    required String nom,
    required String adresseLivraison,
    required String codePostal,
    required String telephone,
  }) = _DestinataireModel;

  factory DestinataireModel.fromJson(Map<String, dynamic> json) =>
      _$DestinataireModelFromJson(json);

  DestinataireEntity toEntity() => DestinataireEntity(
        nom: nom,
        adresseLivraison: adresseLivraison,
        codePostal: codePostal,
        telephone: telephone,
      );
}

// ─── Produit ──────────────────────────────────────────────────────────────────

@freezed
class ProduitModel with _$ProduitModel {
  const ProduitModel._();

  const factory ProduitModel({
    required String nom,
    required int quantite,
    required double prixUnitaire,
    required double poidsUnitaire,
    required double sousTotal,
  }) = _ProduitModel;

  factory ProduitModel.fromJson(Map<String, dynamic> json) =>
      _$ProduitModelFromJson(json);

  ProduitEntity toEntity() => ProduitEntity(
        nom: nom,
        quantite: quantite,
        prixUnitaire: prixUnitaire,
        poidsUnitaire: poidsUnitaire,
        sousTotal: sousTotal,
      );
}
