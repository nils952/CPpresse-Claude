# Skill : /install-site

## Objectif
Cloner et configurer un nouveau site du groupe CP Presse dans le système agent autonome.

Rendre le système entièrement transférable à un autre agent ou une autre instance.

## Syntaxe
```
/install-site [site-name]
```

Exemples :
```
/install-site enduro
/install-site trial-mag
/install-site full-attack
```

## Checklist installation

### 1. Documents Drive

#### ✅ Charte rédactionnelle V8
- Lire depuis Google Drive (dossier `00-Pilotage`)
- Chercher par titre exact (exclure `[PÉRIMÉ`, `[REMPLACÉE`, etc.)

#### ✅ Voix éditoriale du site
- Lire depuis `00-Pilotage/Voix éditoriales par site/`
- Créer si absente (voir `/veille` pour méthodologie)

#### ✅ Table des catégories
- Récupérer via API WordPress (GET `/wp-json/wp/v2/categories`)
- Documenter directement dans `CP-PRESSE-AI/01_CONFIG/sites/{site}.json` (champ `categories`), pas de fichier séparé

#### ✅ Journal d'exécution
- Créer ligne d'en-tête dans le Drive (`00-Pilotage/Journal d'exécution — CP Presse`)
- Vérifier colonne structure (date, site, contenu, ID WP, statut, notes)

### 2. Credentials WordPress

#### ✅ Créer mot de passe d'application
Sur le site WordPress :
- Connecté en admin
- Aller à Profil > Mots de passe d'application
- Créer un nouveau mot de passe pour "claude editorial"
- Copier le token généré (sera visible une seule fois)

#### ✅ Sauvegarder credentials localement
Créer `.claude/wp-credentials-[site].local.json` (racine du projet — **jamais** `~/.claude/`, voir `CP-PRESSE-AI/01_CONFIG/CREDENTIALS_RULES.md`) :

```json
{
  "site": "example-mag.fr",
  "username": "nils+claude@cppresse.fr",
  "application_password": "xxxx xxxx xxxx xxxx xxxx xxxx",
  "account_role": "compte dédié \"claude editorial\"",
  "created": "YYYY-MM-DD",
  "note": "Mot de passe d'application WordPress, usage exclusif : posts REST API via /redaction. Ne pas versionner/partager ce fichier."
}
```

**Note** : ne jamais committer ce fichier (ajouter au `.gitignore`).

#### ✅ Tester l'accès
```
curl -u "[username]:[password]" https://[site]/wp-json/wp/v2/users/me
```

Réponse attendue : `{"id":...,"name":"..."}` (HTTP 200)

### 3. Contexte site

#### ✅ Créer le fichier de contexte
**Source unique** : `CP-PRESSE-AI/01_CONFIG/sites/{site}.json` — ne jamais utiliser `.claude/site-contexts/` (chemin obsolète, abandonné). Partir de `CP-PRESSE-AI/01_CONFIG/sites/_template.json` :

```json
{
  "shortname": "enduro",
  "display_name": "Enduro Mag",
  "site_url": "enduromag.fr",
  "wordpress_url": "https://enduromag.fr",
  "wordpress_api": "https://enduromag.fr/wp-json/wp/v2",
  "author_id": 19,
  "author_name": "claude-editorial",
  "account_email": "nils+claude@cppresse.fr",
  "language": "fr",
  "timezone": "Europe/Paris",
  "theme": "Zeen",
  "theme_version": "5.2",
  "zeen_hero_design_default": 1,
  "credentials_path": ".claude/wp-credentials-enduro.local.json",
  "credentials_managed_externally": true,
  "local_docs": {
    "voice": "CP-PRESSE-AI/03_VOIX/ENDURO.md",
    "rules": "CP-PRESSE-AI/02_RULES/CHARTE_V8.md"
  },
  "categories": {
    "api_endpoint": "https://enduromag.fr/wp-json/wp/v2/categories"
  },
  "note": "Magazine moto enduro, ton technique/récit aventure",
  "created": "YYYY-MM-DD",
  "status": "active"
}
```

#### ✅ Identifier l'auteur WordPress
Via API :
```
curl -u "[creds]" https://[site]/wp-json/wp/v2/users?search=[email]
```

Récupérer `id` et `name` du compte "claude editorial".

### 4. Archives photos

#### ✅ Vérifier accès IONOS
- Lien de partage : https://c01.storage.ionos.fr/s/n4wtRz7wkQFA5Ct
- Vérifier que le site a un dossier dans `FTP CPPRESSE`

#### ✅ Documenter dans le contexte site
```json
{
  "archives_ionos_path": "/FTP CPPRESSE/ENDURO MAGAZINE"
}
```

### 5. Tâches programmées (optionnel)

#### ✅ Créer skill locale
Si besoin d'automation pour ce site :
- Copier template de `.claude/skills/veille/` (projet)
- Adapter à ce site
- Configurer via `/schedule` ou `CronCreate`

### 6. Documenter dans MEMORY

#### ✅ Créer entrée mémoire
Ajouter dans `memory/MEMORY.md` :

```markdown
- [Installation {site}](install-{site}.md) — {date} : accès configuré, contexte prêt
```

Fichier détaillé : `memory/install-{site}.md`

```markdown
---
name: install-{site}
description: Configuration du site {site} pour l'agent autonome
metadata:
  type: project
