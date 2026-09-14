# Skill : /brouillons

## Objectif
Analyser les brouillons WordPress d'un site et les classer par statut (prêt/à corriger/incomplet).

## Syntaxe
```
/brouillons [site]
```

Exemples :
```
/brouillons GEH
/brouillons Escapade
/brouillons MAV
```

## Processus

### 1. Récupérer les brouillons
Via l'API WordPress du site (GET `/wp-json/wp/v2/posts?status=draft&per_page=100`).

Nécessite credentials WordPress valides (voir `.claude/wp-credentials-{site}.local.json`, source unique projet — cf. `CP-PRESSE-AI/01_CONFIG/CREDENTIALS_RULES.md`).

### 2. Analyser chaque brouillon

Pour chaque article, vérifier :

#### ✅ Yoast SEO (obligatoire avant publication)
- Focuskw défini et présent dans H1, corps, metadesc
- Titre SEO : 50-60 caractères
- Métadesc : 150-160 caractères
- Score Yoast : VERT (rouge = publication impossible)
- Lisibilité : orange minimum (vert idéal)

#### ✅ Images
- Image Une présente (1600×900px min)
- Alt texte renseigné et pertinent
- Crédit/légende si nécessaire

#### ✅ Contenu
- Au moins 2 liens internes
- Pas de 3 phrases consécutives début identique
- Aucun emoji
- Pas de tiret long (—)
- Catégorie correcte
- Tags > 0

#### ✅ Métadonnées WordPress
- Auteur défini
- Slug propre et stable

### 3. Classer les brouillons

#### 🟢 **PRÊT À PUBLIER**
Tous les critères OK. À relire avant publication.

#### 🟡 **À CORRIGER**
Blocages faciles : Yoast rouge, image manquante, tags manquants.

#### 🔴 **INCOMPLET**
Rédaction inachevée, pas d'angle clair, structure cassée.

### 4. Sortie

Tableau récapitulatif rangé dans `Articles/{date}-brouillons-{site}.md` :

```markdown
# Brouillons {site} — {date}

## 🟢 Prêt à publier

| ID | Titre | Image | Yoast | Tags | Notes |
|---|---|---|---|---|---|
| 12088 | IFTM 2026 | ✓ | VERT | 5 | À lire + publier |

## 🟡 À corriger

| ID | Titre | Blocage | Action |
|---|---|---|---|
| 12053 | Cap-Vert | Photo manquante | Sourcer ITCV |

## 🔴 Incomplet

| ID | Titre | État |
|---|---|---|
| 12019 | Charlevoix | À relire |
```

## Règles

- Ne jamais modifier les brouillons (lecture seule)
- Signaler tout problème sans supposer une correction
- Vérifier les credentials avant de lancer
- Respecter l'ordre de priorité Yoast > images > contenu

## Remarques

Cette skill nécessite l'accès API WordPress — à tester avec `/status` au préalable.
