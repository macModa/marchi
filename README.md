# Marchi — Marketplace Artisanale Tunisienne

Marchi est une application mobile full-stack connectant les artisans tunisiens à leurs clients. Les artisans y gèrent leur boutique et leurs produits ; les clients parcourent, recherchent et commandent des articles artisanaux authentiques. La livraison est gérée via un système de bons de livraison sécurisés avec QR code et un réseau de points relais basé sur les codes postaux tunisiens.

---

## Stack Technique

| Couche | Technologie |
|---|---|
| Mobile | Flutter |
| State Management | Riverpod (avec Generator) |
| Networking | Dio |
| Stockage local | Flutter Secure Storage (JWT), Shared Preferences |
| Backend | Spring Boot 3 — REST API |
| Sécurité | Spring Security + JWT |
| Base de données | MySQL 8 |
| Persistance | Spring Data JPA / Hibernate |
| Langage backend | Java 17 |

---

## Architecture

### Backend — Architecture en couches

```
Controller  →  Service  →  Repository  →  MySQL
     ↕              ↕
    DTO         Entity (JPA)
     ↕
  Security (JWT)
```

- **Controller** : endpoints REST, gestion des requêtes HTTP
- **Service** : logique métier et transactions `@Transactional`
- **Repository** : accès aux données via Spring Data JPA
- **Entity** : modèles de domaine mappés en base
- **DTO** : objets d'échange avec le frontend mobile (isolation des entités JPA)
- **Security** : authentification stateless JWT

### Frontend — Architecture Feature-First

```
features/
├── auth/
├── products/
├── orders/
├── payments/
├── bon_livraison/
└── delivery/
```

Chaque feature est autonome et contient ses propres screens, providers, services et modèles.

---

## Fonctionnalités

### Authentification & Autorisation
- Inscription et connexion (JWT)
- Contrôle d'accès par rôle : `ADMIN`, `ARTISAN`, `CLIENT`
- Token stocké de manière sécurisée côté mobile

### Gestion des Produits
- Catalogue paginé avec recherche par mot-clé et filtre par catégorie
- Fiche produit détaillée
- Upload d'images (multipart)
- Gestion complète pour l'artisan (Créer, Modifier, Supprimer)

### Commandes
- Création de commande (Client)
- Historique des commandes (Client / Admin)
- Annulation de commande (Client)
- Mise à jour du statut (Admin)

### Paiements
- Création de paiement lié à une commande
- Suivi du statut : `PENDING`, `COMPLETED`, `FAILED`, `REFUNDED`
- Gestion admin des paiements

### Bon de Livraison avec QR Code

Un système sécurisé de bons de livraison PDF est intégré, couvrant l'ensemble du cycle de livraison.

**Génération (Artisan) :**
- L'artisan génère un bon de livraison PDF officiel depuis son interface
- Le bon inclut : expéditeur / destinataire, tableau des produits avec poids, montant en toutes lettres en français (ex. : *Cent quarante-cinq dinars et cinq cents millimes*), zone de signature client
- Un QR code unique et sécurisé est intégré au document

**Validation (Client) :**
- Le client scanne le QR code via l'application mobile à la réception du colis
- Le backend vérifie que le scanner est bien le client associé à la commande
- La livraison est confirmée et le statut mis à jour

**Flux de sécurité :**
```
Artisan  →  génère le bon PDF (vérification propriété commande)
     ↓
   QR Code unique (token signé, durée limitée)
     ↓
Client  →  scanne le QR code à la réception
     ↓
Backend  →  valide l'identité du client + expiration du token
     ↓
Commande  →  statut mis à jour : LIVRÉ
```

### Livraison via Codes Postaux Tunisiens
- Table normalisée et indexée des codes postaux tunisiens
- Sélection de points relais par code postal
- API interne `/validate-address` exposée au frontend Flutter
- Cohérence garantie des données entre mobile et backend

### Messagerie WhatsApp
- Communication directe client-artisan via URL Scheme WhatsApp
- Aucun stockage intermédiaire côté serveur
- Intégration native et légère

---

## Modèle de Données

```
User (abstrait — héritage JOINED)
├── Client        → passe des commandes
└── Artisan       → gère une boutique

Category          → hiérarchie de produits
Product           → rattaché à un Artisan et une Category
Order             → passée par un Client
├── OrderLine     → produit + quantité + prix
└── Payment       → transaction liée à la commande

BonLivraison      → document PDF lié à une commande
DeliveryToken     → QR code signé avec expiration
PostalCode        → table normalisée des codes postaux TN
RelayPoint        → point relais lié à un code postal
```

---

## Rôles & Permissions

| Rôle | Permissions |
|---|---|
| `CLIENT` | Parcourir, commander, payer, scanner le QR de livraison |
| `ARTISAN` | Gérer ses produits, générer les bons de livraison |
| `ADMIN` | Accès complet : commandes, paiements, utilisateurs |

---

## Installation

### Backend (Spring Boot)

```bash
# 1. Créer la base de données
mysql -u root -p -e "CREATE DATABASE marketplace_db;"

# 2. Configurer application.yml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/marketplace_db
    username: votre_username
    password: votre_password

# 3. Lancer
mvn spring-boot:run
```

### Frontend (Flutter)

```bash
# 1. Nettoyer et installer les dépendances
flutter clean
flutter pub get

# 2. Générer le code (Riverpod, Freezed, JSON)
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Lancer
flutter run
# ou sur navigateur Edge pour les tests
flutter run -d edge
```

> Mettre à jour l'URL de base de l'API dans `lib/core/constants/api_constants.dart`.

---

## Méthodologie

Le projet a été développé selon la méthodologie **Agile Scrum**, organisée en **4 sprints de 2 semaines** :

| Sprint | Objectif |
|---|---|
| Sprint 1 | Authentification JWT, architecture de base |
| Sprint 2 | Produits, catégories, gestion artisan |
| Sprint 3 | Commandes, paiements, tableau de bord admin |
| Sprint 4 | Bon de livraison QR, codes postaux, WhatsApp |

---

## État du Projet

| Fonctionnalité | Statut |
|---|---|
| Authentification JWT | ✅ Terminé |
| Gestion produits & catégories | ✅ Terminé |
| Commandes & paiements | ✅ Terminé |
| Bon de livraison PDF + QR | ✅ Terminé |
| Codes postaux tunisiens | ✅ Terminé |
| Messagerie WhatsApp | ✅ Terminé |
| Dashboard artisan avancé | 🔄 En cours |
| Notifications temps réel | 🔄 En cours |
| Filtres avancés (prix, localisation) | 🔄 En cours |

---

## Roadmap

- **Court terme** : Avis et notes sur les produits
- **Moyen terme** : Intégration des passerelles de paiement tunisiennes locales
- **Long terme** : Moteur de recommandation basé sur les préférences utilisateur

---

## Licence

Projet éducatif développé pour la communauté artisanale tunisienne — PFE.
Les contributions sont les bienvenues via Pull Request, dans le respect de l'architecture et des conventions de nommage établies.