---

## Site : {site}

**URL** : https://[domain]
**Credentials** : .claude/wp-credentials-{site}.local.json
**Contexte** : CP-PRESSE-AI/01_CONFIG/sites/{site}.json
**Voix éditoriale** : Drive (00-Pilotage/Voix éditoriales par site)
**Catégories** : récupérées via API

**Statut** : ✅ Opérationnel
**Date install** : YYYY-MM-DD
**Installé par** : [agent]

### Blocages éventuels

- Aucun (ou liste)

### Documents Drive à charger

1. Charte V8 ✅
2. Voix éditoriale ✅
3. Catégories ✅
4. Journal d'exécution ✅
```

### 7. Vérifier

#### ✅ Test /redaction
Lancer une commande test :
```
/redaction [site] "Test article"
```

Vérifier :
- Charte chargée
- Voix chargée
- Catégories accessibles
- Brouillon créé (si accès OK)

#### ✅ Test /brouillons
```
/brouillons [site]
```

Vérifier que l'API répond et liste les brouillons.

#### ✅ Ajouter dans status
Relancer `/status` pour inclure le nouveau site.

## Sortie

Fichier de rapport `install-{date}-{site}.md` :

```markdown
# Installation — {site}

## Résumé
Site {site} (https://[domain]) configuré le [date].

## ✅ Configurations complétées
- [ ] Charte V8 chargée
- [ ] Voix éditoriale trouvée/créée
- [ ] Credentials WordPress OK (test réussi)
- [ ] Contexte site créé
- [ ] Archives IONOS vérifiées
- [ ] Mémoire mise à jour
- [ ] Test /redaction réussi
- [ ] Test /brouillons réussi
- [ ] Inclus dans /status

## 🔲 Actions optionnelles (à faire ultérieurement)
- Créer task programmée veille hebdo
- Configurer templates Canva
- Mettre à jour wiki interne

## Reste à faire
Aucun blocage critique.

Site prêt pour production.
```

## Règles

- Ne jamais committer les credentials
- Toujours tester avant de déclarer "installé"
- Créer un audit initial après installation
- Documenter tout changement dans MEMORY
- Ne pas installer si un des 4 documents Drive est absent

## Remarques

Cette skill est la clé pour la reproductibilité du système.

À utiliser :
- Chaque nouveau site à onboarder
- Avant de transférer à un autre agent
- Comme checklist lors d'une migration
