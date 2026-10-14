# Marchi — Marketplace Artisanale Tunisienne

**Marchi** est une application mobile full-stack connectant les artisans tunisiens à leurs clients. Les artisans y gèrent leur boutique et leurs produits ; les clients parcourent, recherchent et commandent des articles artisanaux authentiques.

La livraison est gérée via un système de bons de livraison sécurisés avec QR code et un réseau de points relais basé sur les codes postaux tunisiens.

## 🎬 Démonstration vidéo

**Découvrez Marchi en action :** la vidéo présente le workflow complet de l'application, de la navigation dans le catalogue jusqu'à la gestion des commandes et au processus de livraison.

▶️ **[Regarder la démonstration complète sur LinkedIn](https://lnkd.in/p/eEx9zK7g)**

## 📋 Table des matières

- [Démonstration vidéo](#-démonstration-vidéo)
- [Stack technique](#-stack-technique)
- [Architecture](#-architecture)
- [Fonctionnalités](#-fonctionnalités)
- [Modèle de données](#-modèle-de-données)
- [Rôles et permissions](#-rôles-et-permissions)
- [Installation](#-installation)
- [Méthodologie](#-méthodologie)
- [État du projet](#-état-du-projet)
- [Roadmap](#-roadmap)

---

## Stack Technique

| Couche | Technologie |
|---|---|
| Mobile | Flutter |
| State Management | Riverpod avec Generator |
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

```text
Controller  →  Service  →  Repository  →  MySQL
     ↕              ↕
    DTO         Entity (JPA)
     ↕
  Security (JWT)
```

- **Controller** : endpoints REST et gestion des requêtes HTTP.
- **Service** : logique métier et transactions `@Transactional`.
- **Repository** : accès aux données via Spring Data JPA.
- **Entity** : modèles de domaine mappés en base.
- **DTO** : objets d'échange avec le frontend mobile, isolant les entités JPA.
- **Security** : authentification stateless JWT.

### Frontend — Architecture Feature-First

```text
features/
├── auth/
├── products/
├── orders/
├── payments/
├── bon_livraison/
└── delivery/
```

Chaque feature est autonome et contient ses propres écrans, providers, services et modèles.

---

## Fonctionnalités

### Authentification et autorisation

- Inscription et connexion via JWT.
- Contrôle d'accès par rôle : `ADMIN`, `ARTISAN`, `CLIENT`.
- Token stocké de manière sécurisée côté mobile.

### Gestion des produits

- Catalogue paginé avec recherche par mot-clé et filtre par catégorie.
- Fiche produit détaillée.
- Upload d'images via multipart.
- Gestion complète des produits par l'artisan : création, modification et suppression.

### Commandes

- Création de commande par le client.
- Historique des commandes pour le client et l'administrateur.
- Annulation de commande par le client.
- Mise à jour du statut par l'administrateur.

### Paiements

- Création d'un paiement lié à une commande.
- Suivi des statuts : `PENDING`, `COMPLETED`, `FAILED`, `REFUNDED`.
- Gestion administrative des paiements.

### Bons de livraison avec QR code

Un système de génération de bons de livraison PDF est intégré pour couvrir le cycle de livraison.

**Génération par l'artisan :**
- Génération d'un bon PDF depuis l'interface.
- Informations expéditeur et destinataire.
- Tableau des produits avec poids et montants.
- Montant en toutes lettres en français.
- Zone de signature du client.
- QR code unique et sécurisé.

**Validation par le client :**
- Scan du QR code à la réception du colis.
- Vérification de l'identité du client associé à la commande.
- Vérification de l'expiration du token.
- Confirmation de la livraison et mise à jour du statut.

```text
Artisan → Génération du bon PDF
        → QR code signé avec expiration
        → Scan par le client à la réception
        → Vérification côté backend
        → Commande marquée comme LIVRÉE
```

### Livraison via codes postaux tunisiens

- Table normalisée et indexée des codes postaux tunisiens.
- Sélection de points relais par code postal.
- API interne `/validate-address` exposée au frontend Flutter.
- Cohérence des données entre mobile et backend.

### Messagerie WhatsApp

- Communication directe entre client et artisan via URL Scheme WhatsApp.
- Aucun stockage intermédiaire des messages côté serveur.

---

## Modèle de données

```text
User (abstrait — héritage JOINED)
├── Client
└── Artisan

Category
Product
Order
├── OrderLine
└── Payment

BonLivraison
DeliveryToken
PostalCode
RelayPoint
```

- `User` : utilisateur de base.
- `Client` : passe des commandes.
- `Artisan` : gère sa boutique.
- `Category` : hiérarchie des catégories de produits.
- `Product` : produit lié à un artisan et à une catégorie.
- `Order` : commande passée par un client.
- `OrderLine` : produit, quantité et prix.
- `Payment` : paiement associé à une commande.
- `BonLivraison` : document PDF associé à une commande.
- `DeliveryToken` : token de QR code signé avec expiration.
- `PostalCode` : code postal tunisien.
- `RelayPoint` : point relais associé à un code postal.

---

## Rôles et permissions

| Rôle | Permissions |
|---|---|
| `CLIENT` | Parcourir, commander, payer et scanner le QR de livraison |
| `ARTISAN` | Gérer ses produits et générer les bons de livraison |
| `ADMIN` | Gestion des commandes, paiements et utilisateurs |

---

## Installation

### Backend — Spring Boot

```bash
# 1. Créer la base de données
mysql -u root -p -e "CREATE DATABASE marketplace_db;"

# 2. Configurer application.yml
# Renseigner l'URL, le nom d'utilisateur et le mot de passe MySQL.

# 3. Lancer le backend
mvn spring-boot:run
```

### Frontend — Flutter

```bash
# 1. Installer les dépendances
flutter pub get

# 2. Générer le code nécessaire
dart run build_runner build --delete-conflicting-outputs

# 3. Lancer l'application
flutter run
```

Mettre à jour l'URL de base de l'API dans `lib/core/constants/api_constants.dart`.

---

## Méthodologie

Le projet a été développé selon la méthodologie **Agile Scrum**, organisée en quatre sprints de deux semaines.

| Sprint | Objectif |
|---|---|
| Sprint 1 | Authentification JWT et architecture de base |
| Sprint 2 | Produits, catégories et gestion artisan |
| Sprint 3 | Commandes, paiements et administration |
| Sprint 4 | Bons de livraison QR, codes postaux et WhatsApp |

---

## État du projet

| Fonctionnalité | Statut |
|---|---|
| Authentification JWT | ✅ Terminé |
| Gestion des produits et catégories | ✅ Terminé |
| Commandes et paiements | ✅ Terminé |
| Bons de livraison PDF avec QR code | ✅ Terminé |
| Codes postaux tunisiens | ✅ Terminé |
| Intégration WhatsApp | ✅ Terminé |
| Dashboard artisan avancé | 🔄 En cours |
| Notifications en temps réel | 🔄 En cours |
| Filtres avancés par prix et localisation | 🔄 En cours |

---

## Roadmap

- **Court terme** : avis et notes sur les produits.
- **Moyen terme** : intégration de passerelles de paiement tunisiennes.
- **Long terme** : moteur de recommandation basé sur les préférences des utilisateurs.

---

## Licence

Projet éducatif développé dans le cadre d'un PFE, autour de la valorisation de l'artisanat tunisien.

Les contributions sont les bienvenues via Pull Request, dans le respect de l'architecture et des conventions de nommage du projet.

---

**Développé avec Flutter, Spring Boot et MySQL.**

🎬 [Voir la démonstration complète de Marchi](https://lnkd.in/p/eEx9zK7g) · 💻 [Consulter le code source](https://github.com/macModa/marchi)
