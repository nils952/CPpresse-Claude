# Skill : /veille

## Objectif
Identifier et proposer des sujets d'articles pour un site donné, basé sur les tendances, l'actu, et les archives.

## Syntaxe
```
/veille [site] [nombre d'articles]
```

Exemples :
```
/veille GEH 3
/veille Escapade 5
/veille MAV
```

## Processus

### 1. Charger les documents
- Voix éditoriale du site (Drive)
- Historique des sujets traités (`Articles/_sujets-traites.md`)
- Catégories du site (table de référence)

### 2. Recherche web
- Tendances de la semaine dans le secteur du site
- Actu pertinente pour le lectorat
- Calendrier événementiel

### 3. Anti-doublon
Vérifier chaque proposition contre `_sujets-traites.md` — rejeter les angles déjà traités.

### 4. Propositions
Pour chaque sujet, fournir :

- **Titre proposé** : accrocheur
- **Angle** : le point de vue unique
- **Intérêt éditorial** : pourquoi c'est bon pour ce site
- **Cible lecteur** : qui va lire
- **Priorité** : immédiat / semaine / backlist
- **Source** : URL ou type d'info
- **Exclusivité possible** : oui/non/comment

### 5. Sortie
Ranger dans `Articles/{date}-veille-{site}.md` avec la structure :

```markdown
# Veille {site} — {date}

| Titre | Angle | Priorité | Source | Notes |
|---|---|---|---|---|
| ... | ... | IMMÉDIAT | ... | ... |
```

## Règles

- Jamais inventer une tendance
- Sources vérifiables uniquement
- Respecter le ton du site
- Minimum 2 sujets par demande

## Remarques

Cette skill lance une recherche web — à autoriser manuellement la 1ère fois.
