// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bon_livraison_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BonLivraisonModelImpl _$$BonLivraisonModelImplFromJson(
  Map<String, dynamic> json,
) => _$BonLivraisonModelImpl(
  orderId: (json['orderId'] as num).toInt(),
  numeroSuivi: json['numeroSuivi'] as String,
  expediteur: ExpediteurModel.fromJson(
    json['expéditeur'] as Map<String, dynamic>,
  ),
  destinataire: DestinataireModel.fromJson(
    json['destinataire'] as Map<String, dynamic>,
  ),
  produits: (json['produits'] as List<dynamic>)
      .map((e) => ProduitModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  poidsTotal: (json['poidsTotal'] as num).toDouble(),
  montantCOD: (json['montantCOD'] as num).toDouble(),
  montantEnLettres: json['montantEnLettres'] as String,
  dateCreation: json['dateCreation'] as String,
  statut: json['statut'] as String,
  modeReglement: json['modeReglement'] as String,
);

Map<String, dynamic> _$$BonLivraisonModelImplToJson(
  _$BonLivraisonModelImpl instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'numeroSuivi': instance.numeroSuivi,
  'expéditeur': instance.expediteur,
  'destinataire': instance.destinataire,
  'produits': instance.produits,
  'poidsTotal': instance.poidsTotal,
  'montantCOD': instance.montantCOD,
  'montantEnLettres': instance.montantEnLettres,
  'dateCreation': instance.dateCreation,
  'statut': instance.statut,
  'modeReglement': instance.modeReglement,
};

_$ExpediteurModelImpl _$$ExpediteurModelImplFromJson(
  Map<String, dynamic> json,
) => _$ExpediteurModelImpl(
  nom: json['nom'] as String,
  nomBoutique: json['nomBoutique'] as String,
  ville: json['ville'] as String,
  telephone: json['telephone'] as String,
);

Map<String, dynamic> _$$ExpediteurModelImplToJson(
  _$ExpediteurModelImpl instance,
) => <String, dynamic>{
  'nom': instance.nom,
  'nomBoutique': instance.nomBoutique,
  'ville': instance.ville,
  'telephone': instance.telephone,
};

_$DestinataireModelImpl _$$DestinataireModelImplFromJson(
  Map<String, dynamic> json,
) => _$DestinataireModelImpl(
  nom: json['nom'] as String,
  adresseLivraison: json['adresseLivraison'] as String,
  codePostal: json['codePostal'] as String,
  telephone: json['telephone'] as String,
);

Map<String, dynamic> _$$DestinataireModelImplToJson(
  _$DestinataireModelImpl instance,
) => <String, dynamic>{
  'nom': instance.nom,
  'adresseLivraison': instance.adresseLivraison,
  'codePostal': instance.codePostal,
  'telephone': instance.telephone,
};

_$ProduitModelImpl _$$ProduitModelImplFromJson(Map<String, dynamic> json) =>
    _$ProduitModelImpl(
      nom: json['nom'] as String,
      quantite: (json['quantite'] as num).toInt(),
      prixUnitaire: (json['prixUnitaire'] as num).toDouble(),
      poidsUnitaire: (json['poidsUnitaire'] as num).toDouble(),
      sousTotal: (json['sousTotal'] as num).toDouble(),
    );

Map<String, dynamic> _$$ProduitModelImplToJson(_$ProduitModelImpl instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'quantite': instance.quantite,
      'prixUnitaire': instance.prixUnitaire,
      'poidsUnitaire': instance.poidsUnitaire,
      'sousTotal': instance.sousTotal,
    };
