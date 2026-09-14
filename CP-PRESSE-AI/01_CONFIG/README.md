# 01_CONFIG — Configuration du système

Contient les fichiers de configuration spécifiques au système.

## Structure

```
01_CONFIG/
├── sites/
│   ├── _template.json          ← Modèle pour ajouter un site
│   ├── geh.json
│   ├── escapade.json
│   └── mav.json
└── README.md
```

## Fichiers sites

Chaque site a un fichier JSON contenant :

- URL WordPress
- ID auteur
- Chemin vers credentials (local seulement, jamais versionné)
- Paramètres WordPress (thème, design Zeen)
- Liens Drive (Charte, Voix, Catégories)

**Format** : voir `_template.json`

## Credentials

⚠️ **Jamais committer**

Les mots de passe d'application WordPress sont stockés **uniquement** dans `.claude/wp-credentials-{site}.local.json` (racine du projet, jamais `~/.claude/`).

Ce fichier n'existe pas dans le Git. Pas de template avec `xxxx` — trop tentant.

Si besoin de recréer : `/install-site [site]` vous guide.

## Ajout d'un nouveau site

1. Copier `_template.json` en `{site}.json`
2. Remplir les champs
3. Lancer `/install-site {site}`
4. Tester `/redaction {site} "Test"`

## Indépendance

Les JSON doivent rester lisibles et modifiables par n'importe quel agent.
Format simple, pas de dépendances.
