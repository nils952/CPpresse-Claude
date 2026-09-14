# Skill : /audit

## Objectif
Analyser un site en profondeur : structure SEO, doublons, contenus, auteurs, santé générale.

## Syntaxe
```
/audit [site]
/audit [site] --deep
```

Exemples :
```
/audit GEH
/audit Escapade --deep
```

## Processus

### 1. Audit structurel

#### Catégories
- Liste complète des catégories (via API)
- Nombre d'articles par catégorie
- Catégories vides (à supprimer ?)
- Hiérarchie respectée (parent/enfant)

#### Tags
- Nombre total de tags
- Tags à moins de 2 articles (à fusionner ?)
- Doublons (variantes : "électrique" vs "Électrique")

#### Auteurs
- Liste des auteurs WordPress
- Nombre d'articles par auteur
- Auteurs sans bio (à compléter)

### 2. Audit contenu

#### Doublons
- Chercher les slugs trop proches (fuzzy matching)
- Chercher les titres identiques (casés différemment)
- Chercher les angles proches (20+ articles sur le même sujet)

#### Conformité Charte
Pour un échantillon de 5-10 articles récents :

- Longueur : 500-1200 mots ?
- Structure : H1, H2, chapô ?
- Liens internes : minimum 2 ?
- Image Une : présente, résolution OK ?
- Yoast SEO : vert ?

#### Brouillons orphelins
- Brouillons créés il y a > 30 jours
- Brouillons sans image
- Brouillons sans Yoast renseigné

### 3. Audit technique

#### Images
- Nombre total d'images
- Résolution moyenne (hero vs inline)
- Alt textes manquants (% des images)
- Poids moyen des images

#### SEO global
- Nombre d'URLs publiées
- Taux de couverture Yoast (% articles verts)
- Meta descriptions manquantes
- Slugs dupliqués

#### Liens cassés (optionnel, --deep)
- Crawl des liens internes
- Liens sortants 404
- Listes de liens à corriger

### 4. Audit WordPress

#### Plugins
- Plugins actifs (liste)
- Mises à jour disponibles
- Incompatibilités détectées

#### Thème
- Thème actif (version)
- Personnalisations appliquées
- Widgets mal configurés

#### Configuration
- Permalink structure
- Timezone
- Langue
- Plan de site XML activé

### 5. Sortie

Rapport complet dans `Audits/{date}-audit-{site}.md` :

```markdown
# Audit {site} — {date}

## 📊 Chiffres clés
- Articles publiés : 1254
- Brouillons : 8
- Catégories : 12
- Tags : 89 (8 à fusionner)
- Images : 3402 (78 sans alt)

## 🔴 Problèmes critiques

### Brouillons orphelins
- ID 12019 : créé 2026-09-09, 3j en attente
- ID 12053 : créé 2026-09-09, image manquante

### Images à résolution faible
- ID 875 : 374×225px (trop petit pour Hero)
- ID 1203 : 600×400px (limite)

## 🟡 À corriger

### Yoast SEO
- 23 articles (1.8%) : Yoast rouge ou orange
- 45 articles : focuskw absent

### Doublons de tags
- "électrique" vs "Électrique" (fusion possible)
- "Essai test" vs "Essai" (à clarifier)

### Auteurs sans bio
- claude-editorial (GEH)
- nils-martin (MAV)

## 🟢 Points positifs
- Aucun lien cassé détecté
- Slugs tous propres (pas de `-2`, `-3`)
- Thème à jour (Zeen v5.2)

## Recommandations
1. Fusionner tags "électrique"
2. Compléter bios auteurs (5 min)
3. Corriger les 23 articles Yoast rouge
4. Remplacer les 78 images sans alt (source : audit images séparé)

## Reste à faire (--deep)
- Crawl liens sortants (404)
- Analyse plugin compatibility
```

## Règles

- Ne jamais modifier le site pendant l'audit
- Audit simple : 5-10 min, lecture seule
- Audit --deep : 15-20 min, peut inclure API calls
- Ne pas supprimer de catégories/tags sans demander
- Signaler mais ne pas corriger automatiquement

## Remarques

Cette skill nécessite l'accès API WordPress complet. À lancer après `/brouillons` pour une vue d'ensemble.
