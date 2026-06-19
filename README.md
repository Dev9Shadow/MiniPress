# MiniPress

Mini CMS headless développé dans le cadre de la SAE S4 (BUT Informatique, IUT Nancy-Charlemagne).

MiniPress permet de créer et publier des articles classés par catégorie, exposés via une API JSON et consultables depuis une webapp et une application mobile.

## Architecture

Le projet est composé de trois applications indépendantes, dockerisées :

| Composant | Rôle | Stack |
|---|---|---|
| **minipress.core** | Backend headless : API JSON publique + interface d'administration HTML | PHP 8.2, Slim 4, Twig, Eloquent, MariaDB |
| **minipress.web** | Webapp de consultation des articles dans le navigateur | TypeScript, Handlebars, esbuild |
| **minipress.app** | Application mobile de consultation des articles | Flutter / Dart |

`minipress.web` et `minipress.app` consomment uniquement l'API JSON exposée par `minipress.core`. Seule l'interface d'administration de `minipress.core` permet de créer du contenu (articles, catégories, utilisateurs).

## Démarrage local

```bash
cd minipress.core
docker compose up -d
```

L'application est ensuite disponible sur `http://localhost:57320`, l'API sur `/api`, et Adminer sur `57321` pour consulter la base de données.

Pour la webapp JS :
```bash
cd minipress.web
npm install
npm run deploy
```

Pour l'application mobile :
```bash
cd minipress.app
flutter pub get
flutter run
```

## Équipe et répartition des tâches

Projet réalisé par une équipe de 4 étudiants. Chacun avait une branche de référence (`socle-docker`, `api`, `auth`, `admin-contenu`) mais a contribué sur les trois composants (core, web, app) selon les besoins.

### minipress.core (backend PHP/Slim)

| Membre | Contribution |
|---|---|
| **Eliot Schmitt** | Socle Docker (Slim, MariaDB, Nginx), modèles Eloquent (`Article`, `Categorie`, `Utilisateur`), exceptions métier, gestion des merges |
| **Romain Santilli** | API de lecture (listing articles/catégories/auteurs), correctifs des services (`CategorieService`, `ArticleService`, `UtilisateurService`), formulaires admin, déploiement sur docketu |
| **Mathéo Peiro** | Authentification admin (connexion/déconnexion, sessions, CSRF), `AuthService` et `UtilisateurService` (hash bcrypt), vues Twig de connexion |
| **Erdal Cinar** | Gestion du contenu admin (création de catégories et d'utilisateurs), jeu de données de test (seed SQL) |

### minipress.web (webapp TypeScript)

| Membre | Contribution |
|---|---|
| **Eliot Schmitt** | Initialisation du projet, Dockerfile/Nginx, interfaces TypeScript (`Article`, `Categorie`, `Auteur`) |
| **Romain Santilli** | `api.ts` (endpoints, tri, résumé dans les listes), filtrage par titre (F7) et titre+résumé (F8) |
| **Erdal Cinar** | `ApiService` (appels API, gestion des erreurs réseau), templates HTML/Handlebars, style.css, recherche et tri dans le header |
| **Mathéo Peiro** | `main.ts` (navigation articles/catégories/auteurs), `ui.ts` (rendu Handlebars, conversion markdown) |

### minipress.app (application mobile Flutter)

| Membre | Contribution |
|---|---|
| **Eliot Schmitt** | Initialisation du projet Flutter, modèles Dart (`Article`, `Categorie`, `Auteur`) |
| **Romain Santilli** | Écran principal et navigation, correctifs UI (menu burger, tri), configuration de l'API et déploiement |
| **Mathéo Peiro** | Widgets (`ArticleCard`), fonctionnalités de tri et filtrage (date, titre, résumé), navigation par catégorie/auteur |
| **Erdal Cinar** | `ApiService` et `ApiException` (appels API, gestion des erreurs réseau) |

Toutes les branches ont été fusionnées dans `dev`, puis `dev` a été fusionné dans `main` avant déploiement.

## Déploiement

L'ensemble du projet (API + Admin + Webapp) est déployé via Docker Compose sur `docketu.iutnc.univ-lorraine.fr`.
