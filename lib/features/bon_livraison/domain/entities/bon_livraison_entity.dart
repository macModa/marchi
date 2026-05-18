import 'package:equatable/equatable.dart';

// ─── Root entity ─────────────────────────────────────────────────────────────

class BonLivraisonEntity extends Equatable {
  final int orderId;
  final String numeroSuivi;
  final ExpediteurEntity expediteur;
  final DestinataireEntity destinataire;
  final List<ProduitEntity> produits;
  final double poidsTotal;
  final double montantCOD;
  final String montantEnLettres;
  final String dateCreation;
  final String statut;
  final String modeReglement;

  const BonLivraisonEntity({
    required this.orderId,
    required this.numeroSuivi,
    required this.expediteur,
    required this.destinataire,
    required this.produits,
    required this.poidsTotal,
    required this.montantCOD,
    required this.montantEnLettres,
    required this.dateCreation,
    required this.statut,
    required this.modeReglement,
  });

  @override
  List<Object?> get props => [orderId, numeroSuivi, statut];
}

// ─── Expediteur ───────────────────────────────────────────────────────────────

class ExpediteurEntity extends Equatable {
  final String nom;
  final String nomBoutique;
  final String ville;
  final String telephone;

  const ExpediteurEntity({
    required this.nom,
    required this.nomBoutique,
    required this.ville,
    required this.telephone,
  });

  @override
  List<Object?> get props => [nom, nomBoutique];
}

// ─── Destinataire ─────────────────────────────────────────────────────────────

class DestinataireEntity extends Equatable {
  final String nom;
  final String adresseLivraison;
  final String codePostal;
  final String telephone;

  const DestinataireEntity({
    required this.nom,
    required this.adresseLivraison,
    required this.codePostal,
    required this.telephone,
  });

  @override
  List<Object?> get props => [nom, codePostal];
}

// ─── Produit ──────────────────────────────────────────────────────────────────

class ProduitEntity extends Equatable {
  final String nom;
  final int quantite;
  final double prixUnitaire;
  final double poidsUnitaire;
  final double sousTotal;

  const ProduitEntity({
    required this.nom,
    required this.quantite,
    required this.prixUnitaire,
    required this.poidsUnitaire,
    required this.sousTotal,
  });

  @override
  List<Object?> get props => [nom, quantite];
}
