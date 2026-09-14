# Skill : /seo

## Objectif
Optimiser les champs SEO (Yoast) d'un article brouillon avant publication.

## Syntaxe
```
/seo [site] [ID article]
/seo [site] [titre article]
```

Exemples :
```
/seo Escapade 12088
/seo GEH "Cupra Born 2026"
```

## Processus

### 1. Charger l'article
Récupérer le contenu complet via API WordPress (GET `/wp-json/wp/v2/posts/{id}`).

### 2. Analyser les champs actuels
- Focuskw (mot-clé principal)
- Titre SEO
- Métadescription
- Slug
- Liens internes

### 3. Proposer des optimisations

#### Mot-clé principal (focuskw)
- À définir si absent
- Doit apparaître dans H1, corps (100 premiers mots), metadesc
- Doit apparaître dans au moins un H2
- Doit apparaître dans l'alt de l'image Une

**Critères** :
- Pertinent pour le sujet
- Cohérent avec la voix du site
- Densité 1-2% du texte (jamais bourrage)

#### Titre SEO
- Longueur : 50-60 caractères (affichage Google)
- Inclure le focuskw
- Appétant (user-centric)
- Format : `[Principal] - [Sous-élément]` ou `[Verbe] + [Objet]`

Exemple pour "IFTM Top Résa 2026" (focuskw = "salon voyage 2026") :
- ❌ "Salon IFTM 2026 à Paris"
- ✅ "Salon IFTM 2026 : 3 destinations de rêve à réserver" (57 car)

#### Métadescription
- Longueur : 150-160 caractères (affichage complet Google)
- Inclure focuskw
- Appel à l'action implicite
- Résume le chapô

#### Slug
- Propre (sans stopwords inutiles)
- Stable (pas de `-2`, `-3` ajoutés)
- Format : `mot-clé-principal-angle`

#### Liens internes
- Minimum 2, idéal 3-4 (jamais > 5)
- Ancrage naturel (pas "cliquez ici")
- Cible pertinente (même sujet ou complément)

### 4. Appliquer les corrections
Via PATCH `/wp-json/wp/v2/posts/{id}` :

```json
{
  "meta": {
    "rank_math_focus_keyword": "mot-clé",
    "rank_math_title": "Titre SEO...",
    "rank_math_description": "Métadesc..."
  },
  "slug": "nouveau-slug"
}
```

**Note** : utilise Yoast ou Rank Math selon le site (vérifier dans les credentials).

### 5. Valider
- Relancer le score Yoast (si accès admin)
- Vérifier que le score passe à vert
- Signaler les écarts persistants

### 6. Sortie
Rapport dans `Articles/{date}-seo-{site}-{id}.md` :

```markdown
# Optimisation SEO — {site} / {titre}

## Avant
- Focuskw : ❌ absent
- Titre : 45 car (trop court)
- Métadesc : ❌ absent
- Liens : 1 (insuffisant)

## Après
- Focuskw : ✅ "salon voyage 2026"
- Titre : ✅ 57 caractères
- Métadesc : ✅ 155 caractères
- Liens : ✅ 3 (optimal)

## Résultat
Yoast SEO : 🟢 VERT
```

## Règles

- Ne jamais sacrifier le ton éditorial pour le SEO
- Focuskw toujours dans H1 (règle non négociable)
- Si Yoast reste rouge après optimization, signaler l'anomalie
- Jamais modifier le contenu principal (H1-H3, texte)
- Liens internes : vérifier que les URLs existent avant d'appliquer

## Remarques

Cette skill modifie un article brouillon — demander confirmation avant PATCH.
